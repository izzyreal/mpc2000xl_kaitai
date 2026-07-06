meta:
  id: mpc60_snd_v1
  title: MPC60 SND File Format (Version 1)
  file-extension: SND
  endian: le
  bit-endian: le

doc: |
  Provisional parser for MPC60 SND files whose first two bytes are 0x01 0x01.

  This definition is based on two hardware MPC60 SND files:
  SOUND002.SND and SOUND003.SND. The header layout and packed sample byte count
  are supported by both files, but the sample-value decoding algorithm is still
  unresolved. For that reason, sample data is exposed as raw packed bytes.

  Known evidence:
  - SOUND002.SND: 6039 bytes total, 4000 samples, 6000 sample bytes
  - SOUND003.SND: 120039 bytes total, 80000 samples, 120000 sample bytes
  - both imply a 39-byte header and 12-bit packed sample storage

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
      Number of 12-bit mono sample words. Supported by file size:
      header_size + packed_sample_data_byte_count equals total file size for
      both known hardware MPC60 SND files.

  - id: unknown_1
    type: u2
    doc: Observed as 20 in SOUND002.SND and 0 in SOUND003.SND.

  - id: duration_milliseconds_minus_one
    type: u4
    doc: |
      Provisional. SOUND002.SND has 4000 samples at 40 kHz, i.e. 100 ms,
      and stores 99. SOUND003.SND has 80000 samples at 40 kHz, i.e. 2000 ms,
      and stores 1999.

  - id: unknown_2
    type: u2
    doc: Observed as 20 in both SOUND002.SND and SOUND003.SND.

  - id: unknown_3
    type: u2
    doc: |
      Observed as 100 in SOUND002.SND and SOUND003.SND, but 4452 in
      JAUND017.SND after loading an MPC3000 SND on MPC60 and resaving it.
      Therefore this is not simply the sound level.

  - id: unknown_4
    type: u4
    doc: Observed as 0 in both SOUND002.SND and SOUND003.SND.

  - id: unknown_5
    type: u1
    doc: Observed as 0 in both SOUND002.SND and SOUND003.SND.

  - id: level
    type: u1
    doc: |
      Provisional. Observed as 100 in SOUND002.SND, SOUND003.SND, and
      JAUND017.SND.

  - id: sample_data_pairs
    type: sample_pair
    repeat: expr
    repeat-expr: packed_sample_pair_count
    doc: |
      Packed 12-bit sample code pairs. The packing is supported by STIM002 /
      MAIM002: all 4096 plateau interiors are stable with this unpacking.

      These are sample codes, not final decoded audio amplitudes. The MPC60
      load path may normalize, and the value conversion/nonlinear representation
      is not fully resolved yet.

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
        value: byte0 | ((byte1 & 0xf0) << 4)
      sample1_code:
        value: byte2 | ((byte1 & 0x0f) << 8)

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
      Exposed as a provisional constant for the two current hardware probes.
      MPC60 sampling-rate behavior still needs further verification.
