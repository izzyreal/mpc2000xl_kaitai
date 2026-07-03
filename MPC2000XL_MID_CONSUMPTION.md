# MPC2000XL MID Consumption Notes

This note documents consumer-side rules for MPC2000XL-flavoured MIDI import and
export.

The underlying Kaitai schema for this path is:

- `standard_midi_file_with_running_status.ksy`
- optionally consumed together with `mpc2000xl.mid.ksy` conventions in the app

As with `.ALL`, the schema is not by itself a complete implementation guide for
serializing an unrelated runtime model.

## Scope Split

What belongs in the schema:

- Standard MIDI binary structure
- running-status handling
- event encodings
- meta-event and sysex layout

What belongs in the consumer:

- how MPC2000XL stores sequencer semantics inside MIDI events
- how track/device/bus metadata is encoded in text/meta events
- how note variation is projected into MIDI events and reconstructed
- what can be omitted implicitly and what must be written explicitly

## MPC2000XL-Specific Consumer Rules

### 1. Note variation is encoded as a synthetic note-off-style carrier

The consumer uses a channel event with status `0x80` to carry note variation:

- note number field = variation type
- velocity field = variation value

This is not ordinary musical note-off semantics. It is a consumer convention
used to transport MPC note variation through MIDI.

### 2. Only implicit `Tune 64` may be omitted

The default implicit note variation after loading, and after consuming a note
variation carrier, is:

- type: `Tune`
- value: `64`

This means only `Tune 64` may be safely omitted on save.

Non-tune variations must still be written explicitly even if their value looks
like a "default" in MPC terms, for example:

- `Decay 0`
- `Attack 0`
- `Filter 50`

If such events are omitted, reload will not preserve their variation type and
they will fall back to implicit `Tune 64`.

### 3. Real bug found during validation: `Filter 50` must serialize explicitly

While validating `RESIST.ALL` sequence `INTRO`, a note that should have had:

- variation type: `Filter`
- variation value: `50`

reloaded as:

- variation type: `Tune`
- variation value: `64`

The cause was a save-side optimization that treated `Filter 50` as omittable.
That optimization is invalid.

### 4. Zero-valued non-tune variations are also explicit

Similarly, values like:

- `Filter 0`
- `Attack 0`
- `Decay 0`

must not be treated as implicitly representable by omission.

The omission rule is about the implicit MIDI-side default, not about whether a
variation value numerically equals a domain-specific default.

### 5. Track semantics are carried in text/meta events

MPC2000XL track metadata is not reconstructed from plain MIDI channel traffic
alone.

The consumer relies on text/meta conventions such as:

- sequence/track naming meta events
- MPC-specific track-data text payloads

Those payloads encode things like:

- track index
- device index
- bus type

So a consumer that wants MPC-like roundtrip behaviour must preserve and emit
those conventions.

### 6. Loop and sequence parameters are also carried through meta text

Consumer logic currently uses MPC-specific text/meta conventions to transport
sequence state such as loop and tempo-source-related behaviour.

That information is not derivable from vanilla Standard MIDI alone.

## Practical Guidance For Consumers

If you want correct MPC2000XL-style MIDI roundtrip from your own app model:

1. Treat the Kaitai MIDI parser as the binary container layer.
2. Implement MPC-specific semantic encoding above that layer.
3. Serialize every non-`Tune 64` note variation explicitly.
4. Preserve MPC text/meta conventions for track and sequence metadata.
5. Validate against real MPC-produced MIDI where possible.

## Confidence Level

Current confidence is high for the rules above.

They are based on:

- real MPC2000XL MIDI files
- roundtrip tests in `editables/mpc`
- a dedicated real-world regression using `RESIST.ALL` sequence `INTRO`
- targeted synthetic regressions for zero-valued and default-valued non-tune
  note variations
