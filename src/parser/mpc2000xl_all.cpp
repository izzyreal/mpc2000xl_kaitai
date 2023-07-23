// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "mpc2000xl_all.h"
#include "kaitai/exceptions.h"

mpc2000xl_all_t::mpc2000xl_all_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = this;
    m_defaults = 0;
    m_sequencer = 0;
    m_count = 0;
    m_midi_input = 0;
    m_midi_sync = 0;
    m_misc = 0;
    m_step_edit_options = 0;
    m_sequences_metas = 0;
    m_songs = 0;
    m_sequences = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::_read() {
    m_magic = m__io->read_bytes(16);
    if (!(magic() == std::string("\x4D\x50\x43\x32\x4B\x58\x4C\x20\x41\x4C\x4C\x20\x31\x2E\x30\x30", 16))) {
        throw kaitai::validation_not_equal_error<std::string>(std::string("\x4D\x50\x43\x32\x4B\x58\x4C\x20\x41\x4C\x4C\x20\x31\x2E\x30\x30", 16), magic(), _io(), std::string("/seq/0"));
    }
    m_defaults = new defaults_t(m__io, this, m__root);
    m_sequencer = new sequencer_t(m__io, this, m__root);
    m__unnamed3 = m__io->read_bytes(10);
    m_count = new count_t(m__io, this, m__root);
    m_midi_input = new midi_input_t(m__io, this, m__root);
    m__unnamed6 = m__io->read_bytes(0);
    m_midi_sync = new midi_sync_t(m__io, this, m__root);
    m_default_song_name = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), std::string("ASCII").c_str());
    m__unnamed9 = m__io->read_bytes(42);
    m_misc = new misc_t(m__io, this, m__root);
    m__unnamed11 = m__io->read_bytes(3);
    m_step_edit_options = new step_edit_options_t(m__io, this, m__root);
    m_prog_change_to_seq = m__io->read_bits_int_le(1);
    m__io->align_to_byte();
    m__unnamed14 = m__io->read_bytes(78);
    m_sequences_metas = new std::vector<sequence_meta_t*>();
    const int l_sequences_metas = 99;
    for (int i = 0; i < l_sequences_metas; i++) {
        m_sequences_metas->push_back(new sequence_meta_t(m__io, this, m__root));
    }
    m_songs = new std::vector<song_t*>();
    const int l_songs = 20;
    for (int i = 0; i < l_songs; i++) {
        m_songs->push_back(new song_t(m__io, this, m__root));
    }
    m_sequences = new std::vector<sequence_t*>();
    {
        int i = 0;
        while (!m__io->is_eof()) {
            m_sequences->push_back(new sequence_t(m__io, this, m__root));
            i++;
        }
    }
}

mpc2000xl_all_t::~mpc2000xl_all_t() {
    _clean_up();
}

void mpc2000xl_all_t::_clean_up() {
    if (m_defaults) {
        delete m_defaults; m_defaults = 0;
    }
    if (m_sequencer) {
        delete m_sequencer; m_sequencer = 0;
    }
    if (m_count) {
        delete m_count; m_count = 0;
    }
    if (m_midi_input) {
        delete m_midi_input; m_midi_input = 0;
    }
    if (m_midi_sync) {
        delete m_midi_sync; m_midi_sync = 0;
    }
    if (m_misc) {
        delete m_misc; m_misc = 0;
    }
    if (m_step_edit_options) {
        delete m_step_edit_options; m_step_edit_options = 0;
    }
    if (m_sequences_metas) {
        for (std::vector<sequence_meta_t*>::iterator it = m_sequences_metas->begin(); it != m_sequences_metas->end(); ++it) {
            delete *it;
        }
        delete m_sequences_metas; m_sequences_metas = 0;
    }
    if (m_songs) {
        for (std::vector<song_t*>::iterator it = m_songs->begin(); it != m_songs->end(); ++it) {
            delete *it;
        }
        delete m_songs; m_songs = 0;
    }
    if (m_sequences) {
        for (std::vector<sequence_t*>::iterator it = m_sequences->begin(); it != m_sequences->end(); ++it) {
            delete *it;
        }
        delete m_sequences; m_sequences = 0;
    }
}

