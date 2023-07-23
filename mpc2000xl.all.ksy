meta:
  id: mpc2000xl_all
  file-extension: all
  bit-endian: le

types:
  track_status:
    seq:
      - id: unused_or_used
        type: b1
        enum: unused_used
      - id: off_or_on
        type: b1
        enum: off_on
      - id: transmit_program_changes
        type: b1
        enum: off_on
      - type: b5
      
  defaults:
    seq:
      - id: sequence_name
        type: str
        encoding: ASCII
        size: 16
        
      - size: 6
      
      - id: tempo
        type: u2le
      - id: numerator
        type: u1
      - id: denominator
        type: u1
      - id: bar_count
        type: u2le
        
      # For some reason when bar_count is 2, it is set to 0. Otherwise it has
      # the actual number of ticks that are in that number of bars at that
      # numerator/denominator time signature.
      - id: tick_count
        type: u2le
      
      - type: u4le
        id: unknown1
        repeat: expr
        repeat-expr: 4
        
      - size: 74
        id: unknown2
        
      # On MPC2000XL OS 1.2 Jul. 15,2004 I haven't found a way to modify these.
      # It can be treated like a hardcoded list as far as I can see. The list
      # looks like this: ["        ", "Device01", ... , "Device32"].
      - id: device_names
        type: str
        encoding: ASCII
        size: 8
        repeat: expr
        repeat-expr: 33

      # These can be found in the Track window next to 'Default:'.
      # Each of the 64 tracks has its own default name, and these can indeed
      # be edited.
      - id: track_names
        type: str
        encoding: ASCII
        size: 16
        repeat: expr
        repeat-expr: 64
      
      # Each of these 64 bytes is set to the device you have selected in
      # the USER tab.
      # On the real MPC2000XL, I haven't found a way to tweak these
      # individually, so all tracks are by default set to the same device.
      # 0 means OFF (i.e. no MIDI output). The range is 0 to 33 inclusive.
      - id: devices
        type: u1
        repeat: expr
        repeat-expr: 64
      
      # Same here, but from which bus is selected by default for any of the
      # 64 tracks. The range is 0 to 4 inclusive. Also see the 'bus' enum
      # above.
      - id: buses
        type: u1
        enum: bus
        repeat: expr
        repeat-expr: 64
      
      # Each track is by default set to program 0. I have not found a way
      # to tweak this on the real MPC2000XL. It seems like these are stored
      # individually, not to expose such high configurability to the user,
      # but to match the target in-memory representation. Or maybe in another
      # OS version than mine it is possible to tweak, I don't know.
      - id: programs
        type: u1
        repeat: expr
        repeat-expr: 64
      
      # Percentages from 1 to 200 used for multiplying the velocity of
      # note events non-destructively when playing back a sequence.
      # These too, I haven't a found a way to tweak, so they are alwasy set
      # to 100.
      - id: track_velocities
        type: u1
        repeat: expr
        repeat-expr: 64
      
      # These default to ON and UNUSED. Here too no way to tweak.
      - id: track_statuses
        type: track_status
        repeat: expr
        repeat-expr: 64
    
      # Unknown  
      - size: 64
        
  sequencer:
    seq:
      - id: active_sequence
        type: u1
      - size: 1
      - id: active_track
        type: u1
      - size: 4
      - id: timing_correct
        type: u1
        enum: timing_correct
      - size: 1
      - id: second_sequence_enabled
        type: b1
      - type: b7
      - id: sequence_sequence_index
        type: u1
        
  count:
    seq:
      - id: enabled
        type: b1
      - type: b7
      - id: count_in_mode
        type: u1
        enum: count_in_mode
      - id: click_volume
        type: u1
        valid:
          min: 0
          max: 100
      - id: rate
        type: u1
        enum: rate
      - id: enabled_in_play
        type: b1
      - type: b7
      - id: enabled_in_rec
        type: b1
      - type: b7
      - id: click_output
        type: u1
        enum: click_output
      - id: wait_for_key
        type: b1
      - type: b7
      - id: sound_source
        type: u1
        enum: sound_source
      - id: accent_pad_index
        type: u1
      - id: normal_pad_index
        type: u1
      - id: accent_velo
        type: u1
        valid:
          min: 1
          max: 127
      - id: normal_velo
        type: u1
        valid:
          min: 1
          max: 127
          
  midi_input:
    seq:
      - size: 1
      - id: receive_channel
        type: u1
        enum: midi_input_receive_channel
      - id: sustain_pedal_to_duration
        type: b1
      - type: b7
      - id: filter_enabled
        type: b1
      - type: b7
      - id: filter_type
        type: u1
        enum: midi_input_filter_type
      - id: multi_rec_enabled
        type: b1
      - type: b7
      - id: multi_rec_destination_tracks
        type: u1
        repeat: expr
        repeat-expr: 34
      
      - id: note_pass_enabled
        type: b1
      - type: b7
      
      - id: pitch_bend_pass_enabled
        type: b1
      - type: b7
      
      - id: pgm_change_pass_enabled
        type: b1
      - type: b7
      
      - id: ch_pressure_pass_enabled
        type: b1
      - type: b7
      
      - id: poly_pressure_pass_enabled
        type: b1
      - type: b7
      
      - id: exclusive_pass_enabled
        type: b1
      - type: b7
      
      - id: cc_pass_enabled
        type: b1
        repeat: expr
        repeat-expr: 128

  midi_sync:
    seq:
      - id: in_mode
        type: u1
        enum: midi_sync_mode
      - id: out_mode
        type: u1
        enum: midi_sync_mode
      - id: shift_early
        type: u1
        valid:
          min: 0
          max: 20
      - id: send_mmc_enabled
        type: b1
      - type: b7
      - id: frame_rate
        type: u1
        enum: frame_rate
      - id: input
        type: u1
      - id: output
        type: u1
        enum: midi_sync_output
        
  midi_switch:
    seq:
      - id: controller
        type: u1
        valid:
          min: 0
          max: 127
      - id: function
        type: u1
        enum: midi_switch_function

  misc:
    seq:
      - id: tap_averaging # In OTHER (shift + 8)
        type: u1
        enum: tap_averaging
      - id: midi_sync_in_receive_mmc_enabled # In MIDI/SYNC (shift + 9, F1)
        type: b1
      - id: midi_switch # In MIDIsw (shift + 9, F3)
        type: midi_switch
        repeat: expr
        repeat-expr: 4
      
  step_edit_options:
    seq:
      - id: auto_step_increment 
        type: b1
      - id: duration_of_recorded_notes
        type: u1
        enum: duration_of_recorded_notes
      - id: tc_value_percentage
        type: u1
        valid:
          min: 0
          max: 100
          
  sequence_meta:
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
      - id: is_used
        type: u2le
        enum: sequence_is_used
  
  song_step:
    seq:
      - id: sequence_index
        type: u1
      - id: repeat_count
        type: u1
  
  song:
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 16
      - id: steps
        type: song_step
        repeat: expr
        repeat-expr: 250
      - size: 2
      - id: is_used
        type: b1
      - size: 2
      - id: is_loop_enabled
        type: b1
      - size: 6
  bar:
    seq:
      - id: start_tick
        type: b24
      - id: ticks_per_beat
        type: u1

  tracks:
    seq:
      - id: names
        type: str
        encoding: ASCII
        size: 16
        repeat: expr
        repeat-expr: 64
      - id: device
        type: u1
        repeat: expr
        repeat-expr: 64
      - id: bus
        type: u1
        enum: bus
        repeat: expr
        repeat-expr: 64
      - id: program_change
        type: u1
        repeat: expr
        repeat-expr: 64
      - id: velocity_ratio
        type: u1
        repeat: expr
        repeat-expr: 64
      - id: status
        type: track_status
        repeat: expr
        repeat-expr: 64
      - id: unknown
        size: 64
  
  note_event:
    seq:
      - id: duration_bits_3
        type: u1
      - id: velocity
        type: b7
      - id: variation_type_bit_1
        type: b1
      - id: variation_value
        type: b7
      - id: variation_type_bit_2
        type: b1

    enums:
      note_variation_type:
        0: tune
        1: decay
        2: attack
        3: filter
        
    instances:
      note:
        value: _parent.id
      duration:
        value: (_parent.duration_bits_1 << 10) + (_parent.duration_bits_2 << 8) + duration_bits_3
      variation_type:
        value: (variation_type_bit_1.as<u1> << 1) | variation_type_bit_2.as<u1>
        enum: note_variation_type

  pitch_bend_event:
    seq:
      - id: amount_bits_1
        type: b8
      - id: amount_bits_2
        type: b8
      - size: 1
    instances:
      corrected_amount:
        value: (amount_bits_1 + (amount_bits_2 << 7)) - 8192

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
      - size: 1
          
  program_change_event:
    seq:
      - id: program
        type: u1
        valid:
          min: 0
          max: 127
      - size: 2

  ch_pressure_event:
    seq:
      - id: pressure
        type: u1
        valid:
          min: 0
          max: 127
      - size: 2
      
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
      - size: 1

  mixer_event:
    seq:
      - size: 3
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
      - size: 2

  exclusive_event:
    seq:
      - size: 3
      - id: bytes
        size: 2
      - id: mixer
        type: mixer_event
        if: bytes == [ 0xF0, 0x47]
      - size: 14

  event:
    # We start off by collecting some essentials, while performing terminator
    # lookahead in the meantime.
    # The main field we need to parse here is the 'id'. It determines the
    # event type, resulting in various ways to interpret the 8 bytes that
    # make up one event.
    seq:
      - id: tick
        type: b20
      - id: duration_bits_1
        type: b4
        if: tick < 0xFFFFF
      - id: track
        type: b6
        if: tick < 0xFFFFF
      - id: duration_bits_2
        type: b2
        if: tick < 0xFFFFF
      - id: id
        type: u1
        if: tick < 0xFFFFF

      - id: note_event
        type: note_event
        if: tick < 0xFFFFF and id <= 0x7F

      - id: pitch_bend
        if: tick < 0xFFFFF and id == 0xE0
        type: pitch_bend_event
        
      - id: control_change
        if: tick < 0xFFFFF and id == 0xB0
        type: control_change_event
      
      - id: program_change
        if: tick < 0xFFFFF and id == 0xC0
        type: program_change_event

      - id: ch_pressure
        if: tick < 0xFFFFF and id == 0xD0
        type: ch_pressure_event
       
      - id: poly_pressure
        if: tick < 0xFFFFF and id == 0xA0
        type: poly_pressure_event
       
      - id: exclusive
        if: tick < 0xFFFFF and id == 0xF0
        type: exclusive_event
      
      - id: terminator
        if: tick >= 0xFFFFF
        size: 5

  sequence:
    seq:
      - id: name_part_1
        type: str
        terminator: 0xFF
        encoding: ASCII
        size: 8
        
      - id: name_part_2
        type: str
        terminator: 0xFF
        encoding: ASCII
        size: 8
        if: name_part_1 != ""

      - id: body
        type: sequence_body
        if: name_part_1 != ""
    instances:
      name:
        value: name_part_1 + name_part_2
        if: name_part_1 != "" and name_part_2 != ""

  sequence_body:
    seq:
      - id: is_used
        type: u2le
        enum: sequence_is_used
      - id: index
        type: u1
        doc: Warning! 1-based. You'll need this to put the sequence in the right slot
      - size: 7
      - id: bar_count
        type: u2le
      - id: last_tick
        type: u4le
      - size: 16
      - id: loop_start_bar_index
        type: u2le
      - id: loop_end_bar_index
        type: u2le # 0xff 0xff / 65535 means END
      - size: 12
      - id: last_tick2
        type: u4le
      - size: 52
      - id: device_names
        type: str
        encoding: ASCII
        size: 8
        repeat: expr
        repeat-expr: 33
      - id: tracks
        type: tracks
        
      - size: 3584

      - id: bars
        type: bar
        repeat: expr
        repeat-expr: bar_count + 1
      
      - type: bar
        repeat: expr
        repeat-expr: (999 - bar_count) - 1
        
      - size: 4452 - 3584
      
      - id: events
        type: event
        repeat: until
        repeat-until: _.tick == 0xFFFFF
        
