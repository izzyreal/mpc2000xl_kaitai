meta:
  id: mpc3000_aps_v3
  file-extension: aps
  endian: le
  title: MPC60/3000 APS File Format (Version 3)

seq:
  - id: file_id
    contents: [0x0A]
    doc: File ID, should be 10
  - id: file_version
    contents: [0x00]
  - id: num_programs
    type: u1
    doc: Number of programs in file
  - id: total_samples
    type: u4
  - id: file_name
    type: str
    terminator: 0x00
    size: 17
    encoding: ASCII
  - id: active_program_number
    type: u1
    
  - id: stereo_mix_source
    type: u1
    enum: mix_source

  - id: indiv_out_echo_send_mix_source
    type: u1
    enum: mix_source

  - id: effects_source
    type: u1
    enum: mix_source
  
  - id: record_live_mix_changes
    type: u1

  - id: center_pad_16_levels_if_param_tuning
    type: u1

  - id: audio_trigger_assign
    type: u1
    valid:
      min: 0
      max: 98
    doc: 35-98 or 0

  - id: effects_settings
    type: effects_settings
  
  - id: mixer_settings
    type: mixer_settings
    repeat: expr
    repeat-expr: 64

  - id: programs
    type: program
    repeat: expr
    repeat-expr: num_programs

  - id: sound_names
    type: str
    encoding: ASCII
    terminator: 0x00
    size: 17
    repeat: expr
    repeat-expr: 128

enums:
  mix_source:
    0: master
    1: sequence
    2: program

types:
  sound_assignment:
    enums:
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
      note_variation_type:
        0: tune
        1: decay
        2: attack
        3: filter
    
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
  
  mixer_settings:
    seq:
      - id: stereo_mix_volume
        type: u1
      - id: stereo_mix_pan
        type: u1
      - id: echo_volume
        type: u1
      - id: out_assign_fol_ster
        type: u1

  program:
    types:
      pad_note_number_assignment:
        seq:
          - id: note_number
            type: u1
            valid:
              min: 35
              max: 98
    seq:
      - id: program_name
        type: str
        size: 17
        terminator: 0x00
        encoding: ASCII
      - id: note_variation
        type: note_variation
      - id: effects_settings
        type: effects_settings
      - id: sound_assignments
        type: sound_assignment
        repeat: expr
        repeat-expr: 64
      - id: mixer_settings
        type: mixer_settings
        repeat: expr
        repeat-expr: 64
      - id: pad_note_number_assignments
        type: pad_note_number_assignment
        repeat: expr
        repeat-expr: 64
        doc: Note number assignments for pads A01..D16
        
  effects_settings:
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