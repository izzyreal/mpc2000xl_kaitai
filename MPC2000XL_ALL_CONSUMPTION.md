# MPC2000XL ALL Consumption Notes

This note documents consumer-side rules for `mpc2000xl.all.ksy`.

The `.ksy` is authoritative for binary structure and field interpretation, but
for `.ALL` it is not by itself a sufficient guide for building a correct
serializer from an unrelated in-memory model.

This was established while making `editables/mpc` produce byte-identical output
for the real `RESIST.ALL` demo file and while validating the result in MAME.

## Scope Split

What belongs in the `.ksy`:

- on-disk field layout
- types, sizes, endianness, bit layout
- enums and field meanings
- conditional structure
- derived properties that are direct consequences of parsed fields

What belongs in the consumer:

- how an application state maps onto the file model
- how derived save-only values are computed from runtime objects
- how anonymous / not-yet-fully-reversed regions are populated
- how to preserve structural quirks that are not obvious from a high-level app model

## Important ALL-Specific Rules

### 1. `sequence_meta.last_event_index` is not a boolean

In the sequence metadata table, the 2-byte field after the 16-byte name is not
just "used / unused".

It is best modeled as:

- `last_event_index: u2le`

and `is_used` should be derived from it:

- `is_used = last_event_index != 0`

For used sequences, the handwritten MPC implementation writes:

- `641 + floor(adjusted_segment_count / 2)`

where `adjusted_segment_count` is the sequence-meta segment count rounded down
to an even value.

For unused sequences:

- `last_event_index = 0`

### 2. There are two different sequence segment counts

A consumer that serializes from an application model needs two different
segment-count notions.

Sequence-meta count:

- normal event: `1`
- SysEx event: `2`
- mixer event: `2`

Sequence-body count:

- normal event: `1`
- SysEx event: `3`
- mixer event: `4`

Using only one count for both purposes produces incorrect `.ALL` output.

### 3. Empty 8-byte `sequence` records are structural separators

The repeated top-level `sequences` array is not simply:

- one entry per used sequence
- or one entry per sequence slot

Instead, when a written sequence body has an even body-segment count, the file
contains an extra 8-byte `0xFF` terminator segment after it. Kaitai parses that
extra segment as an empty `sequence` record.

So a real parsed sequence list may look like:

- `[1, -1, 2, -1, 3, 4, 5, -1]`

where `-1` means an empty `sequence` record with no body.

Those empty records are structural consequences of the preceding sequence-body
layout. They are not the same thing as unused sequencer memory slots.

### 4. The defaults block contains anonymous data that matters in practice

The defaults area includes anonymous bytes between the explicit defaults fields
and the device-name table.

As of current understanding:

- the explicit `loop_enabled` byte is real and should be used
- parts of the anonymous blob are still not fully reverse engineered
- blindly regenerating the whole anonymous region from a guessed constant can
  produce byte differences against real files

Consumers should be careful here. If byte identity matters, preserve known
layout details exactly.

### 5. Load-side mapping can still be wrong even if the parser is right

A correct `.ksy` parse is not enough if the consumer maps fields into runtime
state incorrectly.

One concrete example encountered during integration:

- restoring USER-screen loop state from an anonymous byte instead of the actual
  parsed loop-related field led to wrong rewritten output

So the consumer's projection from parsed Kaitai object to runtime state must be
reviewed independently from the schema.

## Practical Guidance For Consumers

If you want to serialize `.ALL` from your own app model:

1. First build a complete `mpc2000xl_all_t`-equivalent object model.
2. Compute `last_event_index` from sequence-meta segment counting, not from a
   boolean used flag.
3. Compute sequence-body event storage length separately.
4. Emit extra empty `sequence` records after sequences whose body layout
   requires the extra terminator segment.
5. Treat anonymous defaults-region bytes conservatively.

## Confidence Level

Current confidence is high for the rules above.

They are based on:

- real MPC2000XL files
- handwritten parser/writer behavior
- byte-identical roundtrip of `RESIST.ALL` in `editables/mpc`
- MAME validation

There may still be unknown meaning inside anonymous regions, but the structural
rules documented here are real and currently necessary for correct consumption.
