meta:
  id: mpc3000_pgm_v3
  file-extension: pgm
  endian: le
  bit-endian: le

# Known producers currently evidenced:
# - MPC3000 OS 3.11
# - MPC3000 OS 3.10

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
        doc: Confirmed by MAME MPC3000 v3.10 contrast saves and Roger Linn's
             MPC file-format notes. Byte value 0 is NORMAL, 1 is SIMULT, 2
             is VEL SW, and the doc describes 3 as DCY SW.
      - id: if_over1
        type: u1
        doc: Active on switch-based generator modes. The exact UI-to-byte
             mapping was probed on MAME MPC3000 v3.10. In a saved VEL SW
             contrast, changing the first visible threshold from 44 to 43
             changed this byte from 0x2c to 0x2b.
      - id: use_also_plays1
        type: u1
        doc: Active on switch-based generator modes. In a saved VEL SW
             contrast, changing the first visible target from OFF to 35/C14
             changed this byte from 0x22 to 0x23.
      - id: if_over2
        type: u1
        doc: Active on switch-based generator modes. Confirmed by MAME
             MPC3000 v3.10 contrast saves after correcting the note-record
             table start to file offset 2752.
      - id: use_also_plays2
        type: u1
        doc: Active on switch-based generator modes and simultaneous mode.
             Confirmed by MAME MPC3000 v3.10 contrast saves after correcting
             the note-record table start to file offset 2752.
      - id: poly
        enum: poly_mode
        type: u1
        doc: Confirmed by MAME MPC3000 v3.10 contrast saves and Roger Linn's
             MPC file-format notes. 0 = POLY, 1 = MONO, 2 = NOTE OFF.
      - id: cutoff_note_1
        type: u1
        doc: First cutoff-assignment note number from the Env,Veloc.. screen.
             This is not a filter cutoff value. Roger Linn's file-format
             notes describe it as 'Cutoff 1 (notes 35-98 or 0)' and live
             saves matched visible values like 64/B12.
      - id: cutoff_note_2
        type: u1
        doc: Second cutoff-assignment note number from the Env,Veloc.. screen.
             This is not a filter cutoff value. Roger Linn's file-format
             notes describe it as 'Cutoff 2 (notes 35-98 or 0)' and live
             saves matched visible values like 65/B05.
      - id: tune
        type: s2
        doc: Signed tune value. Confirmed by a MAME MPC3000 v3.10 contrast
             save where visible `Tune:-1` wrote `0xffff`.
      - id: attack
        type: u1
      - id: decay
        type: u1
        doc: Real empty hardware PROGRAM.pgm carries value 6 in every record,
             while MAME MPC3000 v3.10 Initialize Program writes 0 in every
             record.
      - id: decay_mode
        type: u1
        enum: decay_mode
        doc: |
          Confirmed by a dedicated MAME MPC3000 v3.10 contrast save:
          visible `Dcy md:START` wrote byte value 1, so the firmware's file
          encoding is 0 = END and 1 = START.
      - id: filter_frequency
        type: u1
        doc: Dynamic lowpass filter cutoff parameter from the Dynamic Filter
             screen. The MPC3000 manual defines the visible range as 0..100,
             where 0 is about 70 Hz and 100 places the filter fully out.
      - id: filter_resonance
        type: u1
        doc: Dynamic lowpass filter resonance parameter from the Dynamic Filter
             screen. The MPC3000 manual defines the visible range as 0..15.
      - id: filter_envel_attack
        type: u1
        doc: Filter envelope attack parameter from the Dynamic Filter screen.
             The MPC3000 manual defines 101 exponentially spaced values
             representing 0..5000 ms.
      - id: filter_envel_decay
        type: u1
        doc: Filter envelope decay parameter from the Dynamic Filter screen.
             The MPC3000 manual defines 101 exponentially spaced values
             representing 0..5000 ms.
      - id: filter_envel_amount
        type: u1
        doc: Filter envelope amount parameter from the Dynamic Filter screen.
             The MPC3000 manual defines the visible range as 0..100 percent.
      - id: veloc_mod_of_volume
        type: u1
      - id: veloc_mod_of_attack
        type: u1
      - id: veloc_mod_of_soft_start
        type: u1
      - id: veloc_mod_of_filter_freq
        type: u1
        doc: Velocity modulation of filter frequency (`Vel>Freq`) from the
             Dynamic Filter screen. The MPC3000 manual defines the visible
             range as 0..100 percent.
      - id: param
        type: u1
        enum: note_variation_type
        doc: Per-note note-variation parameter selector. Roger Linn's
             file-format notes describe 0 = TUNING, 1 = DECAY, 2 = ATTACK,
             3 = FILTER.
      
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
    0: end
    1: start
