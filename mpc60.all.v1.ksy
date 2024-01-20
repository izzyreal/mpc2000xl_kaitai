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

- id: sequences
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
    - id: hundredth_framesu
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
    
    - id: position_tracker
      type: position_tracker
    
    - size: 5

    - id: events
      type: 'event(
        _index == 0,
        _index > 0 ? events[_index - 1].next_status : 0xFF,
        sequence_header.sequence_length_in_bytes.value -
        (_io.pos - position_tracker.position) + 42)'
      
      repeat: until
      repeat-until: sequence_header.sequence_length_in_bytes.value -
                    (_io.pos - position_tracker.position) <= -41

  bar_event:
    seq:
    - id: bar_number1
      type: u1
    - id: bar_number2
      type: u1
    - id: numerator
      type: u1
    - id: denominator
      type: u1
    instances:
      # 1-based, so the first bar is bar number 1
      bar_number:
        value: (bar_number2 << 7) | bar_number1

  note_event:
    seq:
    - id: note_number
      type: u1
      valid:
        min: 0
        max: 127
    - id: velocity
      type: u1
      valid:
        min: 0
        max: 127
    - id: note_variation_value
      type: u1
    - id: duration_byte_1
      type: u1
    - id: duration_byte_2
      type: u1
    
    enums:
      note_variation_type:
        0: tune
        1: decay
        2: attack
        3: filter
    
    instances:
      duration:
        value: duration_byte_1 + (duration_byte_2 << 7)
      note_variation_type:
        value: _parent.status - 0x98
        enum: note_variation_type 

  program_change_event:
    seq:
    # Display value is 1 more than the parsed value.
    - id: program
      type: u1
      valid:
        min: 0
        max: 127

  pitch_bend_event:
    seq:
    # Display value is 1 more than the parsed value.
    - id: pitch_bend_amount_bits_1
      type: b8
    - id: pitch_bend_amount_bits_2
      type: b8
    instances:
      corrected_pitch_bend_amount:
        value: (pitch_bend_amount_bits_1 + (pitch_bend_amount_bits_2 << 7)) - 8192

  ch_pressure_event:
    seq:
      - id: pressure
        type: u1
        valid:
          min: 0
          max: 127

  poly_pressure_event:
    seq:
      - id: note
        type: u1
        valid:
          min: 0
          max: 127
      - id: pressure
        type: u1
        valid:
          min: 0
          max: 127

  control_change_event:
    seq:
      - id: controller
        type: u1
        # enum: controller
      - id: value
        type: u1
        valid:
          min: 0
          max: 127
  
  delta_time_event:
    seq:
      - id: delta_time
        type: u2le

  tune_request_event:
    seq:
      - id: tune_request_event
        size: 0

  mixer_event:
    enums:
      mixer_event_param:
        1: stereo_level
        2: stereo_pan
        3: fxsend_level
        5: indiv_level
    
    params:
      - id: data
        type: u1[]
    instances:
      param:
        value: data[4]
        enum: mixer_event_param
      pad_index:
        value: data[5]
      value:
        value: data[6]
          
  event:
    seq:
    - id: parsed_status
      type: u1
      if: is_first_event

    - id: track_number
      type: u1
      if: status != 0xA8 and status != 0x88 and status != 0xFF
    
    - id: event_body
      type:
        switch-on: status
        cases:
          0x88: delta_time_event
          0x90: note_event
          0x98: note_event
          0xA0: poly_pressure_event
          0xA8: bar_event
          0xB0: control_change_event
          0xC0: program_change_event
          0xD0: ch_pressure_event
          0xE0: pitch_bend_event
          0xE8: tune_request_event

    # Typically this body contains one additional byte that does
    # not belong to the sysex data of this event. It contains the
    # status for the next event. The reason this parser is
    # implemented this way, is because the SEQ file specification
    # does not include a dedicated terminator byte for sysex events.
    # Instead, we must keep parsing until we hit the next status
    # byte, i.e. the first byte that is > 0x7F.
    # The only case that this body does not contain one additional
    # byte is when the sysex event is the last event in the SEQ
    # file.
    - id: system_exclusive_body
      type: u1
      repeat: until
      repeat-until: '_index >= remaining_byte_count or _ > 0x7F'
      if: status == 0xF0
    
    - id: parsed_next_status
      type: u1
      if: not status == 0xF0 and remaining_byte_count > 2

    params:
      - id: is_first_event
        type: b1
      - id: preparsed_status
        type: u1
      - id: remaining_byte_count
        type: s4

    instances:
      status:
        value: 'preparsed_status == 0xFF ? parsed_status : preparsed_status'
      next_status:
        value: 'status == 0xF0 ? system_exclusive_body.last : parsed_next_status'
      mixer_event:
        type: 'mixer_event(system_exclusive_body)'
        if: status == 0xF0 and system_exclusive_body.size >= 7 and
            system_exclusive_body[0] == 0x47 and
            system_exclusive_body[1] == 0x00 and
            system_exclusive_body[2] == 0x44 and
            system_exclusive_body[3] == 0x45
  
  position_tracker:
    instances:
      position:
        value: _io.pos