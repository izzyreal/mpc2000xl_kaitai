#ifndef MPC2000XL_ALL_H_
#define MPC2000XL_ALL_H_

// This is a generated file! Please edit source .ksy file and use kaitai-struct-compiler to rebuild

#include "kaitai/kaitaistruct.h"
#include <stdint.h>
#include <vector>

#if KAITAI_STRUCT_VERSION < 9000L
#error "Incompatible Kaitai Struct C++/STL API: version 0.9 or later is required"
#endif

class mpc2000xl_all_t : public kaitai::kstruct {

public:
    class sequence_body_t;
    class count_t;
    class pitch_bend_event_t;
    class midi_input_t;
    class program_change_event_t;
    class defaults_t;
    class song_t;
    class event_t;
    class midi_switch_t;
    class midi_sync_t;
    class step_edit_options_t;
    class tracks_t;
    class exclusive_event_t;
    class sequence_meta_t;
    class sequence_t;
    class song_step_t;
    class bar_t;
    class misc_t;
    class note_event_t;
    class control_change_event_t;
    class sequencer_t;
    class mixer_event_t;
    class track_status_t;
    class poly_pressure_event_t;
    class ch_pressure_event_t;

    enum rate_t {
        RATE_ONE_4 = 0,
        RATE_ONE_4_3 = 1,
        RATE_ONE_8 = 2,
        RATE_ONE_8_3 = 3,
        RATE_ONE_16 = 4,
        RATE_ONE_16_3 = 5,
        RATE_ONE_32 = 6,
        RATE_ONE_32_3 = 7
    };

    enum bus_t {
        BUS_MIDI = 0,
        BUS_DRUM1 = 1,
        BUS_DRUM2 = 2,
        BUS_DRUM3 = 3,
        BUS_DRUM4 = 4
    };

    enum click_output_t {
        CLICK_OUTPUT_STEREO = 0,
        CLICK_OUTPUT_INDIV1 = 1,
        CLICK_OUTPUT_INDIV2 = 2,
        CLICK_OUTPUT_INDIV3 = 3,
        CLICK_OUTPUT_INDIV4 = 4,
        CLICK_OUTPUT_INDIV5 = 5,
        CLICK_OUTPUT_INDIV6 = 6,
        CLICK_OUTPUT_INDIV7 = 7,
        CLICK_OUTPUT_INDIV8 = 8
    };

    enum frame_rate_t {
        FRAME_RATE_FPS_24 = 0,
        FRAME_RATE_FPS_25 = 1,
        FRAME_RATE_FPS_30D = 2,
        FRAME_RATE_FPS_30 = 3
    };

    enum midi_switch_function_t {
        MIDI_SWITCH_FUNCTION_PLAY_STRT = 0,
        MIDI_SWITCH_FUNCTION_PLAY = 1,
        MIDI_SWITCH_FUNCTION_STOP = 2,
        MIDI_SWITCH_FUNCTION_REC_AND_PLAY = 3,
        MIDI_SWITCH_FUNCTION_ODUB_AND_PLAY = 4,
        MIDI_SWITCH_FUNCTION_REC_PUNCH = 5,
        MIDI_SWITCH_FUNCTION_ODUB_PNCH = 6,
        MIDI_SWITCH_FUNCTION_TAP = 7,
        MIDI_SWITCH_FUNCTION_PAD_BNK_A = 8,
        MIDI_SWITCH_FUNCTION_PAD_BNK_B = 9,
        MIDI_SWITCH_FUNCTION_PAD_BNK_C = 10,
        MIDI_SWITCH_FUNCTION_PAD_BNK_D = 11,
        MIDI_SWITCH_FUNCTION_PAD_1 = 12,
        MIDI_SWITCH_FUNCTION_PAD_2 = 13,
        MIDI_SWITCH_FUNCTION_PAD_3 = 14,
        MIDI_SWITCH_FUNCTION_PAD_4 = 15,
        MIDI_SWITCH_FUNCTION_PAD_5 = 16,
        MIDI_SWITCH_FUNCTION_PAD_6 = 17,
        MIDI_SWITCH_FUNCTION_PAD_7 = 18,
        MIDI_SWITCH_FUNCTION_PAD_8 = 19,
        MIDI_SWITCH_FUNCTION_PAD_9 = 20,
        MIDI_SWITCH_FUNCTION_PAD_10 = 21,
        MIDI_SWITCH_FUNCTION_PAD_11 = 22,
        MIDI_SWITCH_FUNCTION_PAD_12 = 23,
        MIDI_SWITCH_FUNCTION_PAD_13 = 24,
        MIDI_SWITCH_FUNCTION_PAD_14 = 25,
        MIDI_SWITCH_FUNCTION_PAD_15 = 26,
        MIDI_SWITCH_FUNCTION_PAD_16 = 27,
        MIDI_SWITCH_FUNCTION_F1 = 28,
        MIDI_SWITCH_FUNCTION_F2 = 29,
        MIDI_SWITCH_FUNCTION_F3 = 30,
        MIDI_SWITCH_FUNCTION_F4 = 31,
        MIDI_SWITCH_FUNCTION_F5 = 32,
        MIDI_SWITCH_FUNCTION_F6 = 33
    };

    enum mixer_event_param_t {
        MIXER_EVENT_PARAM_STEREO_LEVEL = 1,
        MIXER_EVENT_PARAM_STEREO_PAN = 2,
        MIXER_EVENT_PARAM_FXSEND_LEVEL = 3,
        MIXER_EVENT_PARAM_INDIV_LEVEL = 5
    };