seq:
  - id: magic
    contents: [MPC2KXL ALL 1.00]

  # Most of these can be found in the MAIN > EDIT (F2) > USER (F4) tab.    
  - id: defaults
    type: defaults

  - id: sequencer
    type: sequencer
  
  - size: 10
  
  - id: count
    type: count
    
  - id: midi_input
    type: midi_input
  
  - size: 0
  
  - id: midi_sync
    type: midi_sync
  
  - id: default_song_name
    type: str
    encoding: ASCII
    size: 16
  
  - size: 42
  
  - id: misc
    type: misc
  
  - size: 3
  
  - id: step_edit_options
    type: step_edit_options
  
  - id: prog_change_to_seq # MIDI Input window
    type: b1
  
  - size: 78
  
  - id: sequences_metas
    type: sequence_meta
    repeat: expr
    repeat-expr: 99
  
  - id: songs
    type: song
    repeat: expr
    repeat-expr: 20
    
  - id: sequences
    type: sequence
    repeat: eos

enums:
  mixer_event_param:
    1: stereo_level
    2: stereo_pan
    3: fxsend_level
    5: indiv_level
  sequence_is_used:
    0: no
    641: yes
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
  duration_of_recorded_notes:
    0: as_played
    1: tc_value
  tap_averaging:
    0: tap_avg_2
    1: tap_avg_3
    2: tap_avg_4
  frame_rate:
    0: fps_24
    1: fps_25
    2: fps_30d
    3: fps_30
  midi_input_filter_type:
    0: notes
    1: pitch_bend
    2: prog_change
    3: ch_pressure
    4: poly_press
    5: exclusive
    6: cc0_bank_sel_msb
    7: cc1_mod_wheel
    8: cc2_breath_cont
    9: cc3
    10: cc4_foot_control
    11: cc5_porta_time
    12: cc6_data_entry
    13: cc7_main_volume
    14: cc8_balance
    15: cc9
    16: cc10_pan
    17: cc11_expression
    18: cc12_effect_1
    19: cc13_effect_2
    20: cc14
    21: cc15
    22: cc16_gen_pur_1
    23: cc17_gen_pur_2
    24: cc18_gen_pur_3
    25: cc19_gen_pur_4
    26: cc20
    27: cc21
    28: cc22
    29: cc23
    30: cc24
    31: cc25
    32: cc26
    33: cc27
    34: cc28
    35: cc29
    36: cc30
    37: cc31
    38: cc32_bank_sel_lsb
    39: cc33_mod_whel_lsb
    40: cc34_breath_lsb
    41: cc35
    42: cc36_foot_cnt_lsb
    43: cc37_port_time_ls
    44: cc38_data_ent_lsb
    45: cc39_main_vol_lsb
    46: cc40_balance_lsb
    47: cc41
    48: cc42_pan_lsb
    49: cc43_express_lsb
    50: cc44_effect_1_lsb
    51: cc45_effect_2_msb
    52: cc46
    53: cc47
    54: cc48_gen_pur_1_ls
    55: cc49_gen_pur_2_ls
    56: cc50_gen_pur_3_ls
    57: cc51_gen_pur_4_ls
    58: cc52
    59: cc53
    60: cc54
    61: cc55
    62: cc56
    63: cc57
    64: cc58
    65: cc59
    66: cc60
    67: cc61
    68: cc62
    69: cc63
    70: cc64_sustain_pdl
    71: cc65_porta_pedal
    72: cc66_sostenuto
    73: cc67_soft_pedal
    74: cc68_legato_ft_sw
    75: cc69_hold_2
    76: cc70_sound_vari
    77: cc71_timber_harmo
    78: cc72_release_time
    79: cc73_attack_time
    80: cc74_brightness
    81: cc75_sound_cont_6
    82: cc76_sound_cont_7
    83: cc77_sound_cont_8
    84: cc78_sound_cont_9
    85: cc79_sound_cont10
    86: cc80_gen_pur_5
    87: cc81_gen_pur_6
    88: cc82_gen_pur_7
    89: cc83_gen_pur_8
    90: cc84_porta_cntrl
    91: cc85
    92: cc86
    93: cc87
    94: cc88
    95: cc89
    96: cc90
    97: cc91_ext_eff_dpth
    98: cc92_tremolo_dpth
    99: cc93_chorus_depth
    100: cc94_detune_depth
    101: cc95_phaser_depth
    102: cc96_data_incre
    103: cc97_data_decre
    104: cc98_nrpn_lsb
    105: cc99_nrpn_msb
    106: cc100_rpn_lsb
    107: cc101_rpn_msb
    108: cc102
    109: cc103
    110: cc104
    111: cc105
    112: cc106
    113: cc107
    114: cc108
    115: cc109
    116: cc110
    117: cc111
    118: cc112
    119: cc113
    120: cc114
    121: cc115
    122: cc116
    123: cc117
    124: cc118
    125: cc119
    126: cc120_all_snd_off
    127: cc121_reset_contrl
    128: cc122_local_on_off
    129: cc123_all_note_off
    130: cc124_omni_off
    131: cc125_omni_on
    132: cc126_mono_mode_on
    133: cc127_poly_mode_on
    
  midi_switch_function:
    0: play_strt
    1: play
    2: stop
    3: rec_and_play
    4: odub_and_play
    5: rec_punch
    6: odub_pnch
    7: tap
    8: pad_bnk_a
    9: pad_bnk_b
    10: pad_bnk_c
    11: pad_bnk_d
    12: pad_1
    13: pad_2
    14: pad_3
    15: pad_4
    16: pad_5
    17: pad_6
    18: pad_7
    19: pad_8
    20: pad_9
    21: pad_10
    22: pad_11
    23: pad_12
    24: pad_13
    25: pad_14
    26: pad_15
    27: pad_16
    28: f1
    29: f2
    30: f3
    31: f4
    32: f5
    33: f6

  midi_input_receive_channel:
    0: all
    1: ch1
    2: ch2
    3: ch3
    4: ch4
    5: ch5
    6: ch6
    7: ch7
    8: ch8
    9: ch9
    10: ch10
    11: ch11
    12: ch12
    13: ch13
    14: ch14
    15: ch15
    16: ch16
  bus:
    0: midi
    1: drum1
    2: drum2
    3: drum3
    4: drum4
  off_on:
    0: off
    1: on
  unused_used:
    0: unused
    1: used
  timing_correct:
    0: off
    1: one_8
    2: one_8_3
    3: one_16
    4: one_16_3
    5: one_32
    6: one_32_3
  count_in_mode:
    0: off
    1: rec_only
    2: rec_and_play
  rate:
    0: one_4
    1: one_4_3
    2: one_8
    3: one_8_3
    4: one_16
    5: one_16_3
    6: one_32
    7: one_32_3
  sound_source:
    0: click
    1: drum1
    2: drum2
    3: drum3
    4: drum4
  click_output:
    0: stereo
    1: indiv1
    2: indiv2
    3: indiv3
    4: indiv4
    5: indiv5
    6: indiv6
    7: indiv7
    8: indiv8
  midi_sync_mode:
    0: off
    1: midi_clock
    2: time_code
  midi_sync_output:
    0: a
    1: b
    2: a_and_b
