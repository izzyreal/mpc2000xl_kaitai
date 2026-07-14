meta:
  id: mpc60_seq_v3
  file-extension: seq
  imports:
    - mpc3000.seq.v3

# Earlier plain mpc60 2.12 probe artifacts point to:
#   SEQ wrapper bytes `03 03`
#
# Fresh July 2026 raw-image validation shows these files parse cleanly with the
# `mpc3000.seq.v3` body/layout once sliced to the real FAT file length.
# In other words, the `03 03` family is currently understood as a shared
# wrapper/body family, not as a separate "MPC60-only" sequence body.
#
# This file remains as a provenance-oriented alias so users can still say
# "parse the MPC60 2.12 SEQ" without having to know the shared-family naming.
# See FORMAT_VERSION_NOTES.md.

seq:
- id: body
  type: mpc3000_seq_v3

instances:
  file_id:
    value: body.file_id
  file_format_version:
    value: body.file_format_version
  sequence_header:
    value: body.sequence_header
  smpte_offset:
    value: body.smpte_offset
  mixer:
    value: body.mixer
  delays:
    value: body.delays
  last_active_track:
    value: body.last_active_track
  num_tempo_changes:
    value: body.num_tempo_changes
  num_track_headers:
    value: body.num_track_headers
  track_headers:
    value: body.track_headers
  tempo_changes:
    value: body.tempo_changes
  events:
    value: body.events
