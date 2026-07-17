meta:
  id: mpc3000_snd_v2
  title: MPC3000 SND File Format (Version 2)
  file-extension: SND
  endian: le
  bit-endian: le


# Known producers currently evidenced:
# - MPC3000 OS 3.11
# - MPC3000 OS 3.10

seq:
  - id: file_id
    contents: [0x01]

  - id: file_version
    contents: [0x02]

  - id: name
    type: str
    size: 17
    terminator: 0x00
    encoding: ASCII

  - id: level
    type: u1
    doc: Observed as 100 in SOUND017.SND.

  - id: tune
    type: s1
    doc: Sound tuning in 10-cent units.

  - id: stereo
    type: u1
    enum: stereo_flag

  - id: soft_start
    type: u4
    doc: Soft start as an address within the sample.

  - id: soft_end
    type: u4
    doc: Soft end as an address within the sample.

  - id: frame_count
    type: u4
    doc: Number of samples.

  - id: hard_start_address
    type: u4
    doc: |
      Hard start address within sound memory. Roger Linn's notes explicitly
      label this as useless in the file. Repeated saves of the same sample on
      MPC3000 OS 3.10 showed that this value increases by exactly
      `frame_count`, which matches an allocator / memory-address interpretation.

  - id: sample_data
    type: s2
    repeat: expr
    repeat-expr: frame_count

instances:
  header_size:
    value: 38
  sample_rate:
    value: 44100
    doc: Hardware MPC3000 SND probe SOUND017.SND has 88200 frames for a known
         two-second recording, implying 44100 Hz. This is exposed as a constant
         until sample-rate encoding is identified in the header.

enums:
  stereo_flag:
    0: mono
    1: stereo
