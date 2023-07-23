meta:
  id: mpc2000snd
  file-extension: SND
seq:
  - id: magic
    contents: [0x01, 0x04]
  - id: name
    type: str
    size: 17
    encoding: ASCII
  - id: level
    type: u1
  - id: tune
    type: s1
  - id: stereo
    type: b1
  - id: start
    type: u4le
  - id: end
    type: u4le
  - id: frame_count
    type: u4le
  - id: loop_frame_count
    type: u4le
  - id: loop_enabled
    type: b1
  - id: beat_count
    type: u1
  - id: sample_rate
    type: u2le
  - id: frames
    type: s2le
    repeat: expr
    repeat-expr: frame_count