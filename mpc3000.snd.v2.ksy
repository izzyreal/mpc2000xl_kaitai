meta:
  id: mpc3000_snd_v2
  title: MPC3000 SND File Format (Version 2)
  file-extension: SND
  endian: le
  bit-endian: le

doc: |
  Parser for MPC3000 SND files whose first two bytes are 0x01 0x02.

  This definition is currently based on one MPC3000 sample:
  SOUND017.SND, recorded as a two-second mono sample. That file is confirmed in
  the local MPC3000 OS 3.11 corpus:

  /Users/izmar/projects/VMPC2000XL/reverse_engineer/mpc3000-os3.11/empty/SOUND017.SND

  The known-good interpretation for that file is a 38-byte header followed by
  signed 16-bit little-endian PCM at 44100 Hz.

  Known producers currently evidenced for this 0x01 0x02 family:

  - MPC3000 OS 3.11
  - MPC3000 OS 3.10

  A focused MPC3000 OS 3.10 save-session probe established the following:

  - `level` is the saved Vol% byte. Files saved with Vol% 50, 100, and 200
    encoded `0x32`, `0x64`, and `0xc8` respectively.
  - Roger Linn's file-format notes identify bytes 20-37 as:
    - tuning
    - stereo flag
    - soft start
    - soft end
    - number of samples
    - hard start address within sound memory
  - The hard-start address field is not a stable intrinsic property of the
    sample. Across repeated saves of the same 88200-frame sample, it increased
    by exactly `frame_count` each time: `0x000107d0`, `0x00026058`,
    `0x0003b8e0`, `0x00051168`, `0x000669f0`, `0x0007c278`.

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
    doc: Sound tuning in 10-cent units. Roger Linn's notes define the visible
         domain as -120..60.

  - id: stereo
    type: u1
    enum: stereo_flag
    doc: Stereo flag. Roger Linn's notes define 1 as stereo and 0 as mono.

  - id: soft_start
    type: u4
    doc: Soft start as an address within the sample.

  - id: soft_end
    type: u4
    doc: Soft end as an address within the sample.

  - id: frame_count
    type: u4
    doc: Number of samples. In SOUND017.SND this is 88200, and
         `38 + frame_count * 2` equals the file size.

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