    enum midi_input_filter_type_t {
        MIDI_INPUT_FILTER_TYPE_NOTES = 0,
        MIDI_INPUT_FILTER_TYPE_PITCH_BEND = 1,
        MIDI_INPUT_FILTER_TYPE_PROG_CHANGE = 2,
        MIDI_INPUT_FILTER_TYPE_CH_PRESSURE = 3,
        MIDI_INPUT_FILTER_TYPE_POLY_PRESS = 4,
        MIDI_INPUT_FILTER_TYPE_EXCLUSIVE = 5,
        MIDI_INPUT_FILTER_TYPE_CC0_BANK_SEL_MSB = 6,
        MIDI_INPUT_FILTER_TYPE_CC1_MOD_WHEEL = 7,
        MIDI_INPUT_FILTER_TYPE_CC2_BREATH_CONT = 8,
        MIDI_INPUT_FILTER_TYPE_CC3 = 9,
        MIDI_INPUT_FILTER_TYPE_CC4_FOOT_CONTROL = 10,
        MIDI_INPUT_FILTER_TYPE_CC5_PORTA_TIME = 11,
        MIDI_INPUT_FILTER_TYPE_CC6_DATA_ENTRY = 12,
        MIDI_INPUT_FILTER_TYPE_CC7_MAIN_VOLUME = 13,
        MIDI_INPUT_FILTER_TYPE_CC8_BALANCE = 14,
        MIDI_INPUT_FILTER_TYPE_CC9 = 15,
        MIDI_INPUT_FILTER_TYPE_CC10_PAN = 16,
        MIDI_INPUT_FILTER_TYPE_CC11_EXPRESSION = 17,
        MIDI_INPUT_FILTER_TYPE_CC12_EFFECT_1 = 18,
        MIDI_INPUT_FILTER_TYPE_CC13_EFFECT_2 = 19,
        MIDI_INPUT_FILTER_TYPE_CC14 = 20,
        MIDI_INPUT_FILTER_TYPE_CC15 = 21,
        MIDI_INPUT_FILTER_TYPE_CC16_GEN_PUR_1 = 22,
        MIDI_INPUT_FILTER_TYPE_CC17_GEN_PUR_2 = 23,
        MIDI_INPUT_FILTER_TYPE_CC18_GEN_PUR_3 = 24,
        MIDI_INPUT_FILTER_TYPE_CC19_GEN_PUR_4 = 25,
        MIDI_INPUT_FILTER_TYPE_CC20 = 26,
        MIDI_INPUT_FILTER_TYPE_CC21 = 27,
        MIDI_INPUT_FILTER_TYPE_CC22 = 28,
        MIDI_INPUT_FILTER_TYPE_CC23 = 29,
        MIDI_INPUT_FILTER_TYPE_CC24 = 30,
        MIDI_INPUT_FILTER_TYPE_CC25 = 31,
        MIDI_INPUT_FILTER_TYPE_CC26 = 32,
        MIDI_INPUT_FILTER_TYPE_CC27 = 33,
        MIDI_INPUT_FILTER_TYPE_CC28 = 34,
        MIDI_INPUT_FILTER_TYPE_CC29 = 35,
        MIDI_INPUT_FILTER_TYPE_CC30 = 36,
        MIDI_INPUT_FILTER_TYPE_CC31 = 37,
        MIDI_INPUT_FILTER_TYPE_CC32_BANK_SEL_LSB = 38,
        MIDI_INPUT_FILTER_TYPE_CC33_MOD_WHEL_LSB = 39,
        MIDI_INPUT_FILTER_TYPE_CC34_BREATH_LSB = 40,
        MIDI_INPUT_FILTER_TYPE_CC35 = 41,
        MIDI_INPUT_FILTER_TYPE_CC36_FOOT_CNT_LSB = 42,
        MIDI_INPUT_FILTER_TYPE_CC37_PORT_TIME_LS = 43,
        MIDI_INPUT_FILTER_TYPE_CC38_DATA_ENT_LSB = 44,
        MIDI_INPUT_FILTER_TYPE_CC39_MAIN_VOL_LSB = 45,
        MIDI_INPUT_FILTER_TYPE_CC40_BALANCE_LSB = 46,
        MIDI_INPUT_FILTER_TYPE_CC41 = 47,
        MIDI_INPUT_FILTER_TYPE_CC42_PAN_LSB = 48,
        MIDI_INPUT_FILTER_TYPE_CC43_EXPRESS_LSB = 49,
        MIDI_INPUT_FILTER_TYPE_CC44_EFFECT_1_LSB = 50,
        MIDI_INPUT_FILTER_TYPE_CC45_EFFECT_2_MSB = 51,
        MIDI_INPUT_FILTER_TYPE_CC46 = 52,
        MIDI_INPUT_FILTER_TYPE_CC47 = 53,
        MIDI_INPUT_FILTER_TYPE_CC48_GEN_PUR_1_LS = 54,
        MIDI_INPUT_FILTER_TYPE_CC49_GEN_PUR_2_LS = 55,
        MIDI_INPUT_FILTER_TYPE_CC50_GEN_PUR_3_LS = 56,
        MIDI_INPUT_FILTER_TYPE_CC51_GEN_PUR_4_LS = 57,
        MIDI_INPUT_FILTER_TYPE_CC52 = 58,
        MIDI_INPUT_FILTER_TYPE_CC53 = 59,
        MIDI_INPUT_FILTER_TYPE_CC54 = 60,
        MIDI_INPUT_FILTER_TYPE_CC55 = 61,
        MIDI_INPUT_FILTER_TYPE_CC56 = 62,
        MIDI_INPUT_FILTER_TYPE_CC57 = 63,
        MIDI_INPUT_FILTER_TYPE_CC58 = 64,
        MIDI_INPUT_FILTER_TYPE_CC59 = 65,
        MIDI_INPUT_FILTER_TYPE_CC60 = 66,
        MIDI_INPUT_FILTER_TYPE_CC61 = 67,
        MIDI_INPUT_FILTER_TYPE_CC62 = 68,
        MIDI_INPUT_FILTER_TYPE_CC63 = 69,
        MIDI_INPUT_FILTER_TYPE_CC64_SUSTAIN_PDL = 70,
        MIDI_INPUT_FILTER_TYPE_CC65_PORTA_PEDAL = 71,
        MIDI_INPUT_FILTER_TYPE_CC66_SOSTENUTO = 72,
        MIDI_INPUT_FILTER_TYPE_CC67_SOFT_PEDAL = 73,
        MIDI_INPUT_FILTER_TYPE_CC68_LEGATO_FT_SW = 74,
        MIDI_INPUT_FILTER_TYPE_CC69_HOLD_2 = 75,
        MIDI_INPUT_FILTER_TYPE_CC70_SOUND_VARI = 76,
        MIDI_INPUT_FILTER_TYPE_CC71_TIMBER_HARMO = 77,
        MIDI_INPUT_FILTER_TYPE_CC72_RELEASE_TIME = 78,
        MIDI_INPUT_FILTER_TYPE_CC73_ATTACK_TIME = 79,
        MIDI_INPUT_FILTER_TYPE_CC74_BRIGHTNESS = 80,
        MIDI_INPUT_FILTER_TYPE_CC75_SOUND_CONT_6 = 81,
        MIDI_INPUT_FILTER_TYPE_CC76_SOUND_CONT_7 = 82,
        MIDI_INPUT_FILTER_TYPE_CC77_SOUND_CONT_8 = 83,
        MIDI_INPUT_FILTER_TYPE_CC78_SOUND_CONT_9 = 84,
        MIDI_INPUT_FILTER_TYPE_CC79_SOUND_CONT10 = 85,
        MIDI_INPUT_FILTER_TYPE_CC80_GEN_PUR_5 = 86,
        MIDI_INPUT_FILTER_TYPE_CC81_GEN_PUR_6 = 87,
        MIDI_INPUT_FILTER_TYPE_CC82_GEN_PUR_7 = 88,
        MIDI_INPUT_FILTER_TYPE_CC83_GEN_PUR_8 = 89,
        MIDI_INPUT_FILTER_TYPE_CC84_PORTA_CNTRL = 90,
        MIDI_INPUT_FILTER_TYPE_CC85 = 91,
        MIDI_INPUT_FILTER_TYPE_CC86 = 92,
        MIDI_INPUT_FILTER_TYPE_CC87 = 93,
        MIDI_INPUT_FILTER_TYPE_CC88 = 94,
        MIDI_INPUT_FILTER_TYPE_CC89 = 95,
        MIDI_INPUT_FILTER_TYPE_CC90 = 96,
        MIDI_INPUT_FILTER_TYPE_CC91_EXT_EFF_DPTH = 97,
        MIDI_INPUT_FILTER_TYPE_CC92_TREMOLO_DPTH = 98,
        MIDI_INPUT_FILTER_TYPE_CC93_CHORUS_DEPTH = 99,
        MIDI_INPUT_FILTER_TYPE_CC94_DETUNE_DEPTH = 100,
        MIDI_INPUT_FILTER_TYPE_CC95_PHASER_DEPTH = 101,
        MIDI_INPUT_FILTER_TYPE_CC96_DATA_INCRE = 102,
        MIDI_INPUT_FILTER_TYPE_CC97_DATA_DECRE = 103,
        MIDI_INPUT_FILTER_TYPE_CC98_NRPN_LSB = 104,
        MIDI_INPUT_FILTER_TYPE_CC99_NRPN_MSB = 105,
        MIDI_INPUT_FILTER_TYPE_CC100_RPN_LSB = 106,
        MIDI_INPUT_FILTER_TYPE_CC101_RPN_MSB = 107,
        MIDI_INPUT_FILTER_TYPE_CC102 = 108,
        MIDI_INPUT_FILTER_TYPE_CC103 = 109,
        MIDI_INPUT_FILTER_TYPE_CC104 = 110,
        MIDI_INPUT_FILTER_TYPE_CC105 = 111,
        MIDI_INPUT_FILTER_TYPE_CC106 = 112,
        MIDI_INPUT_FILTER_TYPE_CC107 = 113,
        MIDI_INPUT_FILTER_TYPE_CC108 = 114,
        MIDI_INPUT_FILTER_TYPE_CC109 = 115,
        MIDI_INPUT_FILTER_TYPE_CC110 = 116,
        MIDI_INPUT_FILTER_TYPE_CC111 = 117,
        MIDI_INPUT_FILTER_TYPE_CC112 = 118,
        MIDI_INPUT_FILTER_TYPE_CC113 = 119,
        MIDI_INPUT_FILTER_TYPE_CC114 = 120,
        MIDI_INPUT_FILTER_TYPE_CC115 = 121,
        MIDI_INPUT_FILTER_TYPE_CC116 = 122,
        MIDI_INPUT_FILTER_TYPE_CC117 = 123,
        MIDI_INPUT_FILTER_TYPE_CC118 = 124,
        MIDI_INPUT_FILTER_TYPE_CC119 = 125,
        MIDI_INPUT_FILTER_TYPE_CC120_ALL_SND_OFF = 126,
        MIDI_INPUT_FILTER_TYPE_CC121_RESET_CONTRL = 127,
        MIDI_INPUT_FILTER_TYPE_CC122_LOCAL_ON_OFF = 128,
        MIDI_INPUT_FILTER_TYPE_CC123_ALL_NOTE_OFF = 129,
        MIDI_INPUT_FILTER_TYPE_CC124_OMNI_OFF = 130,
        MIDI_INPUT_FILTER_TYPE_CC125_OMNI_ON = 131,
        MIDI_INPUT_FILTER_TYPE_CC126_MONO_MODE_ON = 132,
        MIDI_INPUT_FILTER_TYPE_CC127_POLY_MODE_ON = 133
    };

