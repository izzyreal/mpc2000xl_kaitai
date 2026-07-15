# Format Version Notes

For MPC sequence/song container formats, the product name in a `.ksy` filename
should be read primarily as provenance, not as a claim that the wrapper/version
bytes are exclusive to that product line.

## Practical Rule

There is not necessarily such a thing as a universally distinct "MPC60 ALL
format" vs "MPC3000 ALL format" vs "MPC2000XL ALL format" at the wrapper-byte
level.

What matters first is:

- file kind byte, for example `0x03` for `SEQ` and `0x04` for `ALL`
- wrapper/version byte that follows it
- which firmware versions are known to read or write that combination

## Current Evidence

- `mpc60scsi` firmware `2.14`
  - `SEQ` starts with `03 02`
  - `ALL` starts with `04 02`
- earlier plain `mpc60` `2.12` probe artifacts point to
  - `SEQ` starting with `03 03`
  - `ALL` starting with `04 03`
- the current `seq.v3.ksy` / `all.v3.ksy` model the `0x03`
  wrapper family
- the current `mpc3000.snd.v2.ksy` models the `0x01 0x02` SND wrapper family
  and is confirmed on:
  - local hardware MPC3000 OS `3.11`
  - MPC3000 OS `3.10`

Fresh July 2026 body-level validation:

- real `mpc60 2.12` raw-image extracts, sliced to their actual FAT file sizes,
  parse cleanly with the existing `seq.v3` and `all.v3`
  layouts
- real `mpc60 2.12` and real MPC3000 `04 03` ALL files also confirm that
  `total_number_of_bytes_in_all_sequences` includes the embedded sequence
  terminator byte (`0xFF`), followed directly by song records or the lone
  `0x00` end sentinel
- real `mpc60scsi 2.14` files confirm that:
  - `03 02` `SEQ` uses a smaller body that still reuses key MPC3000-style
    primitives such as full 24-byte track headers and explicit tempo-change
    records
  - `04 02` `ALL` embeds those `SEQ` bodies directly
  - in `04 02`, `total_number_of_bytes_in_all_sequences` includes the embedded
    sequence terminator byte (`0xFF`)
- practical interpretation: the `0x03` wrapper family is currently best
  understood as a shared MPC3000/MPC60-family body/layout, with model names in
  filenames serving provenance rather than exclusivity
- practical interpretation for MPC3000 SND so far:
  - `0x01 0x02` is confirmed on hardware MPC3000 OS `3.11`
  - `0x01 0x02` is confirmed on MAME MPC3000 firmware `3.10`
  - at least one header field inside that family (`unknown_2` in the current
    provisional schema) varies between the hardware OS `3.11` probe and the
    MAME `3.10` rewrite of the same sample content

So the working assumption is:

- wrapper version is firmware-specific
- model names in the schema filenames are still useful, but mainly as "where
  this mapping was first established / most strongly associated"

## Consumer Guidance

If you are writing a loader:

1. dispatch on file kind and wrapper/version bytes first
2. treat model/firmware support as a compatibility question on top of that
3. do not assume a schema filename with a model name implies protocol
   exclusivity

## MPC3000 SND 0x01 0x02

Known producers:

- hardware MPC3000 OS 3.11
- MPC3000 OS 3.10

Focused MAME 3.10 save-session findings:

- header byte 19 is saved `Vol%` / level (`0x32`, `0x64`, `0xc8` for 50, 100, 200)
- `unknown_2` increases by exactly `frame_count` on each save of the same sample
- `Soft st` / `Soft end` edits did not change the persisted payload in that save path
