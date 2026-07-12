meta:
  id: mpc60_all_body
  imports:
    - mpc60.seq.body

# This body models the smaller `04 02` family observed on `mpc60scsi` 2.14.
# It is not a generic body for every MPC60-family ALL wrapper:
# fresh July 2026 validation showed that plain MPC60 2.12 `04 03` files instead
# line up with the existing `mpc3000.all.v3` layout.

# Fresh July 2026 validation against real `MPC60_v214_ALL_SEQS.ALL` indicates
# that the embedded sequence body here shares the same reduced-MPC3000-style
# primitives as `mpc60_seq_body`.

types:
  all_file_body:
    seq:
    - id: total_number_of_bytes_in_all_sequences
      type: u4le
    - id: sequences
      type: mpc60_seq_body::sequence
      repeat: until
      repeat-until: _io.pos - 6 >= total_number_of_bytes_in_all_sequences - 1
    - id: sequences_terminator
      contents: [0xFF]
    - id: songs
      type: song
      repeat: until
      repeat-until: _.step_count == 0

  song_step:
    seq:
      - id: sequence_number
        type: u1
      - id: repeats
        type: u1

  song:
    seq:
      - id: step_count
        type: u1
      - id: body
        type:
          switch-on: step_count
          cases:
            '0': empty_song
            _: song_body

  empty_song:
    seq: []

  # Observed on MPC60 SCSI v2.14:
  #   song records are followed by a single trailing 0x00 byte.
  # We model that final byte as a sentinel song entry with step_count == 0.
  song_body:
    seq:
      - id: song_number
        type: u1
      - id: reserved_1
        contents: [0x00]
      - id: reserved_2
        contents: [0x01]
      - id: song_name
        type: str
        encoding: ASCII
        size: 16
      - id: reserved_3
        contents: [0x00, 0x00, 0x00, 0x00, 0x00]
      - id: steps
        type: song_step
        repeat: expr
        repeat-expr: _parent.step_count