    enum tap_averaging_t {
        TAP_AVERAGING_TAP_AVG_2 = 0,
        TAP_AVERAGING_TAP_AVG_3 = 1,
        TAP_AVERAGING_TAP_AVG_4 = 2
    };

    enum midi_sync_output_t {
        MIDI_SYNC_OUTPUT_A = 0,
        MIDI_SYNC_OUTPUT_B = 1,
        MIDI_SYNC_OUTPUT_A_AND_B = 2
    };

    enum sound_source_t {
        SOUND_SOURCE_CLICK = 0,
        SOUND_SOURCE_DRUM1 = 1,
        SOUND_SOURCE_DRUM2 = 2,
        SOUND_SOURCE_DRUM3 = 3,
        SOUND_SOURCE_DRUM4 = 4
    };

    enum duration_of_recorded_notes_t {
        DURATION_OF_RECORDED_NOTES_AS_PLAYED = 0,
        DURATION_OF_RECORDED_NOTES_TC_VALUE = 1
    };

    enum sequence_is_used_t {
        SEQUENCE_IS_USED_NO = 0,
        SEQUENCE_IS_USED_YES = 641
    };

    enum midi_input_receive_channel_t {
        MIDI_INPUT_RECEIVE_CHANNEL_ALL = 0,
        MIDI_INPUT_RECEIVE_CHANNEL_CH1 = 1,
        MIDI_INPUT_RECEIVE_CHANNEL_CH2 = 2,
        MIDI_INPUT_RECEIVE_CHANNEL_CH3 = 3,
        MIDI_INPUT_RECEIVE_CHANNEL_CH4 = 4,
        MIDI_INPUT_RECEIVE_CHANNEL_CH5 = 5,
        MIDI_INPUT_RECEIVE_CHANNEL_CH6 = 6,
        MIDI_INPUT_RECEIVE_CHANNEL_CH7 = 7,
        MIDI_INPUT_RECEIVE_CHANNEL_CH8 = 8,
        MIDI_INPUT_RECEIVE_CHANNEL_CH9 = 9,
        MIDI_INPUT_RECEIVE_CHANNEL_CH10 = 10,
        MIDI_INPUT_RECEIVE_CHANNEL_CH11 = 11,
        MIDI_INPUT_RECEIVE_CHANNEL_CH12 = 12,
        MIDI_INPUT_RECEIVE_CHANNEL_CH13 = 13,
        MIDI_INPUT_RECEIVE_CHANNEL_CH14 = 14,
        MIDI_INPUT_RECEIVE_CHANNEL_CH15 = 15,
        MIDI_INPUT_RECEIVE_CHANNEL_CH16 = 16
    };

    enum unused_used_t {
        UNUSED_USED_UNUSED = 0,
        UNUSED_USED_USED = 1
    };

    enum off_on_t {
        OFF_ON_OFF = 0,
        OFF_ON_ON = 1
    };

    enum midi_sync_mode_t {
        MIDI_SYNC_MODE_OFF = 0,
        MIDI_SYNC_MODE_MIDI_CLOCK = 1,
        MIDI_SYNC_MODE_TIME_CODE = 2
    };