mpc2000xl_all_t::sequence_body_t::sequence_body_t(kaitai::kstream* p__io, mpc2000xl_all_t::sequence_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_device_names = 0;
    m_tracks = 0;
    m_bars = 0;
    m__unnamed15 = 0;
    m_events = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::sequence_body_t::_read() {
    m_is_used = static_cast<mpc2000xl_all_t::sequence_is_used_t>(m__io->read_u2le());
    m_index = m__io->read_u1();
    m__unnamed2 = m__io->read_bytes(7);
    m_bar_count = m__io->read_u2le();
    m_last_tick = m__io->read_u4le();
    m__unnamed5 = m__io->read_bytes(16);
    m_loop_start_bar_index = m__io->read_u2le();
    m_loop_end_bar_index = m__io->read_u2le();
    m__unnamed8 = m__io->read_bytes(12);
    m_last_tick2 = m__io->read_u4le();
    m__unnamed10 = m__io->read_bytes(52);
    m_device_names = new std::vector<std::string>();
    const int l_device_names = 33;
    for (int i = 0; i < l_device_names; i++) {
        m_device_names->push_back(kaitai::kstream::bytes_to_str(m__io->read_bytes(8), std::string("ASCII").c_str()));
    }
    m_tracks = new tracks_t(m__io, this, m__root);
    m__unnamed13 = m__io->read_bytes(3587);
    m_bars = new std::vector<bar_t*>();
    const int l_bars = bar_count();
    for (int i = 0; i < l_bars; i++) {
        m_bars->push_back(new bar_t(i, m__io, this, m__root));
    }
    m__unnamed15 = new std::vector<bar_t*>();
    const int l__unnamed15 = (999 - bar_count());
    for (int i = 0; i < l__unnamed15; i++) {
        m__unnamed15->push_back(new bar_t(i, m__io, this, m__root));
    }
    m__unnamed16 = m__io->read_bytes(865);
    m_events = new std::vector<event_t*>();
    {
        int i = 0;
        event_t* _;
        do {
            _ = new event_t(m__io, this, m__root);
            m_events->push_back(_);
            i++;
        } while (!(_->tick() == 1048575));
    }
}

mpc2000xl_all_t::sequence_body_t::~sequence_body_t() {
    _clean_up();
}

void mpc2000xl_all_t::sequence_body_t::_clean_up() {
    if (m_device_names) {
        delete m_device_names; m_device_names = 0;
    }
    if (m_tracks) {
        delete m_tracks; m_tracks = 0;
    }
    if (m_bars) {
        for (std::vector<bar_t*>::iterator it = m_bars->begin(); it != m_bars->end(); ++it) {
            delete *it;
        }
        delete m_bars; m_bars = 0;
    }
    if (m__unnamed15) {
        for (std::vector<bar_t*>::iterator it = m__unnamed15->begin(); it != m__unnamed15->end(); ++it) {
            delete *it;
        }
        delete m__unnamed15; m__unnamed15 = 0;
    }
    if (m_events) {
        for (std::vector<event_t*>::iterator it = m_events->begin(); it != m_events->end(); ++it) {
            delete *it;
        }
        delete m_events; m_events = 0;
    }
}

mpc2000xl_all_t::count_t::count_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::count_t::_read() {
    m_enabled = m__io->read_bits_int_le(1);
    m__unnamed1 = m__io->read_bits_int_le(7);
    m__io->align_to_byte();
    m_count_in_mode = static_cast<mpc2000xl_all_t::count_in_mode_t>(m__io->read_u1());
    m_click_volume = m__io->read_u1();
    if (!(click_volume() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, click_volume(), _io(), std::string("/types/count/seq/3"));
    }
    if (!(click_volume() <= 100)) {
        throw kaitai::validation_greater_than_error<uint8_t>(100, click_volume(), _io(), std::string("/types/count/seq/3"));
    }
    m_rate = static_cast<mpc2000xl_all_t::rate_t>(m__io->read_u1());
    m_enabled_in_play = m__io->read_bits_int_le(1);
    m__unnamed6 = m__io->read_bits_int_le(7);
    m_enabled_in_rec = m__io->read_bits_int_le(1);
    m__unnamed8 = m__io->read_bits_int_le(7);
    m__io->align_to_byte();
    m_click_output = static_cast<mpc2000xl_all_t::click_output_t>(m__io->read_u1());
    m_wait_for_key = m__io->read_bits_int_le(1);
    m__unnamed11 = m__io->read_bits_int_le(7);
    m__io->align_to_byte();
    m_sound_source = static_cast<mpc2000xl_all_t::sound_source_t>(m__io->read_u1());
    m_accent_pad_index = m__io->read_u1();
    m_normal_pad_index = m__io->read_u1();
    m_accent_velo = m__io->read_u1();
    if (!(accent_velo() >= 1)) {
        throw kaitai::validation_less_than_error<uint8_t>(1, accent_velo(), _io(), std::string("/types/count/seq/15"));
    }
    if (!(accent_velo() <= 127)) {
        throw kaitai::validation_greater_than_error<uint8_t>(127, accent_velo(), _io(), std::string("/types/count/seq/15"));
    }
    m_normal_velo = m__io->read_u1();
    if (!(normal_velo() >= 1)) {
        throw kaitai::validation_less_than_error<uint8_t>(1, normal_velo(), _io(), std::string("/types/count/seq/16"));
    }
    if (!(normal_velo() <= 127)) {
        throw kaitai::validation_greater_than_error<uint8_t>(127, normal_velo(), _io(), std::string("/types/count/seq/16"));
    }
}

mpc2000xl_all_t::count_t::~count_t() {
    _clean_up();
}

void mpc2000xl_all_t::count_t::_clean_up() {
}

mpc2000xl_all_t::pitch_bend_event_t::pitch_bend_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_corrected_amount = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::pitch_bend_event_t::_read() {
    m_amount_bits_1 = m__io->read_bits_int_le(8);
    m_amount_bits_2 = m__io->read_bits_int_le(8);
    m__io->align_to_byte();
    m__unnamed2 = m__io->read_bytes(1);
}

mpc2000xl_all_t::pitch_bend_event_t::~pitch_bend_event_t() {
    _clean_up();
}

void mpc2000xl_all_t::pitch_bend_event_t::_clean_up() {
}

int32_t mpc2000xl_all_t::pitch_bend_event_t::corrected_amount() {
    if (f_corrected_amount)
        return m_corrected_amount;
    m_corrected_amount = ((amount_bits_1() + (amount_bits_2() << 7)) - 8192);
    f_corrected_amount = true;
    return m_corrected_amount;
}

mpc2000xl_all_t::midi_input_t::midi_input_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_multi_rec_destination_tracks = 0;
    m_cc_pass_enabled = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::midi_input_t::_read() {
    m__unnamed0 = m__io->read_bytes(1);
    m_receive_channel = static_cast<mpc2000xl_all_t::midi_input_receive_channel_t>(m__io->read_u1());
    m_sustain_pedal_to_duration = m__io->read_bits_int_le(1);
    m__unnamed3 = m__io->read_bits_int_le(7);
    m_filter_enabled = m__io->read_bits_int_le(1);
    m__unnamed5 = m__io->read_bits_int_le(7);
    m__io->align_to_byte();
    m_filter_type = static_cast<mpc2000xl_all_t::midi_input_filter_type_t>(m__io->read_u1());
    m_multi_rec_enabled = m__io->read_bits_int_le(1);
    m__unnamed8 = m__io->read_bits_int_le(7);
    m__io->align_to_byte();
    m_multi_rec_destination_tracks = new std::vector<uint8_t>();
    const int l_multi_rec_destination_tracks = 34;
    for (int i = 0; i < l_multi_rec_destination_tracks; i++) {
        m_multi_rec_destination_tracks->push_back(m__io->read_u1());
    }
    m_note_pass_enabled = m__io->read_bits_int_le(1);
    m__unnamed11 = m__io->read_bits_int_le(7);
    m_pitch_bend_pass_enabled = m__io->read_bits_int_le(1);
    m__unnamed13 = m__io->read_bits_int_le(7);
    m_pgm_change_pass_enabled = m__io->read_bits_int_le(1);
    m__unnamed15 = m__io->read_bits_int_le(7);
    m_ch_pressure_pass_enabled = m__io->read_bits_int_le(1);
    m__unnamed17 = m__io->read_bits_int_le(7);
    m_poly_pressure_pass_enabled = m__io->read_bits_int_le(1);
    m__unnamed19 = m__io->read_bits_int_le(7);
    m_exclusive_pass_enabled = m__io->read_bits_int_le(1);
    m__unnamed21 = m__io->read_bits_int_le(7);
    m_cc_pass_enabled = new std::vector<bool>();
    const int l_cc_pass_enabled = 128;
    for (int i = 0; i < l_cc_pass_enabled; i++) {
        m_cc_pass_enabled->push_back(m__io->read_bits_int_le(1));
    }
}

mpc2000xl_all_t::midi_input_t::~midi_input_t() {
    _clean_up();
}

void mpc2000xl_all_t::midi_input_t::_clean_up() {
    if (m_multi_rec_destination_tracks) {
        delete m_multi_rec_destination_tracks; m_multi_rec_destination_tracks = 0;
    }
    if (m_cc_pass_enabled) {
        delete m_cc_pass_enabled; m_cc_pass_enabled = 0;
    }
}

mpc2000xl_all_t::program_change_event_t::program_change_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::program_change_event_t::_read() {
    m_program = m__io->read_u1();
    if (!(program() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, program(), _io(), std::string("/types/program_change_event/seq/0"));
    }
    if (!(program() <= 127)) {
        throw kaitai::validation_greater_than_error<uint8_t>(127, program(), _io(), std::string("/types/program_change_event/seq/0"));
    }
    m__unnamed1 = m__io->read_bytes(2);
}

mpc2000xl_all_t::program_change_event_t::~program_change_event_t() {
    _clean_up();
}

void mpc2000xl_all_t::program_change_event_t::_clean_up() {
}

mpc2000xl_all_t::defaults_t::defaults_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_unknown1 = 0;
    m_device_names = 0;
    m_track_names = 0;
    m_devices = 0;
    m_buses = 0;
    m_programs = 0;
    m_track_velocities = 0;
    m_track_statuses = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::defaults_t::_read() {
    m_sequence_name = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), std::string("ASCII").c_str());
    m__unnamed1 = m__io->read_bytes(6);
    m_tempo = m__io->read_u2le();
    m_numerator = m__io->read_u1();
    m_denominator = m__io->read_u1();
    m_bar_count = m__io->read_u2le();
    m_tick_count = m__io->read_u2le();
    m_unknown1 = new std::vector<uint32_t>();
    const int l_unknown1 = 4;
    for (int i = 0; i < l_unknown1; i++) {
        m_unknown1->push_back(m__io->read_u4le());
    }
    m_unknown2 = m__io->read_bytes(74);
    m_device_names = new std::vector<std::string>();
    const int l_device_names = 33;
    for (int i = 0; i < l_device_names; i++) {
        m_device_names->push_back(kaitai::kstream::bytes_to_str(m__io->read_bytes(8), std::string("ASCII").c_str()));
    }
    m_track_names = new std::vector<std::string>();
    const int l_track_names = 64;
    for (int i = 0; i < l_track_names; i++) {
        m_track_names->push_back(kaitai::kstream::bytes_to_str(m__io->read_bytes(16), std::string("ASCII").c_str()));
    }
    m_devices = new std::vector<uint8_t>();
    const int l_devices = 64;
    for (int i = 0; i < l_devices; i++) {
        m_devices->push_back(m__io->read_u1());
    }
    m_buses = new std::vector<bus_t>();
    const int l_buses = 64;
    for (int i = 0; i < l_buses; i++) {
        m_buses->push_back(static_cast<mpc2000xl_all_t::bus_t>(m__io->read_u1()));
    }
    m_programs = new std::vector<uint8_t>();
    const int l_programs = 64;
    for (int i = 0; i < l_programs; i++) {
        m_programs->push_back(m__io->read_u1());
    }
    m_track_velocities = new std::vector<uint8_t>();
    const int l_track_velocities = 64;
    for (int i = 0; i < l_track_velocities; i++) {
        m_track_velocities->push_back(m__io->read_u1());
    }
    m_track_statuses = new std::vector<track_status_t*>();
    const int l_track_statuses = 64;
    for (int i = 0; i < l_track_statuses; i++) {
        m_track_statuses->push_back(new track_status_t(m__io, this, m__root));
    }
    m__unnamed16 = m__io->read_bytes(64);
}

