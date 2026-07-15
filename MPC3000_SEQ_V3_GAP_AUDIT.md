# MPC3000 SEQ v3 Gap Audit

This note tracks the path from a structurally aligned `seq.v3.ksy` to a
gapless, high-confidence schema.

## Confirmed Baseline

MAME MPC3000 firmware 3.10 writes standalone `.SEQ` files with wrapper bytes:

```text
03 03
```

The first direct v3.10 probe was saved from MAME to
`/tmp/mpc3000_seq_probe.img`, extracted without mounting the image, and written
to:

```text
/tmp/mpc3000_v310_SEQ01.SEQ
```

The file starts:

```text
03 03 01 18 00 00 00 00 00 00 00 53 45 51 30 31
```

## Structural Alignment

The v3.10 `SEQ01.SEQ` probe aligns cleanly with the current KSY layout:

- top-level wrapper at offsets `0x0000..0x0001`
- sequence header at `0x0002..0x0026`
- SMPTE offset at `0x0027..0x002b`
- 64 mixer entries at `0x002c..0x012b`
- delay block at `0x012e..0x013c`
- track summary fields at `0x0150..0x0152`
- three 24-byte track headers at `0x0153..0x019a`
- one 6-byte tempo change at `0x019b..0x01a0`
- event stream at `0x01a1`

The `event_stream_length_in_bytes` `u3le` at offset `0x0003` is `0x18`,
matching the 24-byte event stream in this probe. Existing `RealMpc3000/Seq`
fixtures also match this interpretation. This supports the existing
little-endian 24-bit implementation and clarifies that the field is not a broad
"sequence header + body" length.

## Reserved / Constant Fields

The KSY no longer uses anonymous structural gaps in the SEQ v3 layout. Corpus
mining across 61 local `03 03` SEQ fixtures and probes shows that the remaining byte
regions are invariant, so they are modeled as explicit reserved zero fields:

- `sequence_header.reserved_before_event_stream_sentinel_flag = 00`
- `sequence_header.reserved_before_name = 00 00 00`
- `sequence_header.reserved_after_name = 00`
- `track_header.reserved_after_program_change = 00`
- top-level `reserved_after_mixer = 00 00`
- top-level `reserved_after_delays = 00 00 00`
- top-level `reserved_before_track_summary = 16 * 00`
- unused serialized track headers are `ff` followed by `23 * 00`

The remaining reserved bits are also constant in the corpus and targeted MAME
probes:

- `sequence_header.loop_flags_reserved = 4`, giving full loop flag bytes
  `0x09` for `Loop:TO BAR` and `0x08` for `Loop:OFF`
- `track_header.track_flags_reserved = 0`

This does not prove that Akai never used these bits/bytes in any firmware
revision, but it does turn them from "unknown gaps" into enforceable reserved
constants for the currently mapped v3 family.

## Fixture-Derived Findings

Existing `editables/mpc/test-resources/RealMpc3000/Seq/*.SEQ` fixtures currently
show:

- all checked standalone SEQ files use signature `03 03`
- `event_stream_length_in_bytes` exactly matches bytes from the first event to
  EOF
- `num_track_headers` is the number of serialized 24-byte track headers, not
  the number of active tracks; some files serialize only two unused track
  headers
- unused track headers are `ff` followed by 23 zero bytes
- active default drum track flags are byte `0x06`; interpreted little-bit-endian
  this gives `track_mute = 0`, `track_in_use = 1`, `drum_track = 1`, reserved
  high bits zero
- the MIDI-track fixture has flags byte `0x02`, supporting the `drum_track`
  bit interpretation
- the disabled-track fixture has flags byte `0x07`, supporting the
  `track_mute` bit interpretation
- a MAME v3.10 `Vel%: 99` probe saved track header byte `0x63`, confirming
  `track_header.track_volume` stores the visible velocity percentage directly
