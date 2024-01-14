meta:
  id: mpc3000_pgm_v3
  file-extension: pgm
  endian: le
  bit-endian: le

seq:
  - id: file_id
    contents: [0x07]

  - id: file_version
    contents: [0x00]
    doc: According to a document provided by Roger Linn, this byte
         should be set to 0, despite it being a property in the
         description for PGM file version 3.

  - id: sound_names
    type: sound_name
    repeat: expr
    repeat-expr: 128

  - id: sound_sizes
    type: u4le
    repeat: expr
    repeat-expr: 128

  - id: program_name
    type: str
    encoding: ASCII
    terminator: 0xff
    size: 17

  - id: note_variation_screen
    type: note_variation

  - id: effects_screen
    type: effects_screen

  - id: sound_assignments
    type: sound_assignment
    repeat: expr
    repeat-expr: 64

  - id: mixer_screens
    type: mixer_screen
    repeat: expr
    repeat-expr: 64

  - id: pad_note_number_assignments
    type: pad_note_number_assignment
    repeat: expr
    repeat-expr: 64
    doc: Note number assignments for pads A01..D16

types:
  sound_name:
    seq:
      - id: name
        type: str
        size: 17
        terminator: 0x00
        encoding: ASCII

  note_variation:
    seq:
      - id: note_number_assignment
        type: u1
      - id: tuning_low_range
        type: u1
      - id: tuning_hi_range
        type: u1
      - id: attack_low_range
        type: u1
      - id: attack_hi_range
        type: u1
      - id: decay_low_range
        type: u1
      - id: decay_hi_range
        type: u1
      - id: filter_low_range
        type: u1
      - id: filter_hi_range
        type: u1

  effects_screen:
    seq:
      - id: effects_on
        type: b1
      - type: b7
      - type: u1
        doc: Unused
      - id: delay_volume_tap1
        type: u1
      - id: delay_volume_tap2
        type: u1
      - id: delay_volume_tap3
        type: u1
      - id: delay_pan_tap1
        type: u1
      - id: delay_pan_tap2
        type: u1
      - id: delay_pan_tap3
        type: u1
      - id: delay_msecs_tap1
        type: u2
      - id: delay_msecs_tap2
        type: u2
      - id: delay_msecs_tap3
        type: u2
      - size: 6
        doc: Unused
      - id: delay_feedback_tap1
        type: u1
      - id: delay_feedback_tap2
        type: u1
      - id: delay_feedback_tap3
        type: u1
      - size: 13
        doc: Unused

  sound_assignment:
    seq:
      - id: sound_number
        type: u1
      - id: sound_generator_mode
        type: u1
        enum: sound_generator_mode
      - id: if_over1
        type: u1
      - id: use_also_plays1
        type: u1
      - id: if_over2
        type: u1
      - id: use_also_plays2
        type: u1
      - id: poly
        enum: poly_mode
        type: u1
      - id: cutoff1
        type: u1
      - id: cutoff2
        type: u1
      - id: tune
        type: u2
      - id: attack
        type: u1
      - id: decay
        type: u1
      - id: decay_mode
        type: u1
        enum: decay_mode
      - id: filter_frequency
        type: u1
      - id: filter_resonance
        type: u1
      - id: filter_envel_attack
        type: u1
      - id: filter_envel_decay
        type: u1
      - id: filter_envel_amount
        type: u1
      - id: veloc_mod_of_volume
        type: u1
      - id: veloc_mod_of_attack
        type: u1
      - id: veloc_mod_of_soft_start
        type: u1
      - id: veloc_mod_of_filter_freq
        type: u1
      - id: param
        type: u1
        enum: note_variation_type
      
  mixer_screen:
    seq:
      - id: stereo_mix_volume
        type: u1
      - id: stereo_mix_pan
        type: u1
      - id: echo_volume
        type: u1
      - id: out_assign
        type: b4
        enum: individual_out
      - type: b3
        doc: Unused
      - id: follow_stereo
        type: b1
  
  pad_note_number_assignment:
    seq:
      - id: note_number
        type: u1
        valid:
          min: 35
          max: 98

enums:
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
    
  note_variation_type:
    0: tune
    1: decay
    2: attack
    3: filter
  
  sound_generator_mode:
    0: normal
    1: simultaneous
    2: velocity_switch
    3: decay_switch
  
  poly_mode:
    0: poly
    1: mono
    2: note_off
  
  decay_mode:
    0: start
    1: end