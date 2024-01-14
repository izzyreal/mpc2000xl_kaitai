### WIP ###

meta:
  id: mpc3000_seq_v3
  file-extension: mpc3000.seq.v3
  bit-endian: le

enums:
  controller:
    0: bank_sel_msb
    1: mod_wheel
    2: breath_cont
    3: cc3
    4: foot_control
    5: porta_time
    6: data_entry
    7: main_volume
    8: balance
    9: cc9
    10: pan
    11: expression
    12: effect_1
    13: effect_2
    14: cc14
    15: cc15
    16: gen_pur_1
    17: gen_pur_2
    18: gen_pur_3
    19: gen_pur_4
    20: cc20
    21: cc21
    22: cc22
    23: cc23
    24: cc24
    25: cc25
    26: cc26
    27: cc27
    28: cc28
    29: cc29
    30: cc30
    31: cc31
    32: bank_sel_lsb
    33: mod_whel_lsb
    34: breath_lsb
    35: cc35
    36: foot_cnt_lsb
    37: port_time_ls
    38: data_ent_lsb
    39: main_vol_lsb
    40: balance_lsb
    41: cc41
    42: pan_lsb
    43: express_lsb
    44: effect_1_lsb
    45: effect_2_msb
    46: cc46
    47: cc47
    48: gen_pur_1_ls
    49: gen_pur_2_ls
    50: gen_pur_3_ls
    51: gen_pur_4_ls
    52: cc52
    53: cc53
    54: cc54
    55: cc55
    56: cc56
    57: cc57
    58: cc58
    59: cc59
    60: cc60
    61: cc61
    62: cc62
    63: cc63
    64: sustain_pdl
    65: porta_pedal
    66: sostenuto
    67: soft_pedal
    68: legato_ft_sw
    69: hold_2
    70: sound_vari
    71: timber_harmo
    72: release_time
    73: attack_time
    74: brightness
    75: sound_cont_6
    76: sound_cont_7
    77: sound_cont_8
    78: sound_cont_9
    79: sound_cont10
    80: gen_pur_5
    81: gen_pur_6
    82: gen_pur_7
    83: gen_pur_8
    84: porta_cntrl
    85: cc85
    86: cc86
    87: cc87
    88: cc88
    89: cc89
    90: cc90
    91: ext_eff_dpth
    92: tremolo_dpth
    93: chorus_depth
    94: detune_depth
    95: phaser_depth
    96: data_incre
    97: data_decre
    98: nrpn_lsb
    99: nrpn_msb
    100: rpn_lsb
    101: rpn_msb
    102: cc102
    103: cc103
    104: cc104
    105: cc105
    106: cc106
    107: cc107
    108: cc108
    109: cc109
    110: cc110
    111: cc111
    112: cc112
    113: cc113
    114: cc114
    115: cc115
    116: cc116
    117: cc117
    118: cc118
    119: cc119
    120: all_snd_off
    121: reset_contrl
    122: local_on_off
    123: all_note_off
    124: omni_off
    125: omni_on
    126: mono_mode_on
    127: poly_mode_on
  mixer_event_param:
    1: stereo_level
    2: stereo_pan
    3: fxsend_level
    5: indiv_level
  off_on:
    0: off
    1: on
  no_yes:
    0: no
    1: yes
  individual_out:
    0: unassigned
    1: out_1
    2: out_2
    3: out_3
    4: out_4
    5: out_5
    6: out_6
    7: out_7
    8: out_8
    9: internal_effects_generator

