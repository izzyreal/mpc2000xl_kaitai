meta:
  id: mpc2000xl_all
  file-extension: all
  bit-endian: le

enums:
  sequence_is_used:
    0: no
    641: yes
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
  no_yes:
    0: no
    1: yes
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
          
  sequence:
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
  
  - id: sequences
    type: sequence
    repeat: expr
    repeat-expr: 99
  
  - id: songs
    type: song
    repeat: expr
    repeat-expr: 20