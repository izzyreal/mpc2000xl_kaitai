meta:
  id: mpc60_seq_v2
  file-extension: seq
  imports:
    - mpc60.seq.body

# Observed on freshly rechecked mpc60scsi firmware 2.14:
#   SEQ wrapper bytes are `03 02`
#
# Naming note:
# the `v2` here is the wrapper/version byte, not a claim that the body below is
# generic for all MPC60-family files. The broader `0x03` family currently
# appears to be shared with MPC3000 v3. See FORMAT_VERSION_NOTES.md.

seq:
- id: file_id
  contents: [0x03]

- id: file_format_version
  contents: [0x02]

- id: sequence
  type: mpc60_seq_body::sequence
