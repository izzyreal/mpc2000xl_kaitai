meta:
  id: all_v3
  file-extension: all
  bit-endian: le
  imports:
    - seq.v3

# Shared `04 03` ALL family.
#
# Known producers currently evidenced:
# - hardware MPC3000 OS 3.11
# - MPC3000 OS 3.10
# - MPC60 firmware 2.12
#
# Current evidence shows these files are structurally indistinguishable at the
# file-format level, so the canonical filename is family/version-oriented
# rather than model-oriented.
    
seq:
  - id: all_file_header
    type: all_file_header
    
  - id: sequences
    type: sequence
    repeat: until
    # Fresh July 2026 validation against real MPC60 2.12 and MPC3000 `04 03` files confirms
    # that `total_number_of_bytes_in_all_sequences` includes the embedded
    # sequence terminator byte (`0xFF`). The sequence list therefore stops one
    # byte before that terminator.
    repeat-until: _io.pos - 6 >=
                  all_file_header.total_number_of_bytes_in_all_sequences - 1

  - id: sequences_terminator
    contents: [0xFF]

  - id: songs
    type: song
    repeat: until
    repeat-until: _.number_of_steps == 0x00

types:
  all_file_header:
    seq:
    - id: file_id
      contents: [0x04]
    
    - id: file_version
      # Wrapper/version byte `0x03` is currently understood as a shared
      # ALL family rather than a model-exclusive marker.
      contents: [0x03]
      
    - id: total_number_of_bytes_in_all_sequences
      type: u4le
      
  sequence:
    seq:
    - id: misc_chunks
      type: misc_chunks
    
    - id: events
      type: 'mpc3000_seq_v3::event(
        _index == 0,
        _index > 0 ? events[_index - 1].next_status : 0xFF, 
        misc_chunks.sequence_header.event_stream_length_in_bytes.value -
          (_io.pos - misc_chunks.position_after_tempo_changes))'
      
      repeat: until
      repeat-until: misc_chunks.sequence_header.event_stream_length_in_bytes.value -
          (_io.pos - misc_chunks.position_after_tempo_changes) == 0
      
  misc_chunks:
    seq:
    - id: sequence_header
      type: mpc3000_seq_v3::sequence_header
      
    - id: smpte_offset
      type: mpc3000_seq_v3::smpte_offset
    
    - id: mixer
      type: mpc3000_seq_v3::mixer
      repeat: expr
      repeat-expr: 64
      
    - id: reserved_after_mixer
      contents: [0x00, 0x00]
    
    - id: delays
      type: mpc3000_seq_v3::delays
      
    - id: reserved_after_delays
      contents: [0x00, 0x00, 0x00]
    
    - id: reserved_before_track_summary
      contents: [
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
      ]
    
    - id: last_active_track
      type: u1
      
    - id: num_tempo_changes
      type: u1
      
    - id: num_track_headers
      type: u1
    
    - id: track_headers
      type: mpc3000_seq_v3::track_header
      repeat: expr
      repeat-expr: num_track_headers
    
    - id: tempo_changes
      type: mpc3000_seq_v3::tempo_change
      repeat: expr
      repeat-expr: num_tempo_changes
    
    instances:
      position_after_tempo_changes:
        value: _io.pos
        
  song:
    seq:
    # 0x00 indicates the end of the ALL file.
    - id: number_of_steps
      type: u1
    
    - id: song_body
      type: song_body
      if: number_of_steps != 0x00
    
    types:
      song_body:
        seq:
        - id: song_number
          type: u1
        - id: end_status
          type: u1
          enum: end_status
        - id: loop_back_step_number
          type: u1
        - id: song_name
          type: str
          encoding: ASCII
          terminator: 0x20
          size: 16
        - id: smpte_offset
          type: mpc3000_seq_v3::smpte_offset
        - id: steps
          type: step
          repeat: expr
          repeat-expr: _parent.number_of_steps
        
        types:
          step:
            seq:
            - id: sequence_number
              type: u1
            - id: repetition_count
              type: u1
      
        enums:
          end_status:
            0: stop_at_end
            1: loop_to_a_step