- a MAME v3.10 sequence-owned text-mixer probe changed Note 37 `Pan: C` to
  `Pan: 1L`; mixer entry index `2` changed from `(100, 50, 0, 9)` to
  `(100, 49, 0, 9)`, confirming `mixer.stereo_pan` and the note-index mapping
- MAME v3.10 sequence-owned text-mixer probes confirm the remaining mixer
  fields: Note 37 `Output select:OUT8` saves fourth byte `0x08`, `Indiv Out
  Volume:1` saves third byte `0x01`, and `Follow ster vol:YES` saves fourth
  byte `0x89`
- MAME v3.10 `Effects (Delay)` probing confirms the `delays` block. A visible
  `Delay1 Vol 50 -> 51` edit did not persist while `Mixer Source Select >
  Effects` was `PROGRAM`; after changing `Effects` to `SEQUENCE`, the saved
  delay block changed from `32 00 00 ...` to `33 00 00 ...`. Adjacent reserved
  fields remained zero.
- MAME v3.10 `Sync In` probing confirms the standalone SEQ `smpte_offset`
  byte order. With `Mode:MIDI TIME CODE` and visible
  `Start:01:00:00:00.00`, the saved offset bytes are `00 00 00 00 01`, i.e.
  `hundredth_frames, frames, seconds, minutes, hours`.
- `reserved_after_name`, `smpte_offset`, `reserved_after_mixer`,
  `reserved_after_delays`, and `reserved_before_track_summary` are invariant in
  the current fixture set
- a corpus pass over 61 local `03 03` standalone SEQ fixtures/probes found:
  - `reserved_before_event_stream_sentinel_flag` is always `00`
  - `reserved_before_name` trailing three bytes are always `00 00 00`
  - `reserved_after_name` is always `00`
  - `loop_flags_reserved` is always `4`
  - `track_flags_reserved` is always `0`
  - `reserved_after_program_change` is always `00`
  - `reserved_after_mixer`, `reserved_after_delays`, and
    `reserved_before_track_summary` are all zero-filled
  - unused track headers are always `ff` followed by 23 zero bytes
- `sequence_header.event_stream_starts_with_ff` is `1` exactly in current
  fixtures whose event stream starts with `0xff` and lacks a trailing `0xff`
- existing fixture `loop_flags` bytes were all `0x09`, but a targeted MAME
  v3.10 probe confirmed `Loop:OFF` saves this byte as `0x08`

## Live MAME v3.10 Probes

The same held MAME MPC3000 v3.10 session was used to save two standalone SEQ
files to `/tmp/mpc3000_seq_probe.img`, then MAME was cleanly exited before
direct FAT12 extraction:

```text
SEQ01.SEQ   size=410  name=SEQ01   sig=03 03  event_len=17
KESN34.SEQ  size=434  name=KESN34  sig=03 03  event_len=17
```

`KESN34.SEQ` was verified on the MPC3000 main screen before saving as:

```text
Seq: 1-KESN34           BPM:120.0 (SEQ)
Sig: 3/ 4   Bars:  2    Loop:TO BAR   1
```

Both saved files have:

```text
reserved_before_name = 00 00 00 00 00
```

This disproves the simple hypothesis that the `M3KMIN.SEQ`
header bytes `00 01 00 00 00` before the name are directly caused by a non-4/4
time signature or by the numerator value.

A follow-up attempt to save a completely unused sequence showed the MPC3000
`Save a Sequence` screen with `Size: 0K`, but pressing `<Do it>` produced no new
SEQ file. So this firmware appears not to save unused sequences as standalone
SEQ files; the `M3KMIN.SEQ` fixture is not reproduced by simply saving an
untouched unused slot.

A minimal used sequence was then created with `Seq Edit > Insert blank bars`:

```text
Seq: 1-SEQ01            BPM:120.0 (SEQ)
Sig: 4/ 4   Bars:  1    Loop:TO BAR   1
```

