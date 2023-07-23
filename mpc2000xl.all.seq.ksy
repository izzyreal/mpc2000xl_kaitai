meta:
  id: mpc2000xl_all_seq
  bit-endian: le

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

  sequence_name_part:
    seq:
      - id: name
        type: str
        encoding: ASCII
        size: 8

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
        if: name_part_1 != ""

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
  - size: 0x0710
  - size: 14406 - 0x710
  
  - id: sequences
    type: sequence
    repeat: eos
