meta:
  id: mpc3000_all_v3
  file-extension: all
  bit-endian: le
  imports:
    - mpc3000.seq.v3
    
seq:
  - id: file_id
    contents: [0x04]
  
  - id: file_version
    contents: [0x03]
    
  - id: total_number_of_bytes_in_all_sequences
    type: u4le
    
  - id: sequences
    type: sequence
    repeat: expr
    repeat-expr: 2

types:
  sequence:
    seq:
    - id: misc_chunks
      type: misc_chunks
    
    - id: events
      type: 'mpc3000_seq_v3::event(
        _index == 0,
        _index > 0 ? events[_index - 1].next_status : 0xFF, 
        misc_chunks.sequence_header.sequence_length_in_bytes.value -
          (_root._io.pos - misc_chunks.position_after_tempo_changes))'
      
      # This repeat should not be based on next status. It should be based on
      # total_number_of_bytes_in_all_sequences, so we can parse songs after
      # parsing the last event of the last sequence.
      repeat: until
      repeat-until: events[_index - 1].next_status == 0xFF or
                    events[_index - 1].next_status == 0x00      
      
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
      
    - size: 2
    
    - id: delays
      type: mpc3000_seq_v3::delays
      
    - size: 3
    
    - size: 16
    
    - id: last_active_track
      type: u1
      
    - id: number_of_tempo_changes
      type: u1
      
    - id: number_of_active_track_headers
      type: u1
    
    - id: track_headers
      type: mpc3000_seq_v3::track_header
      repeat: expr
      repeat-expr: number_of_active_track_headers
    
    - id: tempo_changes
      type: mpc3000_seq_v3::tempo_change
      repeat: expr
      repeat-expr: number_of_tempo_changes
    
    instances:
      position_after_tempo_changes:
        value: _io.pos