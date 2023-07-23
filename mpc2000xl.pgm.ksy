meta:
  id: mpc2000xl_pgm
  file-extension: pgm

enums:
  sound_generation_mode:
    0: normal
    1: simult
    2: vel_sw
  voice_overlap_mode:
    0: poly
    1: mono
    2: note_off
  decay_mode:
    0: end
    1: start
  slider_parameter:
    0: tuning
    1: decay
    2: attack
    3: filter
  fx_output:
    0: none # renders on MPC2000XL as '--'
    1: m1
    2: m2
    1: r1
    2: r2

types:
  slider:
    seq:
      - id: note
        type: u1
      - id: tune_low
        type: s1
      - id: tune_high
        type: s1
      - id: decay_low
        type: s1
      - id: decay_high
        type: s1
      - id: attack_low
        type: s1
      - id: attack_high
        type: s1
      - id: filter_low
        type: s1
      - id: filter_high
        type: s1

  note:
    seq:
      - id: sound_index # 255 means OFF
        type: u1
      - id: sound_generation_mode
        type: u1
        enum: sound_generation_mode
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
        enum: voice_overlap_mode
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
        enum: decay_mode
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
        enum: slider_parameter
      - id: velocity_to_pitch
        type: u1

  pad_mixer:
    seq:
      - id: fx_output
        type: u1
        enum: fx_output
      - id: volume
        type: u1
      - id: pan
        type: u1
      - id: volume_individual
        type: u1
      - id: output
        type: u1
      - id: effects_send_level
        type: u1

seq:
  - id: magic
    contents: [0x07, 0x04]
    
  - id: sound_count
    type: u2le
    
  - id: sound_names
    type: str
    encoding: ASCII
    repeat: expr
    repeat-expr: sound_count
    size: 17
    
  - size: 1
  
  - id: name
    type: str
    size: 16
    encoding: ASCII
    
  - size: 2
    
  - id: slider
    type: slider

  - id: program_change
    type: u1

  - size: 5
  
  # For each mappable MIDI note, i.e. in the range of 35-98 inclusive,
  # there's a set of parameters, like which sound is selected, filter
  # cutoff and resonance, envelope attack and decay, tune, etc.
  - id: note_parameters
    type: note
    repeat: expr
    repeat-expr: 64
  
  - size: 1
  
  # For each pad in a program, there is a mixer strip
  - id: pad_mixers
    type: pad_mixer
    repeat: expr
    repeat-expr: 64
  
  - size: 3
  
  # A sequence of 64 bytes describing for each pad which MIDI note
  # is mapped to it. The same note can be mapped to multiple pads.
  # A value of -1 means no note is mapped to this pad and this is
  # rendered as '--'. The rest of the values are in the range of
  # 35-98 inclusive.
  - id: pad_to_note_mapping
    type: s1
    repeat: expr
    repeat-expr: 64
  
  # I haven't reverse engineered it, but I'm pretty sure this is the
  # EB16 effects board section.
  - size: 200