types:

  # I'm currently unsure about endianness of 24-bit values.
  # It seems likely that the below is correct, given that
  # everything seen so far in MPC file formats is little
  # endian. But if 24-bit values are looking off, we can
  # simplify them to use type 'b24' rather than this custom
  # 'u3le'.
  u3le:
    seq:
      - id: b12
        type: u2le
      - id: b3
        type: u1
    instances:
      value:
        value: 'b12 | (b3 << 16)'

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
        # The user-facing max value is dictated by the
        # number of frames, which is not stored in SEQ files.
        # It is stored in PAR and ALL files. But in terms of
        # file specification, this value never goes over 29.
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
    
  sequence_header:
    seq:
    - id: sequence_number
      type: u1
    - id: sequence_length_in_bytes # excluding sequence header
      type: u3le

    # unknown
    - size: 5    

    - id: sequence_name
      type: str
      encoding: ASCII
      size: 16
    
    - size: 1 # unknown
    
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
  
  mixer:
    seq:
    - id: stereo_mix
      type: u1
      valid:
        min: 0
        max: 100
    - id: stereo_pan # to be verified
      type: u1
      valid:
        min: 0
        max: 100
    - id: individual_out_mix # to be verified
      type: u1
    - id: individual_out # to be verified
      type: b7
      enum: individual_out
    - id: follow_stereo
      type: b1
      enum: no_yes

  delays:
    seq:
    - id: volume1
      type: u1
    - id: volume2
      type: u1
    - id: volume3
      type: u1
    - id: pan1
      type: u1
    - id: pan2
      type: u1
    - id: pan3
      type: u1
    - id: time1
      type: u2le
    - id: time2
      type: u2le
    - id: time3
      type: u2le
    - id: feedback1
      type: u1
    - id: feedback2
      type: u1
    - id: feedback3
      type: u1

  track_header:
    seq:
    # If -1, it means this track header is unused.
    # Otherwise, it is the 1-based index of the track
    # within the SEQ file as far as I can see.
    - id: absolute_recorded_track_number
      type: s1
    
    - size: 23
      if: absolute_recorded_track_number == -1
    
    - id: user_track_number
      type: u1
      if: absolute_recorded_track_number != -1
    - id: track_mute
      type: b1
      if: absolute_recorded_track_number != -1
    - id: track_in_use
      type: b1
      if: absolute_recorded_track_number != -1
    - id: drum_track
      type: b1
      if: absolute_recorded_track_number != -1
    - type: b5
      if: absolute_recorded_track_number != -1
    - id: primary_port_channel_assignment
      type: u1
      if: absolute_recorded_track_number != -1
    - id: secondary_port_channel_assignment
      type: s1
      if: absolute_recorded_track_number != -1
    - id: track_name
      type: str
      encoding: ASCII
      size: 16
      if: absolute_recorded_track_number != -1
    - id: track_volume
      type: u1
      valid:
        min: 1
        max: 200
      if: absolute_recorded_track_number != -1
    - id: program_change_number
      type: u1
      if: absolute_recorded_track_number != -1
      
    - size: 1
      if: absolute_recorded_track_number != -1

  tempo_change:
    seq:
    - id: ticks_from_sequence_start
      type: u4le
    - id: factor1
      type: b12
    - id: factor2
      type: b4
    instances:
      factor_percentage:
        value: '((factor1 / 4096.0) * 100) + (factor2 * 100)'
  
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

  mixer_event:
    seq:
      - size: 2
      - id: param
        type: u1
        enum: mixer_event_param
      - id: pad_index
        type: u1
      - id: value
        type: u1
        valid:
          min: 0
          max: 100

  exclusive_event:
    seq:
      - id: bytes
        size: 2
      - id: mixer
        type: mixer_event
        if: bytes == [ 0x47, 0x00 ]
      - size: 2
        if: bytes != [ 0x47, 0x00 ]

  control_change_event:
    seq:
      - id: controller
        type: u1
        enum: controller
      - id: value
        type: u1
        valid:
          min: 0
          max: 127

  event:
    seq:
    - id: status
      type: u1
    
    - id: track_number
      type: u1
      if: status != 0xA8 and status != 0x88 and status != 0xFF
    
    - id: bar_event
      type: bar_event
      if: status == 0xA8
      
    - id: note_event
      type: note_event
      if: status >= 0x90 and status <= 0x9F

    - id: pitch_bend
      if: status == 0xE0
      type: pitch_bend_event
      
    - id: tune_request
      if: status == 0xE8
      size: 0
     
    - id: control_change
      if: status >= 0xB0 and status <= 0xBF
      type: control_change_event
    
    - id: program_change
      if: status >= 0xC0 and status <= 0xCF
      type: program_change_event

    - id: ch_pressure
      if: status >= 0xD0 and status <= 0xDF
      type: ch_pressure_event
    
    - id: poly_pressure
      if: status == 0xA0
      type: poly_pressure_event
       
    - id: exclusive
      if: status == 0xF0
      type: exclusive_event

    - id: delta_time_event
      if: status == 0x88
      type: u2le

seq:
  - id: file_id
    contents: [0x03]
  
  - id: file_format_version
    contents: [0x03]
    
  - id: sequence_header
    type: sequence_header
    
  # Can be changed in the Tempo/Sync > Sync In section,
  # when Mode: is set to MIDI TIME CODE.
  - id: smpte_offset
    type: smpte_offset
  
  # For each note number in the range of 35-98 there's
  # a mixer configuration. The first element in this array
  # of size 64 is note number 35, the last element is note
  # number 98. Since the default note number for pad A01
  # is 37, tweaking this pad's config will affect the 3rd
  # element in this array, and so on.
  #
  # Note that for each parameter in the config -- stereo mix,
  # indiv out, effects --the user needs to select the
  # sequence to be the source. By default, the source is set
  # to program, so it's easy to mistake the values in this
  # file for not being used at all.
  - id: mixer
    type: mixer
    repeat: expr
    repeat-expr: 64
    
  - size: 2
  
  - id: delays
    type: delays
    
  - size: 3
  
  - size: 16
  
  - id: last_active_track
    type: u1
    
  # Is 1 when there's only the initial tempo change.
  # Is 3 when there's the initial tempo change and one additional one.
  # Is 4 when there are 2 additional tempo changes.
  - id: number_of_tempo_changes
    type: u1
    
  # Is 3 with 1 active track.
  # Is 4 with 2 active tracks.
  # Is 5 with 3 active tracks.
  # Is 6 with 4 active tracks, etc.
  # So there's always 2 spare track headers.
  - id: number_of_active_track_headers
    type: u1
  
  - id: track_headers
    type: track_header
    repeat: expr
    repeat-expr: number_of_active_track_headers
  
  - id: tempo_changes
    type: tempo_change
    repeat: expr
    repeat-expr: number_of_tempo_changes
    
  - id: events
    type: event
    repeat: eos