meta:
  id: mpc60_all_body
  imports:
    - mpc60.seq.body

# Known producers currently evidenced:
# - MPC60 firmware 2.05
# - MPC60 firmware 2.12
# - MPC60 firmware 2.14
#
# Important container rule confirmed against both sentinel-only and song-bearing
# real files:
# `total_number_of_bytes_in_all_sequences` includes the embedded sequence
# terminator byte (`0xFF`). The wrapper then continues with song records.

types:
  all_file_body:
    seq:
    - id: total_number_of_bytes_in_all_sequences
      type: u4le
    - id: sequences
      type: mpc60_seq_body::sequence
      repeat: until
      # The stored byte count includes the final embedded `0xFF` sequence
      # terminator, so the sequence list stops one byte before that terminator.
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
