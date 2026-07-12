meta:
  id: mpc60_all_v3
  file-extension: all
  imports:
    - mpc3000.all.v3

# Earlier plain mpc60 2.12 probe artifacts point to:
#   ALL wrapper bytes `04 03`
#
# Fresh July 2026 raw-image validation shows these files parse cleanly with the
# `mpc3000.all.v3` body/layout once sliced to the real FAT file length.
# In other words, the `04 03` family is currently understood as a shared
# wrapper/body family, not as a separate "MPC60-only" ALL body.
#
# This file remains as a provenance-oriented alias so users can still say
# "parse the MPC60 2.12 ALL" without having to know the shared-family naming.
# See FORMAT_VERSION_NOTES.md.

seq:
- id: body
  type: mpc3000_all_v3

instances:
  all_file_header:
    value: body.all_file_header
  sequences:
    value: body.sequences
  songs:
    value: body.songs