Saving this sequence overwrote `SEQ01.SEQ` on `/tmp/mpc3000_seq_probe.img`.
The resulting file has:

```text
size=402
event_len=9
reserved bytes + sentinel flag = 00 00 00 00 00
event_stream = a8 01 00 04 04 88 00 03 ff
```

This disproves the hypothesis that the `M3KMIN.SEQ` byte is merely caused by a
minimal used sequence with no note events.

The same sequence was then changed through `Seq Edit > View/chng T sig >
Change TSig` to:

```text
Seq: 1-SEQ01            BPM:120.0 (SEQ)
Sig: 1/ 4   Bars:  1    Loop:TO BAR   1
```

Saving this produced:

```text
size=402
event_len=9
reserved bytes + sentinel flag = 00 00 00 00 00
event_stream = a8 01 00 01 04 88 60 00 ff
```

`M3KMIN.SEQ` was then traced byte-for-byte to the local hardware MPC3000 OS 3.11
corpus:

```text
/Users/izmar/projects/VMPC2000XL/reverse_engineer/mpc3000-os3.11/1-seq-bar-1-tsig-1-4/SEQ01.SEQ
```

The OS 3.11 corpus contains multiple `1/4` and mixed-time-signature SEQ files.
Files whose first bar is `1/4` commonly have:

```text
reserved bytes + sentinel flag = 00 01 00 00 00
```

The MAME v3.10 reproduction of the same visible sequence state has:

```text
reserved bytes + sentinel flag = 00 00 00 00 00
```

So this byte is not caused by `1/4`, by a minimal used sequence, or by the
absence of note events in a model-independent way. It is most likely
firmware/version-specific state or a related OS 3.11 authoring-path artifact.

The exact corpus-wide pattern is stronger:

```text
00 01 00 00 00 before sequence name
  event stream starts with ff
  event stream does not end with ff

00 00 00 00 00 before sequence name
  event stream starts with the first real event status, usually a8
  event stream ends with ff
```

The second byte is therefore named `event_stream_starts_with_ff` in the KSY.
The first byte and trailing three bytes remain reserved because they are zero in
the current corpus.

### Loop Field

The Play/Record screen `Loop` field was probed with a one-bar used sequence.
The visible states and saved bytes are:

```text
Loop:TO BAR 1  -> header byte 0x09
Loop:OFF       -> header byte 0x08
```

With `meta/bit-endian: le`, this confirms:

```text
bit 0    = loop_to_bar
bits 1-7 = reserved/constant so far
```

The following two-byte field still stores the `TO BAR` bar number. In the
`Loop:OFF` probe it remained `1`.

### Track Header Fields

Track header bit flags are now covered by fixture/probe deltas:

```text
0x06 = active DRUM track, On:YES
0x07 = active DRUM track, On:NO
0x02 = active MIDI/non-drum track, On:YES
```

With `meta/bit-endian: le`, this confirms:

```text
bit 0    = track_mute / On:NO
bit 1    = track_in_use
bit 2    = drum_track
bits 3-7 = reserved/zero so far
```

The visible main-screen `Vel%` field stores directly in
`track_header.track_volume`; a `Vel%: 99` MAME v3.10 probe saved byte `0x63`.

### Mixer Table

The mixer table has one 4-byte entry per note number `35..98`; entry index
`note - 35` maps to the visible text-mixer `Note` field.

The default entry observed across fixtures is:

```text
(100, 50, 0, 9)
```

The text mixer displays that as:

```text
Stereo Volume: 100
Stereo Pan:    C
Indiv Volume:  0
Output select: EFCT
Follow stereo: NO
```

To make text-mixer edits affect the SEQ mixer table, first set
`Mixer/Effects > 4.Mixer source select > Stereo mix` to `SEQUENCE`. With that
set, changing Note 37 from `Pan: C` to `Pan: 1L` changed mixer entry index `2`
from:

```text
64 32 00 09
```

to:

