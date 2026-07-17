meta:
  id: mpc60_all_v2
  file-extension: all
  imports:
    - mpc60.all.body

# Known producers currently evidenced:
# - MPC60 firmware 2.05
# - MPC60 firmware 2.12
# - MPC60 firmware 2.14

seq:
- id: file_id
  contents: [0x04]

- id: file_format_version
  contents: [0x02]

- id: body
  type: mpc60_all_body::all_file_body
