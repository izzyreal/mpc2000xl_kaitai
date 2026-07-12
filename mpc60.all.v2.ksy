meta:
  id: mpc60_all_v2
  file-extension: all
  imports:
    - mpc60.all.body

# Observed on freshly rechecked mpc60scsi firmware 2.14:
#   ALL wrapper bytes are `04 02`
#
# Naming note:
# the `v2` here is the wrapper/version byte, not a claim that the body below is
# generic for all MPC60-family files. The broader `0x03` family currently
# appears to be shared with MPC3000 v3. See FORMAT_VERSION_NOTES.md.

seq:
- id: file_id
  contents: [0x04]

- id: file_format_version
  contents: [0x02]

- id: body
  type: mpc60_all_body::all_file_body
