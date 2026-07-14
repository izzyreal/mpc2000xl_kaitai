meta:
  id: mpc3000_snd_v2
  title: MPC3000 SND File Format (Version 2)
  file-extension: SND
  endian: le
  bit-endian: le

doc: |
  Provisional parser for MPC3000 SND files whose first two bytes are 0x01 0x02.

  This definition is currently based on one hardware MPC3000 sample:
  SOUND017.SND, recorded as a two-second mono sample. That file is confirmed in
  the local hardware MPC3000 OS 3.11 corpus:

  /Users/izmar/projects/VMPC2000XL/reverse_engineer/mpc3000-os3.11/empty/SOUND017.SND

  The known-good interpretation for that file is a 38-byte header followed by
  signed 16-bit little-endian PCM at 44100 Hz.

  Known producers of this 0x01 0x02 family currently include:

  - hardware MPC3000 OS 3.11
  - MAME MPC3000 firmware 3.10

  A focused MAME MPC3000 3.10 save-session probe established the following:

  - `level` is the saved Vol% byte. Files saved with Vol% 50, 100, and 200
    encoded `0x32`, `0x64`, and `0xc8` respectively.
  - `unknown_2` is not a fixed constant and is not sample-rate metadata. Across
    a sequence of saves of the same 88200-frame sample, it increased by exactly
    `frame_count` each time: `0x000107d0`, `0x00026058`, `0x0003b8e0`,
    `0x00051168`, `0x000669f0`, `0x0007c278`. This strongly suggests a running
    allocator / sample-offset style value rather than an intrinsic property of
    the sample itself.
  - In that same save path, editing `Soft st` to `000.500.00` and `Soft end` to
    `002.500.00` did not change the persisted payload or the bytes currently
    mapped as `start`, `end`, and `frame_count`. So those fields remain
    provisional, and the save path appears to flatten or ignore those edit
    parameters.

  Field names other than file_id, file_version, name, level, and sample_data are
  still provisional.

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
    doc: Provisional. Observed as 0 in SOUND017.SND and unchanged in a MAME
         3.10 save-session probe even when `Soft st` was edited to
         `000.500.00`.

  - id: end
    type: u4
    doc: Provisional. Observed as 88200 in SOUND017.SND and unchanged in a MAME
         3.10 save-session probe even when `Soft end` was edited.

  - id: frame_count
    type: u4
    doc: Strongly supported. In SOUND017.SND this is 88200, and
         38 + frame_count * 2 equals the file size. It also matched the delta
         of `unknown_2` across repeated MAME 3.10 saves of the same sample.

  - id: unknown_2
    type: u4
    doc: Not yet fully classified. In a MAME MPC3000 3.10 probe, this value
         increased by exactly `frame_count` on each save of the same sample,
         which strongly suggests a running allocator / sample-offset style value
         rather than sample-rate metadata.

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
