meta:
  id: mpc3000_aps_v3
  file-extension: aps
  endian: le
  title: MPC60/3000 APS File Format (Version 3)

# Known producers currently evidenced:
# - MPC3000 OS 3.11
# - MPC3000 OS 3.10

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
    valid:
      min: 0
      max: 23
    doc: |
      Active program at save time. Roger Linn's notes phrase the visible
      domain as `1-8` / `1-24` depending on model, but a dedicated live MAME
      MPC3000 v3.10 contrast save established that the on-disk byte is
      zero-based: a file showing `Active program: 1` carries raw value `0`,
      and changing the visible value to `2` changes the serialized byte to
      `1`. The current preserved corpus only covers the MPC3000 24-program
      case, hence the present `0..23` validation range.
    
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
    doc: |
      Saved `Record Live Changes` flag from the Mix Source / Auto Mix screen.
      Roger Linn's notes define the visible boolean as `0 = yes`, `1 = no`.

  - id: center_pad_16_levels_if_param_tuning
    type: u1
    doc: |
      Persisted center pad from the MPC3000 `Assign '16 Levels'` screen when
      `Param = NOTE VAR (TUNING)`. Dedicated MAME MPC3000 v3.10 APS contrast
      saves established that the raw stored byte is the visible pad number
      itself, with observed domain `4..13`, not a normalized `0..9` index.

  - id: audio_trigger_assign
    type: u1
    valid:
      min: 0
      max: 98
    doc: |
      Audio Trigger screen assignment. Roger Linn's notes describe the visible
      domain as note numbers `35..98` or `0` for off/unassigned. On the live
      MPC3000 v3.10 `Audio Trigger (Use Sync Input)` screen, the off state is
      rendered as `Plays note:--/OFF`, which matches the Roger note's
      serialized `0` convention. The exact consumer mapping in VMPC-style
      models is still unresolved.

  - id: effects_settings
    type: effects_settings
    doc: |
      Top-level delay/effects block. Roger Linn's notes state that this block is
      meaningful when `effects_source = master`.
  
  - id: mixer_settings
    type: mixer_settings
    repeat: expr
    repeat-expr: 64
    doc: Real MPC3000 OS 3.11 empty APS evidence puts a 64-entry top-level
         mixer table here, despite Roger Linn's note reading like a single
         master mixer record. Roger Linn's notes clarify that these entries are
         the master-level mixer settings used when `stereo_mix_source = master`.

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
    doc: Global 128-entry sound-name table. Roger Linn's APS v3 notes place
         this earlier in the file, but real MPC3000 OS 3.11 empty APS evidence
         currently points at a trailing table after the program blocks.

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
        0: end
        1: start
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
      - id: cutoff_note_1
        type: u1
      - id: cutoff_note_2
        type: u1
      - id: tune
        type: s2
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
        doc: Roger Linn's notes define `1 = on`, `0 = off`.
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
        doc: Roger Linn's notes define the visible domain as 1..1486 ms.
      - id: delay_msecs_tap2
        type: u2
        doc: Roger Linn's notes define the visible domain as 1..1486 ms.
      - id: delay_msecs_tap3
        type: u2
        doc: Roger Linn's notes define the visible domain as 1..1486 ms.
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
