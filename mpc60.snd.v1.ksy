meta:
  id: mpc60_snd_v1
  title: MPC60 SND File Format (Version 1)
  file-extension: SND
  endian: le
  bit-endian: le

# Known producers evidenced from saved files:
# - MPC60 firmware 2.05
# - MPC60 firmware 2.12
# - MPC60 firmware 2.14

seq:
  - id: file_id
    contents: [0x01]

  - id: file_version
    contents: [0x01]

  - id: name
    type: str
    size: 17
    terminator: 0x00
    encoding: ASCII

  - id: sample_count
    type: u4
    doc: |
      Number of packed 12-bit mono sample codes.

  - id: time_from_start_of_data_to_start_play_msec
    type: u2
    doc: |
      Playback start time relative to sample data, in milliseconds.

  - id: time_from_start_of_data_to_end_of_play_msec
    type: u4
    doc: |
      Playback end time relative to sample data, in milliseconds. Some files
      store the final millisecond index rather than a duration.

  - id: decay_time_msec
    type: u2
    doc: |
      Decay time in milliseconds.

  - id: volume_percent
    type: u1
    doc: |
      Sound volume percentage.

  - id: tuning
    type: s1
    doc: |
      Sound tuning or import pitch adjustment.

  - id: reserved_zeroes
    size: 5
    doc: |
      Reserved bytes; supported files store zeroes here.

  - id: velocity_to_volume_percent
    type: u1
    doc: |
      Velocity-to-volume percentage.

  - id: sample_data_pairs
    type: sample_pair
    repeat: expr
    repeat-expr: packed_sample_pair_count
    doc: |
      Packed 12-bit sample code pairs. This is the same little-bit-endian
      two-words-in-three-bytes layout used by MPC60 SET sample data.

      These are sample codes, not final decoded audio amplitudes. The exact
      MPC2000XL import conversion is stateful consumer logic and is intentionally
      outside this structural schema.

types:
  sample_pair:
    seq:
      - id: byte0
        type: u1
      - id: byte1
        type: u1
      - id: byte2
        type: u1
    instances:
      sample0_code:
        value: byte0 | ((byte1 & 0x0f) << 8)
      sample1_code:
        value: (byte2 << 4) | ((byte1 & 0xf0) >> 4)

instances:
  header_size:
    value: 39
  packed_sample_pair_count:
    value: (sample_count + 1) / 2
  packed_sample_data_byte_count:
    value: packed_sample_pair_count * 3
    doc: |
      Two 12-bit sample words are packed into three bytes. The expression rounds
      odd sample counts up to the next pair, matching common 12-bit packing
      practice.
  sample_rate:
    value: 40000
    doc: |
      This file-format version uses a 40 kHz sample rate.