```text
64 31 00 09
```

This confirms `mixer.stereo_pan` stores the visible pan center as `50`, one step
left as `49`, and by implication uses the documented `50L..C..50R` range.

For individual out/effects data, first set `Mixer/Effects > 4.Mixer source
select > Indiv out / effect mix` to `SEQUENCE`. Then the text mixer writes the
remaining two bytes of the same entry:

```text
Output select: EFCT       -> 64 32 00 09
Output select: OUT8       -> 64 32 00 08
Indiv Out Volume: 1       -> 64 32 01 09
Follow ster vol: YES      -> 64 32 00 89
```

With `meta/bit-endian: le`, this confirms:

```text
byte 0        = stereo_mix
byte 1        = stereo_pan
byte 2        = individual_out_mix
byte 3 bits 0-6 = individual_out
byte 3 bit 7    = follow_stereo
```

### Effects / Delay Block

The `Effects (Delay)` screen displays:

```text
Delay1= Vol 50 Pan C Time 100 Fdbk 0
Delay2= Vol  0 Pan C Time 200 Fdbk 0
Delay3= Vol  0 Pan C Time 300 Fdbk 0
```

The default delay block is:

```text
32 00 00 32 32 32 64 00 c8 00 2c 01 00 00 00
```

The layout is:

```text
bytes 0..2   = volumes for delays 1..3
bytes 3..5   = pans for delays 1..3, with center stored as 50
bytes 6..11  = little-endian delay times for delays 1..3
bytes 12..14 = feedback values for delays 1..3
```

To make edits persist in a standalone SEQ file, set
`Mixer/Effects > Mixer Source Select > Effects` to `SEQUENCE`. With the source
left at `PROGRAM`, the on-screen edit is visible but the saved SEQ keeps the
default delay block. With `Effects:SEQUENCE`, changing `Delay1 Vol` from `50`
to `51` changes byte 0 from `0x32` to `0x33`.

The manual describes visible delay times as `1..1486` ms, but the local corpus
contains one `03 03` file with an all-zero delay block. The KSY therefore
allows serialized delay times of `0..1486`: zero is treated as a preserved file
state, not necessarily a normal user-facing value.

### SMPTE Offset

The five-byte `smpte_offset` type is confirmed by the `Sync In` screen when
`Mode` is set to `MIDI TIME CODE`. A visible start value of:

```text
Start:01:00:00:00.00
```

saves as:

```text
00 00 00 00 01
```

This confirms the serialized order:

```text
hundredth_frames, frames, seconds, minutes, hours
```

## Probe Matrix

Use one held MAME MPC3000 v3.10 session where possible. Save multiple `.SEQ`
files under distinct names, clean-exit once, then inspect the floppy image.

Priority probes:

1. Sequence globals:
   tempo, bar count, time signature, loop mode, loop target bar, sequence name.

2. Track header:
   selected/last active track, multiple active tracks, track mute/on, DRUM vs
   MIDI type, MIDI channel/port routing, track name, velocity percentage,
   program change.

3. Mixer table:
   force sequence-owned mixer source, then vary stereo level, pan, FX send,
   individual output, and follow-stereo behavior for a known pad/note.

4. Tempo changes:
   one fixed-tempo sequence, one sequence with an additional tempo change, and
   one with two changes, verifying `number_of_tempo_changes` and factor
   encoding.

5. Event edge cases:
   pitch bend negative/zero/positive, control change, program change, channel
   pressure, poly pressure, note variation types, long duration, delta-time
   boundaries, and sysex continuation behavior.

6. Top-level reserved fields:
   inspect after each probe; if a reserved region changes with exactly one UI
   mutation, promote it to a real field name.

## Current Interpretation

`SEQ v3` is a shared wrapper/version family observed in MPC3000 v3.10 and also
in earlier MPC60 evidence. The product name in `seq.v3.ksy` is therefore
provenance, not exclusivity.
