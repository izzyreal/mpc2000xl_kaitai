### WIP ###

meta:
  id: mpc3000_seq_v3
  file-extension: mpc3000.seq.v3
  bit-endian: le

enums:
  off_on:
    0: off
    1: on
  no_yes:
    0: no
    1: yes
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

types:

  # I'm currently unsure about endianness of 24-bit values.
  # It seems likely that the below is correct, given that
  # everything seen so far in MPC file formats is little
  # endian. But if 24-bit values are looking off, we can
  # simplify them to use type 'b24' rather than this custom
  # 'u3le'.
  u3le:
    seq:
      - id: b12
        type: u2le
      - id: b3
        type: u1
    instances:
      value:
        value: 'b12 | (b3 << 16)'

  smpte_offset:
    seq:
    - id: hundredth_frames
      type: u1
      valid:
        min: 0
        max: 99
    - id: frames
      type: u1
      valid:
        min: 0
        # The user-facing max value is dictated by the
        # number of frames, which is not stored in SEQ files.
        # It is stored in PAR and ALL files. But in terms of
        # file specification, this value never goes over 29.
        max: 29
    - id: seconds
      type: u1
      valid:
        min: 0
        max: 59
    - id: minutes
      type: u1
      valid:
        min: 0
        max: 59
    - id: hours
      type: u1
      valid:
        min: 0
        max: 23
    
  sequence_header:
    seq:
    - id: sequence_number
      type: u1
    - id: sequence_length_in_bytes # excluding sequence header
      type: u3le

    # unknown
    - size: 5    

    - id: sequence_name
      type: str
      encoding: ASCII
      size: 16
    
    - size: 1 # unknown
    
    - id: loop_to_bar
      type: b1
      enum: off_on
    - type: b7
    - id: loop_to_bar_number
      type: u2le
    - id: number_of_bars
      type: u2le
    - id: length_in_ticks
      type: u4le
    - id: tempo
      type: u2le
  
  mixer:
    seq:
    - id: stereo_mix
      type: u1
      valid:
        min: 0
        max: 100
    - id: stereo_pan # to be verified
      type: u1
      valid:
        min: 0
        max: 100
    - id: individual_out_mix # to be verified
      type: u1
    - id: individual_out # to be verified
      type: b7
      enum: individual_out
    - id: follow_stereo
      type: b1
      enum: no_yes

  delays:
    seq:
    - id: volume1
      type: u1
    - id: volume2
      type: u1
    - id: volume3
      type: u1
    - id: pan1
      type: u1
    - id: pan2
      type: u1
    - id: pan3
      type: u1
    - id: time1
      type: u2le
    - id: time2
      type: u2le
    - id: time3
      type: u2le
    - id: feedback1
      type: u1
    - id: feedback2
      type: u1
    - id: feedback3
      type: u1

  track_header:
    seq:
    # If -1, it means this track header is unused.
    # Otherwise, it is the 1-based index of the track
    # within the SEQ file as far as I can see.
    - id: absolute_recorded_track_number
      type: s1
    
    - size: 23
      if: absolute_recorded_track_number == -1
    
    - id: user_track_number
      type: u1
      if: absolute_recorded_track_number != -1
    - id: track_mute
      type: b1
      if: absolute_recorded_track_number != -1
    - id: track_in_use
      type: b1
      if: absolute_recorded_track_number != -1
    - id: drum_track
      type: b1
      if: absolute_recorded_track_number != -1
    - type: b5
      if: absolute_recorded_track_number != -1
    - id: primary_port_channel_assignment
      type: u1
      if: absolute_recorded_track_number != -1
    - id: secondary_port_channel_assignment
      type: s1
      if: absolute_recorded_track_number != -1
    - id: track_name
      type: str
      encoding: ASCII
      size: 16
      if: absolute_recorded_track_number != -1
    - id: track_volume
      type: u1
      valid:
        min: 1
        max: 200
      if: absolute_recorded_track_number != -1
    - id: program_change_number
      type: u1
      if: absolute_recorded_track_number != -1
      
    - size: 1
      if: absolute_recorded_track_number != -1

  tempo_change:
    seq:
    - id: ticks_from_sequence_start
      type: u4le
    - id: factor1
      type: b12
    - id: factor2
      type: b4
    instances:
      factor_percentage:
        value: '((factor1 / 4096.0) * 100) + (factor2 * 100)'

seq:
  - id: file_id
    contents: [0x03]
  
  - id: file_format_version
    contents: [0x03]
    
  - id: sequence_header
    type: sequence_header
    
  # Can be changed in the Tempo/Sync > Sync In section,
  # when Mode: is set to MIDI TIME CODE.
  - id: smpte_offset
    type: smpte_offset
  
  # For each note number in the range of 35-98 there's
  # a mixer configuration. The first element in this array
  # of size 64 is note number 35, the last element is note
  # number 98. Since the default note number for pad A01
  # is 37, tweaking this pad's config will affect the 3rd
  # element in this array, and so on.
  #
  # Note that for each parameter in the config -- stereo mix,
  # indiv out, effects --the user needs to select the
  # sequence to be the source. By default, the source is set
  # to program, so it's easy to mistake the values in this
  # file for not being used at all.
  - id: mixer
    type: mixer
    repeat: expr
    repeat-expr: 64
    
  - size: 2
  
  - id: delays
    type: delays
    
  - size: 3
  
  - size: 16
  
  - id: last_active_track
    type: u1
    
  # Is 1 when there's only the initial tempo change.
  # Is 3 when there's the initial tempo change and one additional one.
  # Is 4 when there are 2 additional tempo changes.
  - id: number_of_tempo_changes
    type: u1
    
  # Is 3 with 1 active track.
  # Is 4 with 2 active tracks.
  # Is 5 with 3 active tracks.
  # Is 6 with 4 active tracks, etc.
  # So there's always 2 spare track headers.
  - id: number_of_active_track_headers
    type: u1
  
  - id: track_headers
    type: track_header
    repeat: expr
    repeat-expr: number_of_active_track_headers
  
  - id: tempo_changes
    type: tempo_change
    repeat: expr
    repeat-expr: number_of_tempo_changes