mpc2000xl_all_t::defaults_t::~defaults_t() {
    _clean_up();
}

void mpc2000xl_all_t::defaults_t::_clean_up() {
    if (m_unknown1) {
        delete m_unknown1; m_unknown1 = 0;
    }
    if (m_device_names) {
        delete m_device_names; m_device_names = 0;
    }
    if (m_track_names) {
        delete m_track_names; m_track_names = 0;
    }
    if (m_devices) {
        delete m_devices; m_devices = 0;
    }
    if (m_buses) {
        delete m_buses; m_buses = 0;
    }
    if (m_programs) {
        delete m_programs; m_programs = 0;
    }
    if (m_track_velocities) {
        delete m_track_velocities; m_track_velocities = 0;
    }
    if (m_track_statuses) {
        for (std::vector<track_status_t*>::iterator it = m_track_statuses->begin(); it != m_track_statuses->end(); ++it) {
            delete *it;
        }
        delete m_track_statuses; m_track_statuses = 0;
    }
}

mpc2000xl_all_t::song_t::song_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_steps = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::song_t::_read() {
    m_name = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), std::string("ASCII").c_str());
    m_steps = new std::vector<song_step_t*>();
    const int l_steps = 250;
    for (int i = 0; i < l_steps; i++) {
        m_steps->push_back(new song_step_t(m__io, this, m__root));
    }
    m__unnamed2 = m__io->read_bytes(2);
    m_is_used = m__io->read_bits_int_le(1);
    m__io->align_to_byte();
    m__unnamed4 = m__io->read_bytes(2);
    m_is_loop_enabled = m__io->read_bits_int_le(1);
    m__io->align_to_byte();
    m__unnamed6 = m__io->read_bytes(6);
}

