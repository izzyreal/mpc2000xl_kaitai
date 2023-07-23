meta:
  id: mpc2000xl_aps
  file-extension: aps
  imports: mpc2000xl.pgm

enums:
  no_yes:
    0: no
    1: yes
  pad_assign:
    0: program
    1: masters
  mix_source:
    0: program
    1: drum

types:
  note:
    seq:
      - id: sound_index # 255 means OFF
        type: u1
      - size: 1
      - id: sound_generation_mode
        type: u1
        enum: mpc2000xl_pgm::sound_generation_mode
      - id: velocity_range_lower
        type: u1
      - id: also_play_use_note_1
        type: u1
      - id: velocity_range_upper
        type: u1
      - id: also_play_use_note_2
        type: u1
      - id: voice_overlap_mode
        type: u1
        enum: mpc2000xl_pgm::voice_overlap_mode
      - id: mute_assign_1
        type: u1
      - id: mute_assign_2
        type: u1
      - id: tune
        type: s2le
      - id: attack
        type: u1
      - id: decay
        type: u1
      - id: decay_mode
        type: u1
        enum: mpc2000xl_pgm::decay_mode
      - id: cutoff
        type: u1
      - id: resonance
        type: u1
      - id: velocity_envelope_to_filter_attack
        type: u1
      - id: velocity_envelope_to_filter_decay
        type: u1
      - id: velocity_envelope_to_filter_amount
        type: u1
      - id: velocity_to_level
        type: u1
      - id: velocity_to_attack
        type: u1
      - id: velocity_to_start
        type: u1
      - id: velocity_to_cutoff
        type: u1
      - id: slider_parameter
        type: u1
        enum: mpc2000xl_pgm::slider_parameter
      - id: velocity_to_pitch
        type: u1
  drum:
    seq:
      - id: pad_mixers
        type: mpc2000xl_pgm::pad_mixer
        repeat: expr
        repeat-expr: 64
        
      - size: 2
      
      - id: receive_program_change
        type: u1
        enum: no_yes
      - id: receive_midi_volume
        type: u1
        enum: no_yes
      - size: 1
      - id: program
        type: u1
        
      # These always mirror receive_program_change and
      # receive_midi_volume state. Optional reading, mandatory writing.
      - id: receive_program_change_duplicate
        type: u1
        enum: no_yes
      - id: receive_midi_volume_duplicate
        type: u1
        enum: no_yes
        
  global_parameters:
    seq:
      - type: b7
      - id: pad_to_internal_sound
        type: b1
        enum: no_yes
      - type: b7
      - id: pad_assign
        type: b1
        enum: pad_assign
      - type: b6
      - id: indiv_fx_source
        type: b1
        enum: mix_source
      - id: stereo_mix_source
        type: b1
        enum: mix_source
      - type: b3
      - id: record_mix_changes
        type: b1
        enum: no_yes
      - id: copy_pgm_mix_to_drum
        type: b1
        enum: no_yes
      - type: b3
      - id: fx_drum
        type: u1
      - size: 1
      - id: master_level
        type: u1
        
  aps_program_meta:
    seq:
      - id: index
        type: u1
      - id: body
        type: aps_program_body
        if: index < 24
      - type: u1
        # id: tail
        if: index > 23
        repeat: eos

  aps_program_body:
    seq:
      - size: 5
      - id: name
        type: str
        encoding: ASCII
        size: 17
      - id: slider
        type: mpc2000xl_pgm::slider
      - id: program_change
        type: u1
      - size: 5
      
      - id: note_parameters
        type: note
        repeat: expr
        repeat-expr: 64
      
      - size: 1
      
      - id: pad_mixers
        type: mpc2000xl_pgm::pad_mixer
        repeat: expr
        repeat-expr: 64
      
      - size: 3
      
      - id: pad_to_note_mapping
        type: s1
        repeat: expr
        repeat-expr: 64
      
      - size: 200

seq:
  - id: magic
    contents: [0x0a, 0x05]
  
  - id: sound_count
    type: u1
  
  - size: 1
  
  - id: sound_names
    type: str
    encoding: ASCII
    repeat: expr
    repeat-expr: sound_count
    size: 17
    
  - size: 1
    
  - id: name
    type: str
    encoding: ASCII
    size: 17

  - size: 1

  - id: global_parameters
    type: global_parameters
    
  - size: 1
    
  - id: master_pad_to_note_mapping
    type: s1
    repeat: expr
    repeat-expr: 64
  
  - size: 7
  
  - id: drum1
    type: drum
  
  - size: 4

  - id: drum2
    type: drum

  - size: 4

  - id: drum3
    type: drum

  - size: 4

  - id: drum4
    type: drum

  - size: 1

  # There can be exactly 1 to 24 (inclusive, i.e. [1, 24]) programs
  # in one APS file. The parser will always generate 1 redundant meta
  # object with index 0xFF at the end of the list of programs. This
  # object may be fully ignored.
  - id: aps_programs
    type: aps_program_meta
    repeat: eos
