meta:
  id: mpc2000xl_mid
  file-extension: mid
  bit-endian: le
  imports:
    - standard_midi_file_with_running_status
    
types:
  sequencer:
    seq:
      - contents: 'LOOP='
      - id: loop_enabled
        type: str
        encoding: ASCII
        size: 4
      - contents: 'START='
      - id: loop_start
        type: str
        encoding: ASCII
        size: 4
      - contents: 'END='
      - id: loop_end
        type: str
        encoding: ASCII
        size: 4
      - contents: 'TEMPO='
      - id: tempo_source
        type: str
        encoding: ASCII
        size: 3
        
instances:
  meta_events:
    value: tracks[0].events.event
  
  first_meta:
    value: meta_events[0].meta_event_body
  
  is_mpc2000xl_mid:
    value: tracks.size > 0 and meta_events.size > 0 and
           meta_events[0].event_type == 0xF0 and
           first_meta.len.value == 32 and
           first_meta.body.to_s("ASCII").substring(0, 16)
            == "MPC2000XL 1.00  "
            
  sequence_name:
    value: first_meta.body.to_s("ASCII").substring(16, 32)

  sequencer:
    io: tracks[0].events._io
    pos: 40
    type: sequencer
  
  tempo_bpm:
    value: 60000000.0 /
           ((meta_events[2].meta_event_body.body[0] << 16) +
           (meta_events[2].meta_event_body.body[1] << 8) +
           meta_events[2].meta_event_body.body[2])
  
  smpte_offset:
    value: meta_events[3].meta_event_body.body
  
  numerator:
    value: meta_events[4].meta_event_body.body[0]
    
  denominator:
    value: 1 << meta_events[4].meta_event_body.body[1]
  
seq:
  - id: hdr
    type: standard_midi_file_with_running_status::header
  - id: tracks
    type: standard_midi_file_with_running_status::track
    repeat: expr
    repeat-expr: hdr.num_tracks
    