mpc2000xl_all_t::song_t::~song_t() {
    _clean_up();
}

void mpc2000xl_all_t::song_t::_clean_up() {
    if (m_steps) {
        for (std::vector<song_step_t*>::iterator it = m_steps->begin(); it != m_steps->end(); ++it) {
            delete *it;
        }
        delete m_steps; m_steps = 0;
    }
}

mpc2000xl_all_t::event_t::event_t(kaitai::kstream* p__io, mpc2000xl_all_t::sequence_body_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_note_event = 0;
    m_pitch_bend = 0;
    m_control_change = 0;
    m_program_change = 0;
    m_ch_pressure = 0;
    m_poly_pressure = 0;
    m_exclusive = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::event_t::_read() {
    m_tick = m__io->read_bits_int_le(20);
    n_duration_bits_1 = true;
    if (tick() < 1048575) {
        n_duration_bits_1 = false;
        m_duration_bits_1 = m__io->read_bits_int_le(4);
    }
    n_track = true;
    if (tick() < 1048575) {
        n_track = false;
        m_track = m__io->read_bits_int_le(6);
    }
    n_duration_bits_2 = true;
    if (tick() < 1048575) {
        n_duration_bits_2 = false;
        m_duration_bits_2 = m__io->read_bits_int_le(2);
    }
    m__io->align_to_byte();
    n_id = true;
    if (tick() < 1048575) {
        n_id = false;
        m_id = m__io->read_u1();
    }
    n_note_event = true;
    if ( ((tick() < 1048575) && (id() <= 127)) ) {
        n_note_event = false;
        m_note_event = new note_event_t(m__io, this, m__root);
    }
    n_pitch_bend = true;
    if ( ((tick() < 1048575) && (id() == 224)) ) {
        n_pitch_bend = false;
        m_pitch_bend = new pitch_bend_event_t(m__io, this, m__root);
    }
    n_control_change = true;
    if ( ((tick() < 1048575) && (id() == 176)) ) {
        n_control_change = false;
        m_control_change = new control_change_event_t(m__io, this, m__root);
    }
    n_program_change = true;
    if ( ((tick() < 1048575) && (id() == 192)) ) {
        n_program_change = false;
        m_program_change = new program_change_event_t(m__io, this, m__root);
    }
    n_ch_pressure = true;
    if ( ((tick() < 1048575) && (id() == 208)) ) {
        n_ch_pressure = false;
        m_ch_pressure = new ch_pressure_event_t(m__io, this, m__root);
    }
    n_poly_pressure = true;
    if ( ((tick() < 1048575) && (id() == 160)) ) {
        n_poly_pressure = false;
        m_poly_pressure = new poly_pressure_event_t(m__io, this, m__root);
    }
    n_exclusive = true;
    if ( ((tick() < 1048575) && (id() == 240)) ) {
        n_exclusive = false;
        m_exclusive = new exclusive_event_t(m__io, this, m__root);
    }
    n_terminator = true;
    if (tick() >= 1048575) {
        n_terminator = false;
        m_terminator = m__io->read_bytes(5);
    }
}

mpc2000xl_all_t::event_t::~event_t() {
    _clean_up();
}

void mpc2000xl_all_t::event_t::_clean_up() {
    if (!n_duration_bits_1) {
    }
    if (!n_track) {
    }
    if (!n_duration_bits_2) {
    }
    if (!n_id) {
    }
    if (!n_note_event) {
        if (m_note_event) {
            delete m_note_event; m_note_event = 0;
        }
    }
    if (!n_pitch_bend) {
        if (m_pitch_bend) {
            delete m_pitch_bend; m_pitch_bend = 0;
        }
    }
    if (!n_control_change) {
        if (m_control_change) {
            delete m_control_change; m_control_change = 0;
        }
    }
    if (!n_program_change) {
        if (m_program_change) {
            delete m_program_change; m_program_change = 0;
        }
    }
    if (!n_ch_pressure) {
        if (m_ch_pressure) {
            delete m_ch_pressure; m_ch_pressure = 0;
        }
    }
    if (!n_poly_pressure) {
        if (m_poly_pressure) {
            delete m_poly_pressure; m_poly_pressure = 0;
        }
    }
    if (!n_exclusive) {
        if (m_exclusive) {
            delete m_exclusive; m_exclusive = 0;
        }
    }
    if (!n_terminator) {
    }
}

mpc2000xl_all_t::midi_switch_t::midi_switch_t(kaitai::kstream* p__io, mpc2000xl_all_t::misc_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::midi_switch_t::_read() {
    m_controller = m__io->read_u1();
    if (!(controller() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, controller(), _io(), std::string("/types/midi_switch/seq/0"));
    }
    if (!(controller() <= 127)) {
        throw kaitai::validation_greater_than_error<uint8_t>(127, controller(), _io(), std::string("/types/midi_switch/seq/0"));
    }
    m_function = static_cast<mpc2000xl_all_t::midi_switch_function_t>(m__io->read_u1());
}

mpc2000xl_all_t::midi_switch_t::~midi_switch_t() {
    _clean_up();
}

void mpc2000xl_all_t::midi_switch_t::_clean_up() {
}

mpc2000xl_all_t::midi_sync_t::midi_sync_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::midi_sync_t::_read() {
    m_in_mode = static_cast<mpc2000xl_all_t::midi_sync_mode_t>(m__io->read_u1());
    m_out_mode = static_cast<mpc2000xl_all_t::midi_sync_mode_t>(m__io->read_u1());
    m_shift_early = m__io->read_u1();
    if (!(shift_early() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, shift_early(), _io(), std::string("/types/midi_sync/seq/2"));
    }
    if (!(shift_early() <= 20)) {
        throw kaitai::validation_greater_than_error<uint8_t>(20, shift_early(), _io(), std::string("/types/midi_sync/seq/2"));
    }
    m_send_mmc_enabled = m__io->read_bits_int_le(1);
    m__unnamed4 = m__io->read_bits_int_le(7);
    m__io->align_to_byte();
    m_frame_rate = static_cast<mpc2000xl_all_t::frame_rate_t>(m__io->read_u1());
    m_input = m__io->read_u1();
    m_output = static_cast<mpc2000xl_all_t::midi_sync_output_t>(m__io->read_u1());
}

mpc2000xl_all_t::midi_sync_t::~midi_sync_t() {
    _clean_up();
}

void mpc2000xl_all_t::midi_sync_t::_clean_up() {
}

mpc2000xl_all_t::step_edit_options_t::step_edit_options_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::step_edit_options_t::_read() {
    m_auto_step_increment = m__io->read_bits_int_le(1);
    m__io->align_to_byte();
    m_duration_of_recorded_notes = static_cast<mpc2000xl_all_t::duration_of_recorded_notes_t>(m__io->read_u1());
    m_tc_value_percentage = m__io->read_u1();
    if (!(tc_value_percentage() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, tc_value_percentage(), _io(), std::string("/types/step_edit_options/seq/2"));
    }
    if (!(tc_value_percentage() <= 100)) {
        throw kaitai::validation_greater_than_error<uint8_t>(100, tc_value_percentage(), _io(), std::string("/types/step_edit_options/seq/2"));
    }
}

mpc2000xl_all_t::step_edit_options_t::~step_edit_options_t() {
    _clean_up();
}

void mpc2000xl_all_t::step_edit_options_t::_clean_up() {
}

mpc2000xl_all_t::tracks_t::tracks_t(kaitai::kstream* p__io, mpc2000xl_all_t::sequence_body_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_names = 0;
    m_device = 0;
    m_bus = 0;
    m_program_change = 0;
    m_velocity_ratio = 0;
    m_status = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::tracks_t::_read() {
    m_names = new std::vector<std::string>();
    const int l_names = 64;
    for (int i = 0; i < l_names; i++) {
        m_names->push_back(kaitai::kstream::bytes_to_str(m__io->read_bytes(16), std::string("ASCII").c_str()));
    }
    m_device = new std::vector<uint8_t>();
    const int l_device = 64;
    for (int i = 0; i < l_device; i++) {
        m_device->push_back(m__io->read_u1());
    }
    m_bus = new std::vector<bus_t>();
    const int l_bus = 64;
    for (int i = 0; i < l_bus; i++) {
        m_bus->push_back(static_cast<mpc2000xl_all_t::bus_t>(m__io->read_u1()));
    }
    m_program_change = new std::vector<uint8_t>();
    const int l_program_change = 64;
    for (int i = 0; i < l_program_change; i++) {
        m_program_change->push_back(m__io->read_u1());
    }
    m_velocity_ratio = new std::vector<uint8_t>();
    const int l_velocity_ratio = 64;
    for (int i = 0; i < l_velocity_ratio; i++) {
        m_velocity_ratio->push_back(m__io->read_u1());
    }
    m_status = new std::vector<track_status_t*>();
    const int l_status = 64;
    for (int i = 0; i < l_status; i++) {
        m_status->push_back(new track_status_t(m__io, this, m__root));
    }
    m_unknown = m__io->read_bytes(64);
}

mpc2000xl_all_t::tracks_t::~tracks_t() {
    _clean_up();
}

void mpc2000xl_all_t::tracks_t::_clean_up() {
    if (m_names) {
        delete m_names; m_names = 0;
    }
    if (m_device) {
        delete m_device; m_device = 0;
    }
    if (m_bus) {
        delete m_bus; m_bus = 0;
    }
    if (m_program_change) {
        delete m_program_change; m_program_change = 0;
    }
    if (m_velocity_ratio) {
        delete m_velocity_ratio; m_velocity_ratio = 0;
    }
    if (m_status) {
        for (std::vector<track_status_t*>::iterator it = m_status->begin(); it != m_status->end(); ++it) {
            delete *it;
        }
        delete m_status; m_status = 0;
    }
}

mpc2000xl_all_t::exclusive_event_t::exclusive_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_mixer = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::exclusive_event_t::_read() {
    m__unnamed0 = m__io->read_bytes(3);
    m_bytes = m__io->read_bytes(2);
    n_mixer = true;
    if (bytes() == std::string("\xF0\x47", 2)) {
        n_mixer = false;
        m_mixer = new mixer_event_t(m__io, this, m__root);
    }
    m__unnamed3 = m__io->read_bytes(14);
}

mpc2000xl_all_t::exclusive_event_t::~exclusive_event_t() {
    _clean_up();
}

void mpc2000xl_all_t::exclusive_event_t::_clean_up() {
    if (!n_mixer) {
        if (m_mixer) {
            delete m_mixer; m_mixer = 0;
        }
    }
}

mpc2000xl_all_t::sequence_meta_t::sequence_meta_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::sequence_meta_t::_read() {
    m_name = kaitai::kstream::bytes_to_str(m__io->read_bytes(16), std::string("ASCII").c_str());
    m_is_used = static_cast<mpc2000xl_all_t::sequence_is_used_t>(m__io->read_u2le());
}

mpc2000xl_all_t::sequence_meta_t::~sequence_meta_t() {
    _clean_up();
}

void mpc2000xl_all_t::sequence_meta_t::_clean_up() {
}

mpc2000xl_all_t::sequence_t::sequence_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_body = 0;
    f_name = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::sequence_t::_read() {
    m_name_part_1 = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(8), 255, false), std::string("ASCII").c_str());
    n_name_part_2 = true;
    if (name_part_1() != std::string("")) {
        n_name_part_2 = false;
        m_name_part_2 = kaitai::kstream::bytes_to_str(kaitai::kstream::bytes_terminate(m__io->read_bytes(8), 255, false), std::string("ASCII").c_str());
    }
    n_body = true;
    if (name_part_1() != std::string("")) {
        n_body = false;
        m_body = new sequence_body_t(m__io, this, m__root);
    }
}

mpc2000xl_all_t::sequence_t::~sequence_t() {
    _clean_up();
}

void mpc2000xl_all_t::sequence_t::_clean_up() {
    if (!n_name_part_2) {
    }
    if (!n_body) {
        if (m_body) {
            delete m_body; m_body = 0;
        }
    }
}

std::string mpc2000xl_all_t::sequence_t::name() {
    if (f_name)
        return m_name;
    n_name = true;
    if ( ((name_part_1() != std::string("")) && (name_part_2() != std::string(""))) ) {
        n_name = false;
        m_name = name_part_1() + name_part_2();
    }
    f_name = true;
    return m_name;
}

mpc2000xl_all_t::song_step_t::song_step_t(kaitai::kstream* p__io, mpc2000xl_all_t::song_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::song_step_t::_read() {
    m_sequence_index = m__io->read_u1();
    m_repeat_count = m__io->read_u1();
}

mpc2000xl_all_t::song_step_t::~song_step_t() {
    _clean_up();
}

void mpc2000xl_all_t::song_step_t::_clean_up() {
}

mpc2000xl_all_t::bar_t::bar_t(int32_t p_idx, kaitai::kstream* p__io, mpc2000xl_all_t::sequence_body_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_idx = p_idx;
    f_first_tick = false;
    f_numerator = false;
    f_denominator = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::bar_t::_read() {
    m_ticks_per_beat = m__io->read_u1();
    m_last_tick = m__io->read_bits_int_le(24);
}

mpc2000xl_all_t::bar_t::~bar_t() {
    _clean_up();
}

void mpc2000xl_all_t::bar_t::_clean_up() {
}

int32_t mpc2000xl_all_t::bar_t::first_tick() {
    if (f_first_tick)
        return m_first_tick;
    m_first_tick = ((idx() == 0) ? (0) : (_parent()->bars()->at((idx() - 1))->last_tick()));
    f_first_tick = true;
    return m_first_tick;
}

int32_t mpc2000xl_all_t::bar_t::numerator() {
    if (f_numerator)
        return m_numerator;
    m_numerator = ((last_tick() - first_tick()) / ticks_per_beat());
    f_numerator = true;
    return m_numerator;
}

int32_t mpc2000xl_all_t::bar_t::denominator() {
    if (f_denominator)
        return m_denominator;
    m_denominator = (4 / (ticks_per_beat() / 96));
    f_denominator = true;
    return m_denominator;
}

mpc2000xl_all_t::misc_t::misc_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    m_midi_switch = 0;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::misc_t::_read() {
    m_tap_averaging = static_cast<mpc2000xl_all_t::tap_averaging_t>(m__io->read_u1());
    m_midi_sync_in_receive_mmc_enabled = m__io->read_bits_int_le(1);
    m__io->align_to_byte();
    m_midi_switch = new std::vector<midi_switch_t*>();
    const int l_midi_switch = 4;
    for (int i = 0; i < l_midi_switch; i++) {
        m_midi_switch->push_back(new midi_switch_t(m__io, this, m__root));
    }
}

mpc2000xl_all_t::misc_t::~misc_t() {
    _clean_up();
}

void mpc2000xl_all_t::misc_t::_clean_up() {
    if (m_midi_switch) {
        for (std::vector<midi_switch_t*>::iterator it = m_midi_switch->begin(); it != m_midi_switch->end(); ++it) {
            delete *it;
        }
        delete m_midi_switch; m_midi_switch = 0;
    }
}

mpc2000xl_all_t::note_event_t::note_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;
    f_note = false;
    f_duration = false;
    f_variation_type = false;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::note_event_t::_read() {
    m_duration_bits_3 = m__io->read_u1();
    m_velocity = m__io->read_bits_int_le(7);
    m_variation_type_bit_1 = m__io->read_bits_int_le(1);
    m_variation_value = m__io->read_bits_int_le(7);
    m_variation_type_bit_2 = m__io->read_bits_int_le(1);
}

mpc2000xl_all_t::note_event_t::~note_event_t() {
    _clean_up();
}

void mpc2000xl_all_t::note_event_t::_clean_up() {
}

uint8_t mpc2000xl_all_t::note_event_t::note() {
    if (f_note)
        return m_note;
    m_note = _parent()->id();
    f_note = true;
    return m_note;
}

int32_t mpc2000xl_all_t::note_event_t::duration() {
    if (f_duration)
        return m_duration;
    m_duration = (((_parent()->duration_bits_1() << 10) + (_parent()->duration_bits_2() << 8)) + duration_bits_3());
    f_duration = true;
    return m_duration;
}

mpc2000xl_all_t::note_event_t::note_variation_type_t mpc2000xl_all_t::note_event_t::variation_type() {
    if (f_variation_type)
        return m_variation_type;
    m_variation_type = static_cast<mpc2000xl_all_t::note_event_t::note_variation_type_t>(((static_cast<uint8_t>(variation_type_bit_1()) << 1) | static_cast<uint8_t>(variation_type_bit_2())));
    f_variation_type = true;
    return m_variation_type;
}

mpc2000xl_all_t::control_change_event_t::control_change_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::control_change_event_t::_read() {
    m_controller = static_cast<mpc2000xl_all_t::controller_t>(m__io->read_u1());
    m_value = m__io->read_u1();
    if (!(value() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, value(), _io(), std::string("/types/control_change_event/seq/1"));
    }
    if (!(value() <= 127)) {
        throw kaitai::validation_greater_than_error<uint8_t>(127, value(), _io(), std::string("/types/control_change_event/seq/1"));
    }
    m__unnamed2 = m__io->read_bytes(1);
}

mpc2000xl_all_t::control_change_event_t::~control_change_event_t() {
    _clean_up();
}

void mpc2000xl_all_t::control_change_event_t::_clean_up() {
}

mpc2000xl_all_t::sequencer_t::sequencer_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::sequencer_t::_read() {
    m_active_sequence = m__io->read_u1();
    m__unnamed1 = m__io->read_bytes(1);
    m_active_track = m__io->read_u1();
    m__unnamed3 = m__io->read_bytes(4);
    m_timing_correct = static_cast<mpc2000xl_all_t::timing_correct_t>(m__io->read_u1());
    m__unnamed5 = m__io->read_bytes(1);
    m_second_sequence_enabled = m__io->read_bits_int_le(1);
    m__unnamed7 = m__io->read_bits_int_le(7);
    m__io->align_to_byte();
    m_sequence_sequence_index = m__io->read_u1();
}

mpc2000xl_all_t::sequencer_t::~sequencer_t() {
    _clean_up();
}

void mpc2000xl_all_t::sequencer_t::_clean_up() {
}

mpc2000xl_all_t::mixer_event_t::mixer_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::exclusive_event_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::mixer_event_t::_read() {
    m__unnamed0 = m__io->read_bytes(3);
    m_param = static_cast<mpc2000xl_all_t::mixer_event_param_t>(m__io->read_u1());
    m_pad_index = m__io->read_u1();
    m_value = m__io->read_u1();
    if (!(value() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, value(), _io(), std::string("/types/mixer_event/seq/3"));
    }
    if (!(value() <= 100)) {
        throw kaitai::validation_greater_than_error<uint8_t>(100, value(), _io(), std::string("/types/mixer_event/seq/3"));
    }
    m__unnamed4 = m__io->read_bytes(2);
}

mpc2000xl_all_t::mixer_event_t::~mixer_event_t() {
    _clean_up();
}

void mpc2000xl_all_t::mixer_event_t::_clean_up() {
}

mpc2000xl_all_t::track_status_t::track_status_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::track_status_t::_read() {
    m_unused_or_used = static_cast<mpc2000xl_all_t::unused_used_t>(m__io->read_bits_int_le(1));
    m_off_or_on = static_cast<mpc2000xl_all_t::off_on_t>(m__io->read_bits_int_le(1));
    m_transmit_program_changes = static_cast<mpc2000xl_all_t::off_on_t>(m__io->read_bits_int_le(1));
    m__unnamed3 = m__io->read_bits_int_le(5);
}

mpc2000xl_all_t::track_status_t::~track_status_t() {
    _clean_up();
}

void mpc2000xl_all_t::track_status_t::_clean_up() {
}

mpc2000xl_all_t::poly_pressure_event_t::poly_pressure_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::poly_pressure_event_t::_read() {
    m_note = m__io->read_u1();
    if (!(note() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, note(), _io(), std::string("/types/poly_pressure_event/seq/0"));
    }
    if (!(note() <= 127)) {
        throw kaitai::validation_greater_than_error<uint8_t>(127, note(), _io(), std::string("/types/poly_pressure_event/seq/0"));
    }
    m_pressure = m__io->read_u1();
    if (!(pressure() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, pressure(), _io(), std::string("/types/poly_pressure_event/seq/1"));
    }
    if (!(pressure() <= 127)) {
        throw kaitai::validation_greater_than_error<uint8_t>(127, pressure(), _io(), std::string("/types/poly_pressure_event/seq/1"));
    }
    m__unnamed2 = m__io->read_bytes(1);
}

mpc2000xl_all_t::poly_pressure_event_t::~poly_pressure_event_t() {
    _clean_up();
}

void mpc2000xl_all_t::poly_pressure_event_t::_clean_up() {
}

mpc2000xl_all_t::ch_pressure_event_t::ch_pressure_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent, mpc2000xl_all_t* p__root) : kaitai::kstruct(p__io) {
    m__parent = p__parent;
    m__root = p__root;

    try {
        _read();
    } catch(...) {
        _clean_up();
        throw;
    }
}

void mpc2000xl_all_t::ch_pressure_event_t::_read() {
    m_pressure = m__io->read_u1();
    if (!(pressure() >= 0)) {
        throw kaitai::validation_less_than_error<uint8_t>(0, pressure(), _io(), std::string("/types/ch_pressure_event/seq/0"));
    }
    if (!(pressure() <= 127)) {
        throw kaitai::validation_greater_than_error<uint8_t>(127, pressure(), _io(), std::string("/types/ch_pressure_event/seq/0"));
    }
    m__unnamed1 = m__io->read_bytes(2);
}

mpc2000xl_all_t::ch_pressure_event_t::~ch_pressure_event_t() {
    _clean_up();
}

void mpc2000xl_all_t::ch_pressure_event_t::_clean_up() {
}