    enum controller_t {
        CONTROLLER_BANK_SEL_MSB = 0,
        CONTROLLER_MOD_WHEEL = 1,
        CONTROLLER_BREATH_CONT = 2,
        CONTROLLER_CC3 = 3,
        CONTROLLER_FOOT_CONTROL = 4,
        CONTROLLER_PORTA_TIME = 5,
        CONTROLLER_DATA_ENTRY = 6,
        CONTROLLER_MAIN_VOLUME = 7,
        CONTROLLER_BALANCE = 8,
        CONTROLLER_CC9 = 9,
        CONTROLLER_PAN = 10,
        CONTROLLER_EXPRESSION = 11,
        CONTROLLER_EFFECT_1 = 12,
        CONTROLLER_EFFECT_2 = 13,
        CONTROLLER_CC14 = 14,
        CONTROLLER_CC15 = 15,
        CONTROLLER_GEN_PUR_1 = 16,
        CONTROLLER_GEN_PUR_2 = 17,
        CONTROLLER_GEN_PUR_3 = 18,
        CONTROLLER_GEN_PUR_4 = 19,
        CONTROLLER_CC20 = 20,
        CONTROLLER_CC21 = 21,
        CONTROLLER_CC22 = 22,
        CONTROLLER_CC23 = 23,
        CONTROLLER_CC24 = 24,
        CONTROLLER_CC25 = 25,
        CONTROLLER_CC26 = 26,
        CONTROLLER_CC27 = 27,
        CONTROLLER_CC28 = 28,
        CONTROLLER_CC29 = 29,
        CONTROLLER_CC30 = 30,
        CONTROLLER_CC31 = 31,
        CONTROLLER_BANK_SEL_LSB = 32,
        CONTROLLER_MOD_WHEL_LSB = 33,
        CONTROLLER_BREATH_LSB = 34,
        CONTROLLER_CC35 = 35,
        CONTROLLER_FOOT_CNT_LSB = 36,
        CONTROLLER_PORT_TIME_LS = 37,
        CONTROLLER_DATA_ENT_LSB = 38,
        CONTROLLER_MAIN_VOL_LSB = 39,
        CONTROLLER_BALANCE_LSB = 40,
        CONTROLLER_CC41 = 41,
        CONTROLLER_PAN_LSB = 42,
        CONTROLLER_EXPRESS_LSB = 43,
        CONTROLLER_EFFECT_1_LSB = 44,
        CONTROLLER_EFFECT_2_MSB = 45,
        CONTROLLER_CC46 = 46,
        CONTROLLER_CC47 = 47,
        CONTROLLER_GEN_PUR_1_LS = 48,
        CONTROLLER_GEN_PUR_2_LS = 49,
        CONTROLLER_GEN_PUR_3_LS = 50,
        CONTROLLER_GEN_PUR_4_LS = 51,
        CONTROLLER_CC52 = 52,
        CONTROLLER_CC53 = 53,
        CONTROLLER_CC54 = 54,
        CONTROLLER_CC55 = 55,
        CONTROLLER_CC56 = 56,
        CONTROLLER_CC57 = 57,
        CONTROLLER_CC58 = 58,
        CONTROLLER_CC59 = 59,
        CONTROLLER_CC60 = 60,
        CONTROLLER_CC61 = 61,
        CONTROLLER_CC62 = 62,
        CONTROLLER_CC63 = 63,
        CONTROLLER_SUSTAIN_PDL = 64,
        CONTROLLER_PORTA_PEDAL = 65,
        CONTROLLER_SOSTENUTO = 66,
        CONTROLLER_SOFT_PEDAL = 67,
        CONTROLLER_LEGATO_FT_SW = 68,
        CONTROLLER_HOLD_2 = 69,
        CONTROLLER_SOUND_VARI = 70,
        CONTROLLER_TIMBER_HARMO = 71,
        CONTROLLER_RELEASE_TIME = 72,
        CONTROLLER_ATTACK_TIME = 73,
        CONTROLLER_BRIGHTNESS = 74,
        CONTROLLER_SOUND_CONT_6 = 75,
        CONTROLLER_SOUND_CONT_7 = 76,
        CONTROLLER_SOUND_CONT_8 = 77,
        CONTROLLER_SOUND_CONT_9 = 78,
        CONTROLLER_SOUND_CONT10 = 79,
        CONTROLLER_GEN_PUR_5 = 80,
        CONTROLLER_GEN_PUR_6 = 81,
        CONTROLLER_GEN_PUR_7 = 82,
        CONTROLLER_GEN_PUR_8 = 83,
        CONTROLLER_PORTA_CNTRL = 84,
        CONTROLLER_CC85 = 85,
        CONTROLLER_CC86 = 86,
        CONTROLLER_CC87 = 87,
        CONTROLLER_CC88 = 88,
        CONTROLLER_CC89 = 89,
        CONTROLLER_CC90 = 90,
        CONTROLLER_EXT_EFF_DPTH = 91,
        CONTROLLER_TREMOLO_DPTH = 92,
        CONTROLLER_CHORUS_DEPTH = 93,
        CONTROLLER_DETUNE_DEPTH = 94,
        CONTROLLER_PHASER_DEPTH = 95,
        CONTROLLER_DATA_INCRE = 96,
        CONTROLLER_DATA_DECRE = 97,
        CONTROLLER_NRPN_LSB = 98,
        CONTROLLER_NRPN_MSB = 99,
        CONTROLLER_RPN_LSB = 100,
        CONTROLLER_RPN_MSB = 101,
        CONTROLLER_CC102 = 102,
        CONTROLLER_CC103 = 103,
        CONTROLLER_CC104 = 104,
        CONTROLLER_CC105 = 105,
        CONTROLLER_CC106 = 106,
        CONTROLLER_CC107 = 107,
        CONTROLLER_CC108 = 108,
        CONTROLLER_CC109 = 109,
        CONTROLLER_CC110 = 110,
        CONTROLLER_CC111 = 111,
        CONTROLLER_CC112 = 112,
        CONTROLLER_CC113 = 113,
        CONTROLLER_CC114 = 114,
        CONTROLLER_CC115 = 115,
        CONTROLLER_CC116 = 116,
        CONTROLLER_CC117 = 117,
        CONTROLLER_CC118 = 118,
        CONTROLLER_CC119 = 119,
        CONTROLLER_ALL_SND_OFF = 120,
        CONTROLLER_RESET_CONTRL = 121,
        CONTROLLER_LOCAL_ON_OFF = 122,
        CONTROLLER_ALL_NOTE_OFF = 123,
        CONTROLLER_OMNI_OFF = 124,
        CONTROLLER_OMNI_ON = 125,
        CONTROLLER_MONO_MODE_ON = 126,
        CONTROLLER_POLY_MODE_ON = 127
    };

    enum count_in_mode_t {
        COUNT_IN_MODE_OFF = 0,
        COUNT_IN_MODE_REC_ONLY = 1,
        COUNT_IN_MODE_REC_AND_PLAY = 2
    };

    enum timing_correct_t {
        TIMING_CORRECT_OFF = 0,
        TIMING_CORRECT_ONE_8 = 1,
        TIMING_CORRECT_ONE_8_3 = 2,
        TIMING_CORRECT_ONE_16 = 3,
        TIMING_CORRECT_ONE_16_3 = 4,
        TIMING_CORRECT_ONE_32 = 5,
        TIMING_CORRECT_ONE_32_3 = 6
    };

    mpc2000xl_all_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mpc2000xl_all_t* p__root = 0);

