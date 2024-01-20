### WIP ###

meta:
  id: mpc60_all_v1
  file-extension: all

seq:
- id: file_id
  contents: [0x03]

- id: file_format_version
  contents: [0x01]
  
- id: total_number_of_bytes_in_all_sequences
  type: u4le

- id: sequence
  type: sequence
  repeat: until
  repeat-until: _io.pos + 6 >= total_number_of_bytes_in_all_sequences

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
  
  track_header:
    types:
      body:
        seq:
        - id: user_track_number
          type: u1
        - id: track_mute
          type: b1
        - id: track_in_use
          type: b1
        - id: drum_track
          type: b1
        - type: b5
        - id: channel_assignments
          type: b1
          repeat: expr
          repeat-expr: 16
        - id: track_name
          type: str
          encoding: ASCII
          size: 16
        
    seq:
    - id: absolute_track_number
      type: u1
      
    - id: body
      type: body
      if: absolute_track_number != 0xFF

  sequence_header:
    seq:
    - id: sequence_number
      type: u1
    - id: sequence_length_in_bytes # excluding sequence header
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
    - id: number_of_tempo_changes
      type: u1
    - id: number_of_active_track_headers
      type: u1

  sequence:
    seq:
    - id: sequence_header
      type: sequence_header
  
    - id: track_headers
      type: track_header
      
      ## Both of these repeat-clauses work. But I'm not sure what will be
      ## the best one to use, so for now I'll keep both around.
      ## The advantage of the one based on number_of_active_track_headers
      ## is that we avoid one terminating dummy track_header.
      
      # repeat: until
      # repeat-until: track_headers[_index - 1].absolute_track_number == 0xFF
      repeat: expr
      repeat-expr: sequence_header.number_of_active_track_headers - 2
      
    - id: track_headers_terminator
      contents: [0xFF]
    
    - id: events
      size: sequence_header.sequence_length_in_bytes.value
    
    - id: unknown
      size: 47
