# MPC60 12-bit Sample Decoder

This note documents the bit-exact MPC2000XL import decoder for MPC60 packed
12-bit sample data as found in MPC60 `.SET` files.

The Kaitai specs expose the packed sample words structurally. Consumers still
need this conversion step if they want MPC2000XL-style 16-bit PCM import
behavior.

## Status

This is now a firmware-derived, bit-exact reconstruction of the MPC2000XL 1.20
MPC60 SET import path.

Validation corpus:

```text
188 SET -> MPC2000XL SND pairs
5,082,576 samples
RMSE: 0.0 PCM units
exact sample matches: 5,082,576 / 5,082,576
```

Firmware evidence:

```text
firmware: /Users/izmar/git/mame/roms/mpc2000xl/mpc2000xl_120.bin
SET unpack loop: physical/file offset 0x42c2d
sample converter: far routine 35b0:1eac, physical/file offset 0x379ac
converter state reset: physical/file offset 0x4610a
```

The earlier floating-point recurrence was a good numerical approximation, but
it is superseded by the fixed-point routine below.

## Packed Word Layout

MPC60 sample data stores two 12-bit sample words in three bytes.

For bytes:

```text
byte0 byte1 byte2
```

The two 12-bit packed words are:

```text
word0 = byte0 | ((byte1 & 0x0f) << 8)
word1 = byte2 | ((byte1 & 0xf0) << 4)
```

This is the natural little-bit-endian `b12` interpretation used by
`mpc60.set.v1.ksy`.

## Converter Input Word

The firmware does not sign-extend `word0` / `word1` as ordinary signed 12-bit
PCM. It first rearranges the 12-bit word into the high bits of a 16-bit word:

```text
input_word = ((word & 0x00ff) << 8) | ((word & 0x0f00) >> 4)
```

Equivalent direct forms:

```text
input0 = (byte0 << 8) | ((byte1 & 0x0f) << 4)
input1 = (byte2 << 8) |  (byte1 & 0xf0)
```

`input_word` is then passed to the converter routine.

## Converter State

The converter has one persistent 32-bit signed fixed-point state:

```text
state = state_hi:state_lo
```

The MPC2000XL resets it before importing a sound:

```text
state_lo = 0
state_hi = 0
scale = 0x7fff
```

Do not reset the state between samples of one sound. Do reset it when importing
a separate sound.

## Fixed-Point Helpers

All operations below use 16-bit 8086-style arithmetic with carry/borrow, and
arithmetic right shifts for signed high words.

The converter repeatedly uses this helper:

```text
function transform(lo, hi, ops):
    bx = lo
    ax = hi
    dx = sign_extend_16_to_word(hi)

    for op in ops:
        left_shift_48(dx:ax:bx, op.shift)

        if op.kind == add:
            dx:ax:bx += sign_extend_16_to_word(hi):hi:lo
        else if op.kind == sub:
            dx:ax:bx -= sign_extend_16_to_word(hi):hi:lo
        else if op.kind == shift_only:
            pass

    arithmetic_right_shift_32(dx:ax, 4)
    return ax, dx
```

The three operation tables are:

```text
table_a = [
  add 2, sub 4, add 4, add 4, add 2, sub 3
]

table_b = [
  add 1, sub 3, sub 3, sub 3, add 5, shift_only 3
]

table_c = [
  sub 2, add 3, add 4, add 1, sub 3, add 2
]
```

## Per-Sample Conversion

Pseudocode:

```text
function convert_sample(input_word):
    old_lo = state_lo
    old_hi = state_hi

    a_lo, a_hi = transform(old_lo, old_hi, table_a)

    new_hi:new_lo = arithmetic_right_shift_32(input_word:old_lo, 8)
    new_hi:new_lo += a_hi:a_lo

    b_lo, b_hi = transform(new_lo, new_hi, table_b)
    c_lo, c_hi = transform(old_lo, old_hi, table_c)

    mixed_hi:mixed_lo = b_hi:b_lo + c_hi:c_lo

    state_lo = new_lo
    state_hi = new_hi

    tmp_hi:tmp_lo = arithmetic_right_shift_32(mixed_hi:mixed_lo, 3)
    out_hi:out_lo = mixed_hi:mixed_lo + tmp_hi:tmp_lo

    tmp_hi:tmp_lo = arithmetic_right_shift_32(tmp_hi:tmp_lo, 1)
    out_hi:out_lo += tmp_hi:tmp_lo

    return scale_and_clip(out_hi:out_lo)
```

`scale_and_clip` follows the firmware:

```text
if out is positive and (out >> 8) >= 0x7fff:
    return 32766

if out is negative and -(out >> 8) >= 0x7fff:
    return -32766

return trunc_toward_zero((out << 7) / 0x7fff)
```

The firmware tracks observed minimum/maximum output values after conversion,
but that tracking does not affect the returned PCM sample.

## Consumer Notes

For a `.SET` file, sample payload starts at byte offset `3072`.
`sound_directory_entry.start_address_in_memory` is a sample-word index into that
payload, and `length_in_samples` is the number of packed 12-bit sample words to
convert.

The converter output is mono signed 16-bit PCM. MPC2000XL `.SND` exports store
these samples as little-endian signed 16-bit values after the 42-byte SND header.

The old floating-point recurrence should no longer be used for import. It was
close enough for listening tests, but it is not bit-exact and is unnecessary now
that the firmware routine is known.