private:
    void _read();
    void _clean_up();

public:
    ~mpc2000xl_all_t();

    class sequence_body_t : public kaitai::kstruct {

    public:

        sequence_body_t(kaitai::kstream* p__io, mpc2000xl_all_t::sequence_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~sequence_body_t();

    private:
        sequence_is_used_t m_is_used;
        uint8_t m_index;
        std::string m__unnamed2;
        uint16_t m_bar_count;
        uint32_t m_last_tick;
        std::string m__unnamed5;
        uint16_t m_loop_start_bar_index;
        uint16_t m_loop_end_bar_index;
        std::string m__unnamed8;
        uint32_t m_last_tick2;
        std::string m__unnamed10;
        std::vector<std::string>* m_device_names;
        tracks_t* m_tracks;
        std::string m__unnamed13;
        std::vector<bar_t*>* m_bars;
        std::vector<bar_t*>* m__unnamed15;
        std::string m__unnamed16;
        std::vector<event_t*>* m_events;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::sequence_t* m__parent;

    public:
        sequence_is_used_t is_used() const { return m_is_used; }

        /**
         * Warning! 1-based. You'll need this to put the sequence in the right slot
         */
        uint8_t index() const { return m_index; }
        std::string _unnamed2() const { return m__unnamed2; }
        uint16_t bar_count() const { return m_bar_count; }
        uint32_t last_tick() const { return m_last_tick; }
        std::string _unnamed5() const { return m__unnamed5; }
        uint16_t loop_start_bar_index() const { return m_loop_start_bar_index; }
        uint16_t loop_end_bar_index() const { return m_loop_end_bar_index; }
        std::string _unnamed8() const { return m__unnamed8; }
        uint32_t last_tick2() const { return m_last_tick2; }
        std::string _unnamed10() const { return m__unnamed10; }
        std::vector<std::string>* device_names() const { return m_device_names; }
        tracks_t* tracks() const { return m_tracks; }
        std::string _unnamed13() const { return m__unnamed13; }
        std::vector<bar_t*>* bars() const { return m_bars; }
        std::vector<bar_t*>* _unnamed15() const { return m__unnamed15; }
        std::string _unnamed16() const { return m__unnamed16; }
        std::vector<event_t*>* events() const { return m_events; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::sequence_t* _parent() const { return m__parent; }
    };

    class count_t : public kaitai::kstruct {

    public:

        count_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~count_t();

    private:
        bool m_enabled;
        uint64_t m__unnamed1;
        count_in_mode_t m_count_in_mode;
        uint8_t m_click_volume;
        rate_t m_rate;
        bool m_enabled_in_play;
        uint64_t m__unnamed6;
        bool m_enabled_in_rec;
        uint64_t m__unnamed8;
        click_output_t m_click_output;
        bool m_wait_for_key;
        uint64_t m__unnamed11;
        sound_source_t m_sound_source;
        uint8_t m_accent_pad_index;
        uint8_t m_normal_pad_index;
        uint8_t m_accent_velo;
        uint8_t m_normal_velo;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        bool enabled() const { return m_enabled; }
        uint64_t _unnamed1() const { return m__unnamed1; }
        count_in_mode_t count_in_mode() const { return m_count_in_mode; }
        uint8_t click_volume() const { return m_click_volume; }
        rate_t rate() const { return m_rate; }
        bool enabled_in_play() const { return m_enabled_in_play; }
        uint64_t _unnamed6() const { return m__unnamed6; }
        bool enabled_in_rec() const { return m_enabled_in_rec; }
        uint64_t _unnamed8() const { return m__unnamed8; }
        click_output_t click_output() const { return m_click_output; }
        bool wait_for_key() const { return m_wait_for_key; }
        uint64_t _unnamed11() const { return m__unnamed11; }
        sound_source_t sound_source() const { return m_sound_source; }
        uint8_t accent_pad_index() const { return m_accent_pad_index; }
        uint8_t normal_pad_index() const { return m_normal_pad_index; }
        uint8_t accent_velo() const { return m_accent_velo; }
        uint8_t normal_velo() const { return m_normal_velo; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class pitch_bend_event_t : public kaitai::kstruct {

    public:

        pitch_bend_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~pitch_bend_event_t();

    private:
        bool f_corrected_amount;
        int32_t m_corrected_amount;

    public:
        int32_t corrected_amount();

    private:
        uint64_t m_amount_bits_1;
        uint64_t m_amount_bits_2;
        std::string m__unnamed2;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::event_t* m__parent;

    public:
        uint64_t amount_bits_1() const { return m_amount_bits_1; }
        uint64_t amount_bits_2() const { return m_amount_bits_2; }
        std::string _unnamed2() const { return m__unnamed2; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::event_t* _parent() const { return m__parent; }
    };

    class midi_input_t : public kaitai::kstruct {

    public:

        midi_input_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~midi_input_t();

    private:
        std::string m__unnamed0;
        midi_input_receive_channel_t m_receive_channel;
        bool m_sustain_pedal_to_duration;
        uint64_t m__unnamed3;
        bool m_filter_enabled;
        uint64_t m__unnamed5;
        midi_input_filter_type_t m_filter_type;
        bool m_multi_rec_enabled;
        uint64_t m__unnamed8;
        std::vector<uint8_t>* m_multi_rec_destination_tracks;
        bool m_note_pass_enabled;
        uint64_t m__unnamed11;
        bool m_pitch_bend_pass_enabled;
        uint64_t m__unnamed13;
        bool m_pgm_change_pass_enabled;
        uint64_t m__unnamed15;
        bool m_ch_pressure_pass_enabled;
        uint64_t m__unnamed17;
        bool m_poly_pressure_pass_enabled;
        uint64_t m__unnamed19;
        bool m_exclusive_pass_enabled;
        uint64_t m__unnamed21;
        std::vector<bool>* m_cc_pass_enabled;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        std::string _unnamed0() const { return m__unnamed0; }
        midi_input_receive_channel_t receive_channel() const { return m_receive_channel; }
        bool sustain_pedal_to_duration() const { return m_sustain_pedal_to_duration; }
        uint64_t _unnamed3() const { return m__unnamed3; }
        bool filter_enabled() const { return m_filter_enabled; }
        uint64_t _unnamed5() const { return m__unnamed5; }
        midi_input_filter_type_t filter_type() const { return m_filter_type; }
        bool multi_rec_enabled() const { return m_multi_rec_enabled; }
        uint64_t _unnamed8() const { return m__unnamed8; }
        std::vector<uint8_t>* multi_rec_destination_tracks() const { return m_multi_rec_destination_tracks; }
        bool note_pass_enabled() const { return m_note_pass_enabled; }
        uint64_t _unnamed11() const { return m__unnamed11; }
        bool pitch_bend_pass_enabled() const { return m_pitch_bend_pass_enabled; }
        uint64_t _unnamed13() const { return m__unnamed13; }
        bool pgm_change_pass_enabled() const { return m_pgm_change_pass_enabled; }
        uint64_t _unnamed15() const { return m__unnamed15; }
        bool ch_pressure_pass_enabled() const { return m_ch_pressure_pass_enabled; }
        uint64_t _unnamed17() const { return m__unnamed17; }
        bool poly_pressure_pass_enabled() const { return m_poly_pressure_pass_enabled; }
        uint64_t _unnamed19() const { return m__unnamed19; }
        bool exclusive_pass_enabled() const { return m_exclusive_pass_enabled; }
        uint64_t _unnamed21() const { return m__unnamed21; }
        std::vector<bool>* cc_pass_enabled() const { return m_cc_pass_enabled; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class program_change_event_t : public kaitai::kstruct {

    public:

        program_change_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~program_change_event_t();

    private:
        uint8_t m_program;
        std::string m__unnamed1;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::event_t* m__parent;

    public:
        uint8_t program() const { return m_program; }
        std::string _unnamed1() const { return m__unnamed1; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::event_t* _parent() const { return m__parent; }
    };

    class defaults_t : public kaitai::kstruct {

    public:

        defaults_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~defaults_t();

    private:
        std::string m_sequence_name;
        std::string m__unnamed1;
        uint16_t m_tempo;
        uint8_t m_numerator;
        uint8_t m_denominator;
        uint16_t m_bar_count;
        uint16_t m_tick_count;
        std::vector<uint32_t>* m_unknown1;
        std::string m_unknown2;
        std::vector<std::string>* m_device_names;
        std::vector<std::string>* m_track_names;
        std::vector<uint8_t>* m_devices;
        std::vector<bus_t>* m_buses;
        std::vector<uint8_t>* m_programs;
        std::vector<uint8_t>* m_track_velocities;
        std::vector<track_status_t*>* m_track_statuses;
        std::string m__unnamed16;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        std::string sequence_name() const { return m_sequence_name; }
        std::string _unnamed1() const { return m__unnamed1; }
        uint16_t tempo() const { return m_tempo; }
        uint8_t numerator() const { return m_numerator; }
        uint8_t denominator() const { return m_denominator; }
        uint16_t bar_count() const { return m_bar_count; }
        uint16_t tick_count() const { return m_tick_count; }
        std::vector<uint32_t>* unknown1() const { return m_unknown1; }
        std::string unknown2() const { return m_unknown2; }
        std::vector<std::string>* device_names() const { return m_device_names; }
        std::vector<std::string>* track_names() const { return m_track_names; }
        std::vector<uint8_t>* devices() const { return m_devices; }
        std::vector<bus_t>* buses() const { return m_buses; }
        std::vector<uint8_t>* programs() const { return m_programs; }
        std::vector<uint8_t>* track_velocities() const { return m_track_velocities; }
        std::vector<track_status_t*>* track_statuses() const { return m_track_statuses; }
        std::string _unnamed16() const { return m__unnamed16; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class song_t : public kaitai::kstruct {

    public:

        song_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~song_t();

    private:
        std::string m_name;
        std::vector<song_step_t*>* m_steps;
        std::string m__unnamed2;
        bool m_is_used;
        std::string m__unnamed4;
        bool m_is_loop_enabled;
        std::string m__unnamed6;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        std::string name() const { return m_name; }
        std::vector<song_step_t*>* steps() const { return m_steps; }
        std::string _unnamed2() const { return m__unnamed2; }
        bool is_used() const { return m_is_used; }
        std::string _unnamed4() const { return m__unnamed4; }
        bool is_loop_enabled() const { return m_is_loop_enabled; }
        std::string _unnamed6() const { return m__unnamed6; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class event_t : public kaitai::kstruct {

    public:

        event_t(kaitai::kstream* p__io, mpc2000xl_all_t::sequence_body_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~event_t();

    private:
        uint64_t m_tick;
        uint64_t m_duration_bits_1;
        bool n_duration_bits_1;

    public:
        bool _is_null_duration_bits_1() { duration_bits_1(); return n_duration_bits_1; };

    private:
        uint64_t m_track;
        bool n_track;

    public:
        bool _is_null_track() { track(); return n_track; };

    private:
        uint64_t m_duration_bits_2;
        bool n_duration_bits_2;

    public:
        bool _is_null_duration_bits_2() { duration_bits_2(); return n_duration_bits_2; };

    private:
        uint8_t m_id;
        bool n_id;

    public:
        bool _is_null_id() { id(); return n_id; };

    private:
        note_event_t* m_note_event;
        bool n_note_event;

    public:
        bool _is_null_note_event() { note_event(); return n_note_event; };

    private:
        pitch_bend_event_t* m_pitch_bend;
        bool n_pitch_bend;

    public:
        bool _is_null_pitch_bend() { pitch_bend(); return n_pitch_bend; };

    private:
        control_change_event_t* m_control_change;
        bool n_control_change;

    public:
        bool _is_null_control_change() { control_change(); return n_control_change; };

    private:
        program_change_event_t* m_program_change;
        bool n_program_change;

    public:
        bool _is_null_program_change() { program_change(); return n_program_change; };

    private:
        ch_pressure_event_t* m_ch_pressure;
        bool n_ch_pressure;

    public:
        bool _is_null_ch_pressure() { ch_pressure(); return n_ch_pressure; };

    private:
        poly_pressure_event_t* m_poly_pressure;
        bool n_poly_pressure;

    public:
        bool _is_null_poly_pressure() { poly_pressure(); return n_poly_pressure; };

    private:
        exclusive_event_t* m_exclusive;
        bool n_exclusive;

    public:
        bool _is_null_exclusive() { exclusive(); return n_exclusive; };

    private:
        std::string m_terminator;
        bool n_terminator;

    public:
        bool _is_null_terminator() { terminator(); return n_terminator; };

    private:
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::sequence_body_t* m__parent;

    public:
        uint64_t tick() const { return m_tick; }
        uint64_t duration_bits_1() const { return m_duration_bits_1; }
        uint64_t track() const { return m_track; }
        uint64_t duration_bits_2() const { return m_duration_bits_2; }
        uint8_t id() const { return m_id; }
        note_event_t* note_event() const { return m_note_event; }
        pitch_bend_event_t* pitch_bend() const { return m_pitch_bend; }
        control_change_event_t* control_change() const { return m_control_change; }
        program_change_event_t* program_change() const { return m_program_change; }
        ch_pressure_event_t* ch_pressure() const { return m_ch_pressure; }
        poly_pressure_event_t* poly_pressure() const { return m_poly_pressure; }
        exclusive_event_t* exclusive() const { return m_exclusive; }
        std::string terminator() const { return m_terminator; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::sequence_body_t* _parent() const { return m__parent; }
    };

    class midi_switch_t : public kaitai::kstruct {

    public:

        midi_switch_t(kaitai::kstream* p__io, mpc2000xl_all_t::misc_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~midi_switch_t();

    private:
        uint8_t m_controller;
        midi_switch_function_t m_function;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::misc_t* m__parent;

    public:
        uint8_t controller() const { return m_controller; }
        midi_switch_function_t function() const { return m_function; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::misc_t* _parent() const { return m__parent; }
    };

    class midi_sync_t : public kaitai::kstruct {

    public:

        midi_sync_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~midi_sync_t();

    private:
        midi_sync_mode_t m_in_mode;
        midi_sync_mode_t m_out_mode;
        uint8_t m_shift_early;
        bool m_send_mmc_enabled;
        uint64_t m__unnamed4;
        frame_rate_t m_frame_rate;
        uint8_t m_input;
        midi_sync_output_t m_output;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        midi_sync_mode_t in_mode() const { return m_in_mode; }
        midi_sync_mode_t out_mode() const { return m_out_mode; }
        uint8_t shift_early() const { return m_shift_early; }
        bool send_mmc_enabled() const { return m_send_mmc_enabled; }
        uint64_t _unnamed4() const { return m__unnamed4; }
        frame_rate_t frame_rate() const { return m_frame_rate; }
        uint8_t input() const { return m_input; }
        midi_sync_output_t output() const { return m_output; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class step_edit_options_t : public kaitai::kstruct {

    public:

        step_edit_options_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~step_edit_options_t();

    private:
        bool m_auto_step_increment;
        duration_of_recorded_notes_t m_duration_of_recorded_notes;
        uint8_t m_tc_value_percentage;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        bool auto_step_increment() const { return m_auto_step_increment; }
        duration_of_recorded_notes_t duration_of_recorded_notes() const { return m_duration_of_recorded_notes; }
        uint8_t tc_value_percentage() const { return m_tc_value_percentage; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class tracks_t : public kaitai::kstruct {

    public:

        tracks_t(kaitai::kstream* p__io, mpc2000xl_all_t::sequence_body_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~tracks_t();

    private:
        std::vector<std::string>* m_names;
        std::vector<uint8_t>* m_device;
        std::vector<bus_t>* m_bus;
        std::vector<uint8_t>* m_program_change;
        std::vector<uint8_t>* m_velocity_ratio;
        std::vector<track_status_t*>* m_status;
        std::string m_unknown;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::sequence_body_t* m__parent;

    public:
        std::vector<std::string>* names() const { return m_names; }
        std::vector<uint8_t>* device() const { return m_device; }
        std::vector<bus_t>* bus() const { return m_bus; }
        std::vector<uint8_t>* program_change() const { return m_program_change; }
        std::vector<uint8_t>* velocity_ratio() const { return m_velocity_ratio; }
        std::vector<track_status_t*>* status() const { return m_status; }
        std::string unknown() const { return m_unknown; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::sequence_body_t* _parent() const { return m__parent; }
    };

    class exclusive_event_t : public kaitai::kstruct {

    public:

        exclusive_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~exclusive_event_t();

    private:
        std::string m__unnamed0;
        std::string m_bytes;
        mixer_event_t* m_mixer;
        bool n_mixer;

    public:
        bool _is_null_mixer() { mixer(); return n_mixer; };

    private:
        std::string m__unnamed3;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::event_t* m__parent;

    public:
        std::string _unnamed0() const { return m__unnamed0; }
        std::string bytes() const { return m_bytes; }
        mixer_event_t* mixer() const { return m_mixer; }
        std::string _unnamed3() const { return m__unnamed3; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::event_t* _parent() const { return m__parent; }
    };

    class sequence_meta_t : public kaitai::kstruct {

    public:

        sequence_meta_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~sequence_meta_t();

    private:
        std::string m_name;
        sequence_is_used_t m_is_used;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        std::string name() const { return m_name; }
        sequence_is_used_t is_used() const { return m_is_used; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class sequence_t : public kaitai::kstruct {

    public:

        sequence_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~sequence_t();

    private:
        bool f_name;
        std::string m_name;
        bool n_name;

    public:
        bool _is_null_name() { name(); return n_name; };

    private:

    public:
        std::string name();

    private:
        std::string m_name_part_1;
        std::string m_name_part_2;
        bool n_name_part_2;

    public:
        bool _is_null_name_part_2() { name_part_2(); return n_name_part_2; };

    private:
        sequence_body_t* m_body;
        bool n_body;

    public:
        bool _is_null_body() { body(); return n_body; };

    private:
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        std::string name_part_1() const { return m_name_part_1; }
        std::string name_part_2() const { return m_name_part_2; }
        sequence_body_t* body() const { return m_body; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class song_step_t : public kaitai::kstruct {

    public:

        song_step_t(kaitai::kstream* p__io, mpc2000xl_all_t::song_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~song_step_t();

    private:
        uint8_t m_sequence_index;
        uint8_t m_repeat_count;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::song_t* m__parent;

    public:
        uint8_t sequence_index() const { return m_sequence_index; }
        uint8_t repeat_count() const { return m_repeat_count; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::song_t* _parent() const { return m__parent; }
    };

    class bar_t : public kaitai::kstruct {

    public:

        bar_t(int32_t p_idx, kaitai::kstream* p__io, mpc2000xl_all_t::sequence_body_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~bar_t();

    private:
        bool f_first_tick;
        int32_t m_first_tick;

    public:
        int32_t first_tick();

    private:
        bool f_numerator;
        int32_t m_numerator;

    public:
        int32_t numerator();

    private:
        bool f_denominator;
        int32_t m_denominator;

    public:
        int32_t denominator();

    private:
        uint8_t m_ticks_per_beat;
        uint64_t m_last_tick;
        int32_t m_idx;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::sequence_body_t* m__parent;

    public:
        uint8_t ticks_per_beat() const { return m_ticks_per_beat; }
        uint64_t last_tick() const { return m_last_tick; }
        int32_t idx() const { return m_idx; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::sequence_body_t* _parent() const { return m__parent; }
    };

    class misc_t : public kaitai::kstruct {

    public:

        misc_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~misc_t();

    private:
        tap_averaging_t m_tap_averaging;
        bool m_midi_sync_in_receive_mmc_enabled;
        std::vector<midi_switch_t*>* m_midi_switch;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        tap_averaging_t tap_averaging() const { return m_tap_averaging; }
        bool midi_sync_in_receive_mmc_enabled() const { return m_midi_sync_in_receive_mmc_enabled; }
        std::vector<midi_switch_t*>* midi_switch() const { return m_midi_switch; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class note_event_t : public kaitai::kstruct {

    public:

        enum note_variation_type_t {
            NOTE_VARIATION_TYPE_TUNE = 0,
            NOTE_VARIATION_TYPE_DECAY = 1,
            NOTE_VARIATION_TYPE_ATTACK = 2,
            NOTE_VARIATION_TYPE_FILTER = 3
        };

        note_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~note_event_t();

    private:
        bool f_note;
        uint8_t m_note;

    public:
        uint8_t note();

    private:
        bool f_duration;
        int32_t m_duration;

    public:
        int32_t duration();

    private:
        bool f_variation_type;
        note_variation_type_t m_variation_type;

    public:
        note_variation_type_t variation_type();

    private:
        uint8_t m_duration_bits_3;
        uint64_t m_velocity;
        bool m_variation_type_bit_1;
        uint64_t m_variation_value;
        bool m_variation_type_bit_2;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::event_t* m__parent;

    public:
        uint8_t duration_bits_3() const { return m_duration_bits_3; }
        uint64_t velocity() const { return m_velocity; }
        bool variation_type_bit_1() const { return m_variation_type_bit_1; }
        uint64_t variation_value() const { return m_variation_value; }
        bool variation_type_bit_2() const { return m_variation_type_bit_2; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::event_t* _parent() const { return m__parent; }
    };

    class control_change_event_t : public kaitai::kstruct {

    public:

        control_change_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~control_change_event_t();

    private:
        controller_t m_controller;
        uint8_t m_value;
        std::string m__unnamed2;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::event_t* m__parent;

    public:
        controller_t controller() const { return m_controller; }
        uint8_t value() const { return m_value; }
        std::string _unnamed2() const { return m__unnamed2; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::event_t* _parent() const { return m__parent; }
    };

    class sequencer_t : public kaitai::kstruct {

    public:

        sequencer_t(kaitai::kstream* p__io, mpc2000xl_all_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~sequencer_t();

    private:
        uint8_t m_active_sequence;
        std::string m__unnamed1;
        uint8_t m_active_track;
        std::string m__unnamed3;
        timing_correct_t m_timing_correct;
        std::string m__unnamed5;
        bool m_second_sequence_enabled;
        uint64_t m__unnamed7;
        uint8_t m_sequence_sequence_index;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t* m__parent;

    public:
        uint8_t active_sequence() const { return m_active_sequence; }
        std::string _unnamed1() const { return m__unnamed1; }
        uint8_t active_track() const { return m_active_track; }
        std::string _unnamed3() const { return m__unnamed3; }
        timing_correct_t timing_correct() const { return m_timing_correct; }
        std::string _unnamed5() const { return m__unnamed5; }
        bool second_sequence_enabled() const { return m_second_sequence_enabled; }
        uint64_t _unnamed7() const { return m__unnamed7; }
        uint8_t sequence_sequence_index() const { return m_sequence_sequence_index; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t* _parent() const { return m__parent; }
    };

    class mixer_event_t : public kaitai::kstruct {

    public:

        mixer_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::exclusive_event_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~mixer_event_t();

    private:
        std::string m__unnamed0;
        mixer_event_param_t m_param;
        uint8_t m_pad_index;
        uint8_t m_value;
        std::string m__unnamed4;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::exclusive_event_t* m__parent;

    public:
        std::string _unnamed0() const { return m__unnamed0; }
        mixer_event_param_t param() const { return m_param; }
        uint8_t pad_index() const { return m_pad_index; }
        uint8_t value() const { return m_value; }
        std::string _unnamed4() const { return m__unnamed4; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::exclusive_event_t* _parent() const { return m__parent; }
    };

    class track_status_t : public kaitai::kstruct {

    public:

        track_status_t(kaitai::kstream* p__io, kaitai::kstruct* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~track_status_t();

    private:
        unused_used_t m_unused_or_used;
        off_on_t m_off_or_on;
        off_on_t m_transmit_program_changes;
        uint64_t m__unnamed3;
        mpc2000xl_all_t* m__root;
        kaitai::kstruct* m__parent;

    public:
        unused_used_t unused_or_used() const { return m_unused_or_used; }
        off_on_t off_or_on() const { return m_off_or_on; }
        off_on_t transmit_program_changes() const { return m_transmit_program_changes; }
        uint64_t _unnamed3() const { return m__unnamed3; }
        mpc2000xl_all_t* _root() const { return m__root; }
        kaitai::kstruct* _parent() const { return m__parent; }
    };

    class poly_pressure_event_t : public kaitai::kstruct {

    public:

        poly_pressure_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~poly_pressure_event_t();

    private:
        uint8_t m_note;
        uint8_t m_pressure;
        std::string m__unnamed2;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::event_t* m__parent;

    public:
        uint8_t note() const { return m_note; }
        uint8_t pressure() const { return m_pressure; }
        std::string _unnamed2() const { return m__unnamed2; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::event_t* _parent() const { return m__parent; }
    };

    class ch_pressure_event_t : public kaitai::kstruct {

    public:

        ch_pressure_event_t(kaitai::kstream* p__io, mpc2000xl_all_t::event_t* p__parent = 0, mpc2000xl_all_t* p__root = 0);

    private:
        void _read();
        void _clean_up();

    public:
        ~ch_pressure_event_t();

    private:
        uint8_t m_pressure;
        std::string m__unnamed1;
        mpc2000xl_all_t* m__root;
        mpc2000xl_all_t::event_t* m__parent;

    public:
        uint8_t pressure() const { return m_pressure; }
        std::string _unnamed1() const { return m__unnamed1; }
        mpc2000xl_all_t* _root() const { return m__root; }
        mpc2000xl_all_t::event_t* _parent() const { return m__parent; }
    };

private:
    std::string m_magic;
    defaults_t* m_defaults;
    sequencer_t* m_sequencer;
    std::string m__unnamed3;
    count_t* m_count;
    midi_input_t* m_midi_input;
    std::string m__unnamed6;
    midi_sync_t* m_midi_sync;
    std::string m_default_song_name;
    std::string m__unnamed9;
    misc_t* m_misc;
    std::string m__unnamed11;
    step_edit_options_t* m_step_edit_options;
    bool m_prog_change_to_seq;
    std::string m__unnamed14;
    std::vector<sequence_meta_t*>* m_sequences_metas;
    std::vector<song_t*>* m_songs;
    std::vector<sequence_t*>* m_sequences;
    mpc2000xl_all_t* m__root;
    kaitai::kstruct* m__parent;

public:
    std::string magic() const { return m_magic; }
    defaults_t* defaults() const { return m_defaults; }
    sequencer_t* sequencer() const { return m_sequencer; }
    std::string _unnamed3() const { return m__unnamed3; }
    count_t* count() const { return m_count; }
    midi_input_t* midi_input() const { return m_midi_input; }
    std::string _unnamed6() const { return m__unnamed6; }
    midi_sync_t* midi_sync() const { return m_midi_sync; }
    std::string default_song_name() const { return m_default_song_name; }
    std::string _unnamed9() const { return m__unnamed9; }
    misc_t* misc() const { return m_misc; }
    std::string _unnamed11() const { return m__unnamed11; }
    step_edit_options_t* step_edit_options() const { return m_step_edit_options; }
    bool prog_change_to_seq() const { return m_prog_change_to_seq; }
    std::string _unnamed14() const { return m__unnamed14; }
    std::vector<sequence_meta_t*>* sequences_metas() const { return m_sequences_metas; }
    std::vector<song_t*>* songs() const { return m_songs; }
    std::vector<sequence_t*>* sequences() const { return m_sequences; }
    mpc2000xl_all_t* _root() const { return m__root; }
    kaitai::kstruct* _parent() const { return m__parent; }
};

#endif  // MPC2000XL_ALL_H_
