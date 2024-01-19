### WIP ###

meta:
  id: mpc60_set_v1
  file-extension: SET
  bit-endian: le

seq:
- id: file_id
  contents: [0x02]
  
- id: file_format_version
  contents: [0x00]

- id: total_number_of_sample_words
  type: u3le

- id: sound_directory_entry
  type: sound_directory_entry
  repeat: expr
  repeat-expr: 34

- id: sound_map
  repeat: expr
  repeat-expr: 34
  type: u1
  enum: physical_drum

- id: use_master_mix_data
  type: u1
  enum: use_master_mix_data

- id: master_stereo_mix
  size: 32

- id: master_stereo_pan
  size: 32
  
- id: master_echo_mix
  size: 32
  
- id: master_drum_tuning
  size: 64
  
- id: double_play_assignments
  size: 32

  # Version 2 only
- id: velocity_switch_on_off_for_each_double_play_assign
  size: 32

  # Version 2 only
- id: velocity_switch_threshold_value_for_each_double_play_assign
  size: 32
  
  # unused
- size: 770

- id: sound_samples
  type: b12
  repeat: until
  repeat-until: _io.eof

types:
  u3le:
    seq:
    - id: b12
      type: u2le
    - id: b3
      type: u1
    instances:
      value:
        value: 'b12 | (b3 << 16)'
  
  sound_directory_entry:
    types:
      sound_characteristics:
        seq:
        - id: normal_or_hihat_sound
          type: b1
          enum: normal_or_hihat
        - id: save_required
          type: b1
        - type: b5 # unused
        - id: filter
          type: b1
          enum: filter_range
        
    seq:
    - id: name
      type: str
      encoding: ASCII
      terminator: 0x00
      size: 17

    - id: shared_sound_link
      type: u1
      valid:
        min: 0
        max: 33
    
    - id: start_address_in_memory
      type: u4le
    
    - id: length_in_samples
      type: u4le
   
    - id: read_write_pointer
      type: u4le
      
    - id: start_address_for_playing
      type: u4le
      
    - id: time_from_start_of_data_to_start_play_msec
      type: u2le
    
    - id: time_from_start_of_data_to_end_of_play_msec
      type: u2le
    
    - id: attack_time_msec
      type: u2le
      
    - id: decay_time_msec
      type: u2le
      
    - id: pitch_factor
      type: u2le
  
    - id: attack_rate_sent_to_sound_generator
      type: u2le
      
    - id: decay_rate_sent_to_sound_generator
      type: u2le
      
    - id: decay_start_time
      type: u2le
   
    - id: sound_duration
      type: u2le
    
    - id: analog_output_jack
      type: u1
      enum: analog_output_jack
    
    - id: requested_stereo_mix_volume
      type: u1
    
    - id: requested_stereo_mix_pan
      type: u1
    
    - id: left_level_sent_to_sound_generator
      type: u1
      
    - id: right_level_sent_to_sound_generator
      type: u1
    
    - id: echo_level_sent_to_sound_generator
      type: u1
    
    - id: sound_characteristics
      type: sound_characteristics

enums:
  analog_output_jack:
    7: off
    8: jack_1
    9: jack_2
    10: jack_3
    11: jack_4
    12: jack_5
    13: jack_6
    14: jack_7
    15: jack_8
  
  normal_or_hihat:
    0: normal
    1: hihat
  
  filter_range:
    0: less_than_or_equals_47_khz
    1: greater_than_47_khz

  # Something is not lining up well yet. With the factory STUDIO and
  # ROCK SET files, element with 0-based index 10 in the sound_map is
  # PRC3, even though it would make more sense for it to be a DRnn.
  # Likewise, the 3 hihat entries in the sound_map are in indices
  # 18, 19 and 20, whereas the directory entries with those indices are
  # COWBEL, HAT2CLSD and HAT2MED. So there is some off-by-one error, or
  # this list of enum cases is incorrect, or I don't know how to map
  # directory entries to the sound map.
  # More investigation needed.
  physical_drum:
    0: hiht_clsd
    1: hiht_medm
    2: hiht_open
    3: snr1
    4: snr2
    5: bass
    6: tom1
    7: tom2
    8: tom3
    9: tom4
    10: rid1
    11: rid2
    12: crs1
    13: crs2
    14: prc1
    15: prc2
    16: prc3
    17: prc4
    18: dr01
    19: dr02
    20: dr03
    21: dr04
    22: dr05
    23: dr06
    24: dr07
    25: dr08
    26: dr09
    27: dr10
    28: dr11
    29: dr12
    30: dr13
    31: dr14
    32: dr15
    33: dr16
  
  use_master_mix_data:
    0: ignore
    1: use