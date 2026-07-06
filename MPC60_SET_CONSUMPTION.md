# MPC60 SET Consumption Notes

This note documents consumer-side rules for `mpc60.set.v1.ksy` when the goal is
to emulate MPC2000XL `.SET` import behavior.

The schema is authoritative for the binary structure of an MPC60 `.SET` file,
but the file does not by itself describe how an MPC2000XL should project that
data into its own program-and-sound model.

## Scope Split

What belongs in the schema:

- on-disk field layout
- directory-entry structure
- sound sample packing
- the 34-entry MPC60 pad to sound-directory map
- enums and direct field meanings

What belongs in the consumer:

- how a 2000XL names or creates the imported program
- what default MPC2000XL target notes are offered in the conversion table
- how the conversion-table UI resolves pad labels
- what `CLEAR` versus `LOAD` means for existing in-memory programs and sounds

## Important SET-Specific Rules

### 1. `sound_map` is MPC60-pad to directory-entry index

The `sound_map` bytes are correctly interpreted as:

- table index = MPC60 pad
- byte value = referenced `sound_directory_entry` index

The earlier suspicion that this area was "not lining up" turned out to be a
consumer-side interpretation problem, not a schema problem.

For the factory `ROCK.SET` and `STUDIO.SET` files, this mapping now lines up
with real 2000XL import behavior.

### 2. The 2000XL conversion table is not stored in the `.SET`

The `.SET` file identifies MPC60 source pads and their assigned sounds, but it
does not store the MPC2000XL target-note mapping shown on the 2000XL
`Conversion table` screen.

That mapping is a 2000XL import default and must be provided by the consumer.

Recovered default target notes, in 0-based MPC60 pad order:

```text
42, 82, 46, 38, 37, 36, 48, 47, 45, 43, 51, 53, 49, 55, 69, 54, 56,
39, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 70, 71, 72, 73
```

These values were recovered from MAME `mpc2000xl` and validated in
`editables/mpc`.

### 3. Conversion-table `Becomes note:` pad labels are resolved through DRUM1

On the 2000XL `Conversion table` screen, the right-hand pad label in:

- `Becomes note:NN/PAD`

is not a global note-to-pad lookup.

It is resolved through the program currently assigned to `DRUM1`:

1. take the target note
2. look for the pad in the DRUM1 program that is assigned to that note
3. show that pad name
4. if no pad in that program resolves to the note, show `OFF`

This is a UI-consumer rule, not a `.SET` file rule.

### 4. Whole-SET import needs explicit memory-policy behavior

The 2000XL whole-SET import flow has two meaningful branches:

- `CLEAR`
- `LOAD`

For consumer purposes:

- `CLEAR` means clear existing programs and sounds, then import the SET into a
  fresh memory state
- `LOAD` means keep existing programs and sounds, then append the imported
  program and sounds into the first available slots

This behavior is not encoded in the `.SET` bytes.

### 5. Imported program naming is consumer policy

The `.SET` import path needs a resulting 2000XL program name, but the file does
not contain a native 2000XL program object.

Current consumer behavior in `editables/mpc` is:

- imported program name = source filename stem

For example:

- `ROCK.SET` -> program name `ROCK`
- `STUDIO.SET` -> program name `STUDIO`

### 6. Current v1 sample-rate assumption is 40000 Hz

Current import behavior in `editables/mpc` constructs imported sounds at
`40000` Hz.

That matches current understanding for the MPC60 `.SET` material exercised so
far, but this is still a consumer assumption worth re-checking if broader MPC60
sample corpora reveal per-sound or per-set variability.

## Practical Guidance For Consumers

If you want MPC2000XL-like `.SET` import from your own app model:

1. Parse the `.SET` structure directly from the schema.
2. Treat `sound_map` as MPC60-pad to directory-entry index.
3. Provide the 2000XL conversion-table default in consumer code.
4. Map imported sounds into a created program using the chosen target-note
   table.
5. Implement `CLEAR` versus `LOAD` as consumer memory-policy choices.
6. If you emulate the conversion-table UI, resolve displayed pad names through
   the current DRUM1 program, not through a global note map.

## Confidence Level

Current confidence is high for the rules above.

They are based on:

- real `ROCK.SET` and `STUDIO.SET` files
- MAME `mpc2000xl` behavior mapping
- downstream tests in `editables/mpc`
- end-to-end validation of both preview and whole-load paths
