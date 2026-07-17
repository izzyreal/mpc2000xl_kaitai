# MPC60 SET Consumption Notes

This note documents consumer-side rules for `mpc60.set.v0.ksy` and
`mpc60.set.v1.ksy` when the goal is to emulate MPC2000XL `.SET` import
behavior.

Observed wrapper signatures:

- `02 00`: factory/web SET corpus, with no evidenced producing firmware yet.
- `02 01`: produced by MPC60 firmware 2.05, 2.12, and 2.14.

For MPC2000XL import, both versions use the same consumer projection described
below.

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

### 0. Some MPC60 global mixer/hihat settings are not SET data

On MPC60 firmware 2.14, changing the following UI fields and saving the same
loaded SET under different names produced byte-identical SET files:

- `HiHat Decay Switch Thresholds` Closed/Medium and Medium/Open
- hihat decay controller number
- `Function of '16 levels'`
- `Stereo Mix` and `Echo Mix` mixer modes
- `Rcrd live chngs` for those mixer modes

Those fields should therefore not be inferred from SET v1. They likely belong to
parameter/global state rather than the SET file.

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

### 6. MPC2000XL import presents sounds as 44100 Hz with -17 tune

Real MPC2000XL v1.20 imports `.SET` sounds with sound metadata sample rate
`44100` and sound tune `-17`, even though MPC60 source material is understood as
40 kHz. Current `editables/mpc` mirrors that metadata behavior without
resampling the decoded sample data.

### 7. Note tune comes from `pitch_factor`

For whole-SET import, each assigned target note should derive its note-parameter
tune from the source sound directory entry's `pitch_factor`:

```text
round(120 * log2(pitch_factor / 4096))
```

`4096` maps to `0`; for example `STUDIO.SET` yields roughly `+39` for
`TOM#1_HI`, `+36` for `TOM#1_LO`, and `+21` for one `CRASH_#1` assignment.

### 8. Stereo mixer data should follow the imported sound

For MPC2000XL-style whole-SET import, the mixer settings associated with a
source sound should remain associated with that sound after it is assigned to a
2000XL program note. Use the assigned sound directory entry's
`requested_stereo_mix_volume` and `requested_stereo_mix_pan` fields for the
resulting note-parameter stereo mixer.

These MPC60 values are 7-bit style ranges and need conversion to the
MPC2000XL's 0..100 mixer range.

### 9. Imported hihat uses DECAY switch, slider assignment, and mute assigns

Real MPC2000XL v1.20 imports the closed hihat target note as a three-layer
`DECAY SWITCH`: the closed hihat remains the base note, optional note A is the
medium hihat, and optional note B is the open hihat. The default import
thresholds are lower `14` and upper `42`.

The same closed hihat target note also gets note-variation slider assignment
enabled for `DECAY`, low range `12`, and high range `45`. For the default
conversion table this is note `42` / pad `A03`. The closed hihat target note
gets mute assignments to mute the imported medium and open hihat target notes
(`82` / `A04` and `46` / `A07` with the default conversion table).

This has so far been observed for `STUDIO.SET` and `SYNTH.SET`. A byte-level
probe on MPC60 firmware 2.14 showed that changing the MPC60 hihat-decay global
threshold/controller screen values did not change the saved SET file, so this
should be treated as MPC2000XL import policy unless later evidence shows a SET
field that controls it.

## Practical Guidance For Consumers

If you want MPC2000XL-like `.SET` import from your own app model:

1. Parse the `.SET` structure directly from the schema.
2. Treat `sound_map` as MPC60-pad to directory-entry index.
3. Provide the 2000XL conversion-table default in consumer code.
4. Map imported sounds into a created program using the chosen target-note
   table.
5. Implement `CLEAR` versus `LOAD` as consumer memory-policy choices.
6. Present imported sounds as 44100 Hz with sound tune -17 for MPC2000XL-style import.
7. Derive imported note tune from each assigned directory entry's `pitch_factor`.
8. Import stereo mixer level/pan from the assigned sound directory entry.
9. Import the closed-hihat target note as `DECAY SWITCH`, optional notes
   medium/open, thresholds `14` and `42`, and mute assigns to medium/open.
10. Assign the note-variation slider to the imported closed-hihat target note,
   with parameter `DECAY` and range `12..45`.
11. If you emulate the conversion-table UI, resolve displayed pad names through
   the current DRUM1 program, not through a global note map.

## Confidence Level

Current confidence is high for the rules above.

They are based on:

- real `ROCK.SET` and `STUDIO.SET` files
- MAME `mpc2000xl` behavior mapping
- downstream tests in `editables/mpc`
- end-to-end validation of both preview and whole-load paths
