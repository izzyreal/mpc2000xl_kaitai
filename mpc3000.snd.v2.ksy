meta:
  id: mpc3000_snd_v2
  title: MPC3000 SND File Format (Version 2)
  file-extension: SND
  endian: le
  bit-endian: le

doc: |
  Provisional parser for MPC3000 SND files whose first two bytes are 0x01 0x02.

  This definition is currently based on one hardware MPC3000 sample:
  SOUND017.SND, recorded as a two-second mono sample. The known-good
  interpretation for that file is a 38-byte header followed by signed 16-bit
  little-endian PCM at 44100 Hz.

  Field names other than file_id, file_version, name, level, and sample_data are
  provisional. They are aligned to known byte offsets and observed values, but
  need more hardware-produced files to confirm semantics.

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

  - id: unknown_1
    size: 2
    doc: Observed as 0x0000 in SOUND017.SND.

  - id: start
    type: u4
    doc: Provisional. Observed as 0 in SOUND017.SND.

  - id: end
    type: u4
    doc: Provisional. Observed as 88200 in SOUND017.SND.

  - id: frame_count
    type: u4
    doc: Provisional but strongly supported. In SOUND017.SND this is 88200,
         and 38 + frame_count * 2 equals the file size.

  - id: unknown_2
    type: u4
    doc: Observed as 0x001b3690 in SOUND017.SND. This may encode sample rate or
         playback timing, but the exact meaning is not confirmed.

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
