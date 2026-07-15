meta:
  id: mpc60_seq_body
  imports:
    - seq.v3
  bit-endian: le

# This body models the smaller `03 02` family observed on `mpc60scsi` 2.14.
# It is not a generic body for every MPC60-family SEQ wrapper:
# fresh July 2026 validation showed that plain MPC60 2.12 `03 03` files instead
# line up with the existing `seq.v3` layout.
#
# Fresh July 2026 validation against real `MPC60_v214_SEQ01.SEQ` indicates
# that this body shares several reduced-MPC3000-style primitives:
# - full 24-byte track headers
# - explicit tempo-change records
# - an event stream whose byte length is governed directly by
#   `event_stream_length_in_bytes`

enums:
  off_on:
    0: off
    1: on

types:
  smpte_offset:
    seq:
    - id: hundredth_frames
      type: u1
      valid:
        min: 0
        max: 99
    - id: frames
      type: u1
      valid:
        min: 0
        max: 29
    - id: seconds
      type: u1
      valid:
        min: 0
        max: 59
    - id: minutes
      type: u1
      valid:
        min: 0
        max: 59
    - id: hours
      type: u1
      valid:
        min: 0
        max: 23

  u3le:
    seq:
    - id: b12
      type: u2le
    - id: b3
      type: u1
    instances:
      value:
        value: 'b12 | (b3 << 16)'

  sequence_header:
    seq:
    - id: sequence_number
      type: u1
    - id: event_stream_length_in_bytes
      type: u3le
    - id: offset_from_bottom_of_sequence_to_sequence_start
      type: u3le
    - id: sequence_name
      type: str
      encoding: ASCII
      size: 16
    - id: loop_to_bar
      type: b1
      enum: off_on
    - type: b7
    - id: loop_to_bar_number
      type: u2le
    - id: number_of_bars
      type: u2le
    - id: length_in_ticks
      type: u4le
    - id: tempo
      type: u2le
    - id: smpte_offset
      type: smpte_offset
    - id: stereo_mix
      type: u1
      repeat: expr
      repeat-expr: 32
    - id: stereo_pan
      type: u1
      repeat: expr
      repeat-expr: 32
    - id: echo_mix
      type: u1
      repeat: expr
      repeat-expr: 32
    - id: drum_tuning
      type: u2le
      repeat: expr
      repeat-expr: 32
    - id: last_active_user_track
      type: u1
    - id: num_tempo_changes
      type: u1
    - id: num_track_headers
      type: u1

  sequence:
    seq:
    - id: sequence_header
      type: sequence_header
    - id: track_headers
      type: mpc3000_seq_v3::track_header
      repeat: expr
      repeat-expr: sequence_header.num_track_headers
    - id: tempo_changes
      type: mpc3000_seq_v3::tempo_change
      repeat: expr
      repeat-expr: sequence_header.num_tempo_changes
    - id: events
      type: 'mpc3000_seq_v3::event(
        _index == 0,
        _index > 0 ? events[_index - 1].next_status : 0xFF,
        sequence_header.event_stream_length_in_bytes.value -
        (_io.pos - events_start))'
      repeat: until
      repeat-until: sequence_header.event_stream_length_in_bytes.value -
                    (_io.pos - events_start) == 0
    instances:
      events_start:
        value: _io.pos
