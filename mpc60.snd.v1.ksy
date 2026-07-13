meta:
  id: mpc60_snd_v1
  title: MPC60 SND File Format (Version 1)
  file-extension: SND
  endian: le
  bit-endian: le

doc: |
  Parser for MPC60 SND files whose first two bytes are 0x01 0x01.

  This definition is based on hardware MPC60 SND files plus a native MAME MPC60
  2.14 ROCK.SET export corpus. The header layout and packed sample byte count
  are supported by all currently preserved native MPC60 SND files. The packed
  12-bit sample-code layout matches the MPC60 SET sample storage layout; the
  stateful conversion from those codes to imported 16-bit PCM is documented
  separately in MPC60_12BIT_SAMPLE_DECODER.md rather than expressed directly in
  this schema.

  Known evidence:
  - SOUND002.SND: 6039 bytes total, 4000 samples, 6000 sample bytes
  - SOUND003.SND: 120039 bytes total, 80000 samples, 120000 sample bytes
  - 17 native MAME MPC60 2.14 ROCK.SET exports preserved in codex-mame
  - all imply a 39-byte header and 12-bit packed sample storage
  - offsets 0x21..0x25 are zero in all 42 preserved MPC60 SND files checked

  The MPC60 v3.10 manual describes SND contents as sound name, sample data,
  tuning, volume, soft start, and soft end. Native 2.14 SET-to-SND exports also
  show that SET-only fields such as pitch factor, attack rate, mix/pan, output,
  echo, and sound characteristics are not copied into standalone SND headers.

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

  - id: time_from_start_of_data_to_start_play_msec
    type: u2
    doc: |
      Playback start time relative to the beginning of sample data, in
      milliseconds. This matches the same-named MPC60 SET sound-directory
      field for the native 2.14 ROCK.SET exports.

  - id: time_from_start_of_data_to_end_of_play_msec
    type: u4
    doc: |
      Playback end time relative to the beginning of sample data, in
      milliseconds. This matches the same-named MPC60 SET sound-directory
      field for the native 2.14 ROCK.SET exports.

      Some hardware-created files store the final millisecond index rather than
      the nominal duration: SOUND002.SND stores 99 for a 4000-sample / 100 ms
      sound, and SOUND003.SND stores 1999 for 80000 samples / 2000 ms.
      Native 2.14 SET exports observed so far store the nominal end time.

  - id: decay_time_msec
    type: u2
    doc: |
      Decay time in milliseconds. This matches the same-named MPC60 SET
      sound-directory field for the native 2.14 ROCK.SET exports.

  - id: volume_percent
    type: u1
    doc: |
      Sound volume percentage from Edit a Sound page 1. Confirmed on MAME
      MPC60 2.14 by changing only Volume% from 100 to 99 for SNARE#2 from
      ROCK.SET: the saved SND changed only byte offset 0x1f from 0x64 to 0x63
      and left packed sample data byte-identical.

  - id: tuning
    type: s1
    doc: |
      Sound tuning from Edit a Sound page 1. Confirmed on MAME MPC60 2.14 by
      changing only Tuning from 0 to 1 for SNARE#2 from ROCK.SET: the saved SND
      changed only byte offset 0x20 from 0x00 to 0x01 and left packed sample
      data byte-identical.

      JAUND017.SND, produced by loading an MPC3000 SND on hardware MPC60 and
      resaving it, stores 17 here. That is consistent with this field being
      sound tuning / import pitch adjustment, not part of a 16-bit volume value.

  - id: reserved_zeroes
    size: 5
    doc: |
      Observed as all zeroes in all current MPC60 SND evidence, including 42
      preserved hardware and MAME MPC60 SND files.

      These bytes do not correspond to the richer MPC60 SET sound-directory
      fields: native 2.14 ROCK.SET exports vary in pitch factor, attack rate,
      mix/pan, output, echo, and sound-characteristics values, while the
      corresponding SND exports keep this region zero.

  - id: velocity_to_volume_percent
    type: u1
    doc: |
      Velocity-to-volume percentage from Edit a Sound page 2,
      "Vel>vol(0-100)". Confirmed on MAME MPC60 2.14 by changing only
      Vel>vol from 100 to 99 for SNARE#2 from ROCK.SET: the saved SND changed
      only byte offset 0x26 from 0x64 to 0x63 and left packed sample data
      byte-identical.

  - id: sample_data_pairs
    type: sample_pair
    repeat: expr
    repeat-expr: packed_sample_pair_count
    doc: |
      Packed 12-bit sample code pairs. This is the same little-bit-endian
      two-words-in-three-bytes layout used by MPC60 SET sample data and
      documented in MPC60_12BIT_SAMPLE_DECODER.md.

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
      Current hardware/file evidence points to 40 kHz for this version-family.
      If later MPC60 SND evidence shows multiple rates, promote this into a real
      parsed field or a version split.
