;;; ksp-mode.el --- Major mode for editing .ksp files -*- lexical-binding: t -*-

;; Maintainer: YoungJoo Lee <youngker@gmail.com>
;; Homepage: https://github.com/youngker/ksp-mode.el
;; Version: 0.0.1
;; Keywords: ksp, languages
;; Package-Requires: ((emacs "25.1"))

;;; Commentary:

;; A major mode for editing ksp files.

;;; Code:

(defgroup ksp-mode nil
  "ksp mode customizations"
  :group 'ksp)

(defvar ksp-mode-syntax-table
  (let ((table (make-syntax-table)))
    (modify-syntax-entry ?/ ". 124b" table)
    (modify-syntax-entry ?\n "> b" table)
    table)
  "Syntax table for ksp-mode.")

(defconst ksp-variables
  '("$ALL_EVENTS" "$ALL_GROUPS" "$CC_NUM" "$CONTROL_PAR_ACTIVE_INDEX"
    "$CONTROL_PAR_ALLOW_AUTOMATION" "$CONTROL_PAR_AUTOMATION_ID"
    "$CONTROL_PAR_AUTOMATION_NAME" "$CONTROL_PAR_BAR_COLOR"
    "$CONTROL_PAR_BASEPATH" "$CONTROL_PAR_BG_ALPHA" "$CONTROL_PAR_BG_COLOR"
    "$CONTROL_PAR_COLUMN_WIDTH" "$CONTROL_PAR_CURSOR_PICTURE"
    "$CONTROL_PAR_DEFAULT_VALUE" "$CONTROL_PAR_DISABLE_TEXT_SHIFTING"
    "$CONTROL_PAR_DND_ACCEPT_ARRAY" "$CONTROL_PAR_DND_ACCEPT_AUDIO"
    "$CONTROL_PAR_DND_ACCEPT_MIDI" "$CONTROL_PAR_DND_BEHAVIOUR"
    "$CONTROL_PAR_ENABLE_DND" "$CONTROL_PAR_FILE_TYPE" "$CONTROL_PAR_FILEPATH"
    "$CONTROL_PAR_FONT_TYPE" "$CONTROL_PAR_FONT_TYPE_OFF_HOVER"
    "$CONTROL_PAR_FONT_TYPE_OFF_PRESSED" "$CONTROL_PAR_FONT_TYPE_ON"
    "$CONTROL_PAR_FONT_TYPE_ON_HOVER" "$CONTROL_PAR_FONT_TYPE_ON_PRESSED"
    "$CONTROL_PAR_GRID_HEIGHT" "$CONTROL_PAR_GRID_WIDTH" "$CONTROL_PAR_GRID_X"
    "$CONTROL_PAR_GRID_Y" "$CONTROL_PAR_HEIGHT" "$CONTROL_PAR_HELP"
    "$CONTROL_PAR_HIDE" "$CONTROL_PAR_KEY_ALT" "$CONTROL_PAR_KEY_CONTROL"
    "$CONTROL_PAR_KEY_SHIFT" "$CONTROL_PAR_LABEL" "$CONTROL_PAR_MAX_VALUE"
    "$CONTROL_PAR_MIDI_EXPORT_AREA_IDX" "$CONTROL_PAR_MIN_VALUE"
    "$CONTROL_PAR_MOUSE_BEHAVIOUR" "$CONTROL_PAR_MOUSE_BEHAVIOUR_X"
    "$CONTROL_PAR_MOUSE_BEHAVIOUR_Y" "$CONTROL_PAR_MOUSE_MODE" "$CONTROL_PAR_NONE"
    "$CONTROL_PAR_NUM_ITEMS" "$CONTROL_PAR_OFF_COLOR" "$CONTROL_PAR_ON_COLOR"
    "$CONTROL_PAR_OVERLOAD_COLOR" "$CONTROL_PAR_PARALLAX_X"
    "$CONTROL_PAR_PARALLAX_Y" "$CONTROL_PAR_PARENT_PANEL"
    "$CONTROL_PAR_PEAK_COLOR" "$CONTROL_PAR_PICTURE" "$CONTROL_PAR_PICTURE_STATE"
    "$CONTROL_PAR_POS_X" "$CONTROL_PAR_POS_Y" "$CONTROL_PAR_RANGE_MIN"
    "$CONTROL_PAR_RANGE_MAX" "$CONTROL_PAR_RECEIVE_DRAG_EVENTS"
    "$CONTROL_PAR_SELECTED_ITEM_IDX" "$CONTROL_PAR_SHOW_ARROWS"
    "$CONTROL_PAR_SLICEMARKERS_COLOR" "$CONTROL_PAR_TEXT"
    "$CONTROL_PAR_TEXT_ALIGNMENT" "$CONTROL_PAR_TEXTLINE" "$CONTROL_PAR_TEXTPOS_Y"
    "$CONTROL_PAR_UNIT" "$CONTROL_PAR_VALUE" "$CONTROL_PAR_VERTICAL"
    "$CONTROL_PAR_WAVE_ALPHA" "$CONTROL_PAR_WAVE_COLOR"
    "$CONTROL_PAR_WAVE_CURSOR_COLOR" "$CONTROL_PAR_WAVE_END_ALPHA"
    "$CONTROL_PAR_WAVE_END_COLOR" "$CONTROL_PAR_WAVETABLE_ALPHA"
    "$CONTROL_PAR_WAVETABLE_COLOR" "$CONTROL_PAR_WAVETABLE_END_ALPHA"
    "$CONTROL_PAR_WAVETABLE_END_COLOR" "$CONTROL_PAR_WF_VIS_MODE"
    "$CONTROL_PAR_WIDTH" "$CONTROL_PAR_WT_VIS_MODE" "$CONTROL_PAR_WT_ZONE"
    "$CONTROL_PAR_Z_LAYER" "$CONTROL_PAR_ZERO_LINE_COLOR" "$CURRENT_EVENT"
    "$CURRENT_SCRIPT_SLOT" "$DISTANCE_BAR_START" "$DURATION_BAR"
    "$DURATION_EIGHTH" "$DURATION_EIGHTH_TRIPLET" "$DURATION_QUARTER"
    "$DURATION_QUARTER_TRIPLET" "$DURATION_SIXTEENTH"
    "$DURATION_SIXTEENTH_TRIPLET" "$EFFECT_TYPE_ACBOX" "$EFFECT_TYPE_AET_FILTER"
    "$EFFECT_TYPE_BASSINVADER" "$EFFECT_TYPE_BASSPRO" "$EFFECT_TYPE_BUS_COMP"
    "$EFFECT_TYPE_CABINET" "$EFFECT_TYPE_CAT" "$EFFECT_TYPE_CHORAL"
    "$EFFECT_TYPE_CHORUS" "$EFFECT_TYPE_COMPRESSOR" "$EFFECT_TYPE_CRYWAH"
    "$EFFECT_TYPE_DELAY" "$EFFECT_TYPE_DISTORTION" "$EFFECT_TYPE_DSTORTION"
    "$EFFECT_TYPE_FB_COMP" "$EFFECT_TYPE_FILTER" "$EFFECT_TYPE_FLAIR"
    "$EFFECT_TYPE_FLANGER" "$EFFECT_TYPE_GAINER" "$EFFECT_TYPE_HOTSOLO"
    "$EFFECT_TYPE_INVERTER" "$EFFECT_TYPE_IRC" "$EFFECT_TYPE_JUMP"
    "$EFFECT_TYPE_LIMITER" "$EFFECT_TYPE_LOFI" "$EFFECT_TYPE_NONE"
    "$EFFECT_TYPE_PHASER" "$EFFECT_TYPE_PHASIS" "$EFFECT_TYPE_PLATEREVERB"
    "$EFFECT_TYPE_REPLIKA" "$EFFECT_TYPE_REVERB" "$EFFECT_TYPE_REVERB2"
    "$EFFECT_TYPE_ROTATOR" "$EFFECT_TYPE_SEND_LEVELS" "$EFFECT_TYPE_SHAPER"
    "$EFFECT_TYPE_SKREAMER" "$EFFECT_TYPE_SOLID_GEQ" "$EFFECT_TYPE_STEREO"
    "$EFFECT_TYPE_SUPERGT" "$EFFECT_TYPE_SURROUND_PANNER" "$EFFECT_TYPE_TAPE_SAT"
    "$EFFECT_TYPE_TRANS_MASTER" "$EFFECT_TYPE_TRANSLIM" "$EFFECT_TYPE_TWANG"
    "$EFFECT_TYPE_VAN51" "$ENGINE_PAR_AC_BASS" "$ENGINE_PAR_AC_BRILLIANTVOLUME"
    "$ENGINE_PAR_AC_MONO" "$ENGINE_PAR_AC_NORMALVOLUME" "$ENGINE_PAR_AC_TONECUT"
    "$ENGINE_PAR_AC_TREBLE" "$ENGINE_PAR_AC_TREMOLODEPTH"
    "$ENGINE_PAR_AC_TREMOLOSPEED" "$ENGINE_PAR_ATK_CURVE" "$ENGINE_PAR_ATTACK"
    "$ENGINE_PAR_ATTACK_UNIT" "$ENGINE_PAR_AUX_LEVEL_0" "$ENGINE_PAR_AUX_LEVEL_1"
    "$ENGINE_PAR_AUX_LEVEL_2" "$ENGINE_PAR_AUX_LEVEL_3" "$ENGINE_PAR_BANDWIDTH"
    "$ENGINE_PAR_BASSINVADER_VOLUME" "$ENGINE_PAR_BASSINVADER_TREBLE"
    "$ENGINE_PAR_BASSINVADER_HI_MID" "$ENGINE_PAR_BASSINVADER_LO_MID"
    "$ENGINE_PAR_BASSINVADER_BASS" "$ENGINE_PAR_BASSINVADER_BOOST"
    "$ENGINE_PAR_BASSINVADER_MASTER" "$ENGINE_PAR_BASSINVADER_LO_CUT"
    "$ENGINE_PAR_BASSINVADER_MID_CONTOUR" "$ENGINE_PAR_BASSINVADER_HI_BOOST"
    "$ENGINE_PAR_BITS" "$ENGINE_PAR_BASSPRO_GAIN" "$ENGINE_PAR_BASSPRO_BASS"
    "$ENGINE_PAR_BASSPRO_MID" "$ENGINE_PAR_BASSPRO_MIDFREQ"
    "$ENGINE_PAR_BASSPRO_TREBLE" "$ENGINE_PAR_BASSPRO_DRIVE"
    "$ENGINE_PAR_BASSPRO_MASTER" "$ENGINE_PAR_BASSPRO_GEQ_40"
    "$ENGINE_PAR_BASSPRO_GEQ_90" "$ENGINE_PAR_BASSPRO_GEQ_180"
    "$ENGINE_PAR_BASSPRO_GEQ_300" "$ENGINE_PAR_BASSPRO_GEQ_500"
    "$ENGINE_PAR_BASSPRO_GEQ_1K" "$ENGINE_PAR_BASSPRO_GEQ_2K"
    "$ENGINE_PAR_BASSPRO_GEQ_4K" "$ENGINE_PAR_BASSPRO_GEQ_10K"
    "$ENGINE_PAR_BASSPRO_GEQ_VOLUME" "$ENGINE_PAR_BASSPRO_ULTRALO"
    "$ENGINE_PAR_BASSPRO_ULTRAHI" "$ENGINE_PAR_BASSPRO_BRIGHT"
    "$ENGINE_PAR_BASSPRO_GEQ" "$ENGINE_PAR_BASSPRO_MONO" "$ENGINE_PAR_BREAK"
    "$ENGINE_PAR_BW1" "$ENGINE_PAR_BW2" "$ENGINE_PAR_BW3"
    "$ENGINE_PAR_CABINET_TYPE" "$ENGINE_PAR_CB_AIR" "$ENGINE_PAR_CB_BASS"
    "$ENGINE_PAR_CB_SIZE" "$ENGINE_PAR_CB_TREBLE" "$ENGINE_PAR_CH_DEPTH"
    "$ENGINE_PAR_CH_PHASE" "$ENGINE_PAR_CH_SPEED" "$ENGINE_PAR_CH_SPEED_UNIT"
    "$ENGINE_PAR_CHORAL_AMOUNT" "$ENGINE_PAR_CHORAL_DELAY"
    "$ENGINE_PAR_CHORAL_FEEDBACK" "$ENGINE_PAR_CHORAL_INVERT_PHASE"
    "$ENGINE_PAR_CHORAL_MIX" "$ENGINE_PAR_CHORAL_MODE" "$ENGINE_PAR_CHORAL_RATE"
    "$ENGINE_PAR_CHORAL_SCATTER" "$ENGINE_PAR_CHORAL_VOICES"
    "$ENGINE_PAR_CHORAL_WIDTH" "$ENGINE_PAR_COMP_ATTACK" "$ENGINE_PAR_COMP_DECAY"
    "$ENGINE_PAR_COMP_LINK" "$ENGINE_PAR_COMP_TYPE" "$ENGINE_PAR_CT_BALLS"
    "$ENGINE_PAR_CT_BASS" "$ENGINE_PAR_CT_DISTORTION" "$ENGINE_PAR_CT_FILTER"
    "$ENGINE_PAR_CT_MONO" "$ENGINE_PAR_CT_TONE" "$ENGINE_PAR_CT_TREBLE"
    "$ENGINE_PAR_CT_VOLUME" "$ENGINE_PAR_CUTOFF" "$ENGINE_PAR_CW_MONO"
    "$ENGINE_PAR_CW_PEDAL" "$ENGINE_PAR_DAMPING" "$ENGINE_PAR_DECAY"
    "$ENGINE_PAR_DECAY1" "$ENGINE_PAR_DECAY1_UNIT" "$ENGINE_PAR_DECAY2"
    "$ENGINE_PAR_DECAY2_UNIT" "$ENGINE_PAR_DECAY_UNIT"
    "$ENGINE_PAR_DISTORTION_TYPE" "$ENGINE_PAR_DL_DAMPING"
    "$ENGINE_PAR_DL_FEEDBACK" "$ENGINE_PAR_DL_PAN" "$ENGINE_PAR_DL_TIME"
    "$ENGINE_PAR_DL_TIME_UNIT" "$ENGINE_PAR_DRIVE" "$ENGINE_PAR_DS_BASS"
    "$ENGINE_PAR_DS_DRIVE" "$ENGINE_PAR_DS_MID" "$ENGINE_PAR_DS_MONO"
    "$ENGINE_PAR_DS_TONE" "$ENGINE_PAR_DS_TREBLE" "$ENGINE_PAR_DS_VOLUME"
    "$ENGINE_PAR_EFFECT_BYPASS" "$ENGINE_PAR_EFFECT_SUBTYPE"
    "$ENGINE_PAR_EFFECT_TYPE" "$ENGINE_PAR_ENV_AHD" "$ENGINE_PAR_ENV_DBD_EASY"
    "$ENGINE_PAR_ENVELOPE_ORDER" "$ENGINE_PAR_ENVF_ADAPTION"
    "$ENGINE_PAR_ENVF_ATTACK" "$ENGINE_PAR_ENVF_GAIN_BOOST"
    "$ENGINE_PAR_ENVF_RELEASE" "$ENGINE_PAR_EXP_FILTER_AMOUNT"
    "$ENGINE_PAR_EXP_FILTER_MORPH" "$ENGINE_PAR_EXTMOD_INTENSITY"
    "$ENGINE_PAR_FCOMP_ATTACK" "$ENGINE_PAR_FCOMP_HQ_MODE"
    "$ENGINE_PAR_FCOMP_INPUT" "$ENGINE_PAR_FCOMP_LINK" "$ENGINE_PAR_FCOMP_MAKEUP"
    "$ENGINE_PAR_FCOMP_MIX" "$ENGINE_PAR_FCOMP_RATIO" "$ENGINE_PAR_FCOMP_RELEASE"
    "$ENGINE_PAR_FILTER_BYPA" "$ENGINE_PAR_FILTER_BYPB" "$ENGINE_PAR_FILTER_BYPC"
    "$ENGINE_PAR_FILTER_GAIN" "$ENGINE_PAR_FILTER_LADDER_HQ"
    "$ENGINE_PAR_FILTER_RESB" "$ENGINE_PAR_FILTER_RESC"
    "$ENGINE_PAR_FILTER_SHIFTB" "$ENGINE_PAR_FILTER_SHIFTC"
    "$ENGINE_PAR_FILTER_TYPEA" "$ENGINE_PAR_FILTER_TYPEB"
    "$ENGINE_PAR_FILTER_TYPEC" "$ENGINE_PAR_FL_COLOR" "$ENGINE_PAR_FL_DEPTH"
    "$ENGINE_PAR_FL_FEEDBACK" "$ENGINE_PAR_FL_PHASE" "$ENGINE_PAR_FL_SPEED"
    "$ENGINE_PAR_FL_SPEED_UNIT" "$ENGINE_PAR_FLAIR_AMOUNT"
    "$ENGINE_PAR_FLAIR_CHORD" "$ENGINE_PAR_FLAIR_DAMPING"
    "$ENGINE_PAR_FLAIR_DETUNE" "$ENGINE_PAR_FLAIR_FEEDBACK"
    "$ENGINE_PAR_FLAIR_INVERT_PHASE" "$ENGINE_PAR_FLAIR_MIX"
    "$ENGINE_PAR_FLAIR_MODE" "$ENGINE_PAR_FLAIR_OFFSET" "$ENGINE_PAR_FLAIR_PITCH"
    "$ENGINE_PAR_FLAIR_RATE" "$ENGINE_PAR_FLAIR_RATE_UNIT"
    "$ENGINE_PAR_FLAIR_SCANMODE" "$ENGINE_PAR_FLAIR_VOICES"
    "$ENGINE_PAR_FLAIR_WIDTH" "$ENGINE_PAR_FORMANT" "$ENGINE_PAR_FORMANT_SHARP"
    "$ENGINE_PAR_FORMANT_SHIFT" "$ENGINE_PAR_FORMANT_SIZE"
    "$ENGINE_PAR_FORMANT_TALK" "$ENGINE_PAR_FREQ1" "$ENGINE_PAR_FREQ2"
    "$ENGINE_PAR_FREQ3" "$ENGINE_PAR_FREQUENCY" "$ENGINE_PAR_GAIN"
    "$ENGINE_PAR_GAIN1" "$ENGINE_PAR_GAIN2" "$ENGINE_PAR_GAIN3"
    "$ENGINE_PAR_GLIDE_COEF" "$ENGINE_PAR_GLIDE_COEF_UNIT" "$ENGINE_PAR_GN_GAIN"
    "$ENGINE_PAR_GRAIN_LENGTH" "$ENGINE_PAR_GROUP_DYNAMICS" "$ENGINE_PAR_HOLD"
    "$ENGINE_PAR_HOLD_UNIT" "$ENGINE_PAR_HP_CUTOFF" "$ENGINE_PAR_HS_BASS"
    "$ENGINE_PAR_HS_DEPTH" "$ENGINE_PAR_HS_MASTER" "$ENGINE_PAR_HS_MID"
    "$ENGINE_PAR_HS_MONO" "$ENGINE_PAR_HS_OVERDRIVE" "$ENGINE_PAR_HS_PRENORMAL"
    "$ENGINE_PAR_HS_PREOVERDRIVE" "$ENGINE_PAR_HS_PRESENCE"
    "$ENGINE_PAR_HS_TREBLE" "$ENGINE_PAR_INSERT_EFFECT_OUTPUT_GAIN"
    "$ENGINE_PAR_INTMOD_BYPASS" "$ENGINE_PAR_INTMOD_FREQUENCY"
    "$ENGINE_PAR_INTMOD_FREQUENCY_UNIT" "$ENGINE_PAR_INTMOD_INTENSITY"
    "$ENGINE_PAR_INTMOD_PULSEWIDTH" "$ENGINE_PAR_INTMOD_RETRIGGER"
    "$ENGINE_PAR_INTMOD_SUBTYPE" "$ENGINE_PAR_INTMOD_TYPE"
    "$ENGINE_PAR_IRC_ER_LR_BOUNDARY" "$ENGINE_PAR_IRC_FREQ_HIGHPASS_ER"
    "$ENGINE_PAR_IRC_FREQ_HIGHPASS_LR" "$ENGINE_PAR_IRC_FREQ_LOWPASS_ER"
    "$ENGINE_PAR_IRC_FREQ_LOWPASS_LR" "$ENGINE_PAR_IRC_LENGTH_RATIO_ER"
    "$ENGINE_PAR_IRC_LENGTH_RATIO_LR" "$ENGINE_PAR_IRC_PREDELAY"
    "$ENGINE_PAR_IRC_REVERSE" "$ENGINE_PAR_JMP_BASS" "$ENGINE_PAR_JMP_HIGAIN"
    "$ENGINE_PAR_JMP_MASTER" "$ENGINE_PAR_JMP_MID" "$ENGINE_PAR_JMP_MONO"
    "$ENGINE_PAR_JMP_PREAMP" "$ENGINE_PAR_JMP_PRESENCE" "$ENGINE_PAR_JMP_TREBLE"
    "$ENGINE_PAR_LFO_DELAY" "$ENGINE_PAR_LFO_DELAY_UNIT"
    "$ENGINE_PAR_LFO_NORMALIZE" "$ENGINE_PAR_LFO_RAND" "$ENGINE_PAR_LFO_RECT"
    "$ENGINE_PAR_LFO_SAW" "$ENGINE_PAR_LFO_SINE" "$ENGINE_PAR_LFO_TRI"
    "$ENGINE_PAR_LIM_IN_GAIN" "$ENGINE_PAR_LIM_RELEASE" "$ENGINE_PAR_LP_CUTOFF"
    "$ENGINE_PAR_LR_SWAP" "$ENGINE_PAR_MOD_TARGET_INTENSITY"
    "$ENGINE_PAR_NOISECOLOR" "$ENGINE_PAR_NOISELEVEL" "$ENGINE_PAR_OUTPUT_CHANNEL"
    "$ENGINE_PAR_PAN" "$ENGINE_PAR_PH_DEPTH" "$ENGINE_PAR_PH_FEEDBACK"
    "$ENGINE_PAR_PH_PHASE" "$ENGINE_PAR_PH_SPEED" "$ENGINE_PAR_PH_SPEED_UNIT"
    "$ENGINE_PAR_PHASE_INVERT" "$ENGINE_PAR_PHASIS_AMOUNT"
    "$ENGINE_PAR_PHASIS_CENTER" "$ENGINE_PAR_PHASIS_FEEDBACK"
    "$ENGINE_PAR_PHASIS_INVERT_MOD_MIX" "$ENGINE_PAR_PHASIS_INVERT_PHASE"
    "$ENGINE_PAR_PHASIS_MIX" "$ENGINE_PAR_PHASIS_MOD_MIX"
    "$ENGINE_PAR_PHASIS_NOTCHES" "$ENGINE_PAR_PHASIS_RATE"
    "$ENGINE_PAR_PHASIS_RATE_UNIT" "$ENGINE_PAR_PHASIS_SPREAD"
    "$ENGINE_PAR_PHASIS_STEREO" "$ENGINE_PAR_PHASIS_ULTRA"
    "$ENGINE_PAR_POST_FX_SLOT" "$ENGINE_PAR_PR_DECAY" "$ENGINE_PAR_PR_HIDAMP"
    "$ENGINE_PAR_PR_LOWSHELF" "$ENGINE_PAR_PR_PREDELAY" "$ENGINE_PAR_PR_STEREO"
    "$ENGINE_PAR_RATIO" "$ENGINE_PAR_RDL_AMOUNT" "$ENGINE_PAR_RDL_BBDTYPE"
    "$ENGINE_PAR_RDL_DENSE" "$ENGINE_PAR_RDL_DEPTH" "$ENGINE_PAR_RDL_FEEDBACK"
    "$ENGINE_PAR_RDL_FLUTTER" "$ENGINE_PAR_RDL_HIGHCUT" "$ENGINE_PAR_RDL_LOWCUT"
    "$ENGINE_PAR_RDL_MODULATION" "$ENGINE_PAR_RDL_NOISE"
    "$ENGINE_PAR_RDL_PINGPONG" "$ENGINE_PAR_RDL_QUALITY" "$ENGINE_PAR_RDL_RATE"
    "$ENGINE_PAR_RDL_SATURATION" "$ENGINE_PAR_RDL_SIZE" "$ENGINE_PAR_RDL_STEREO"
    "$ENGINE_PAR_RDL_TAPEAGE" "$ENGINE_PAR_RDL_TIME" "$ENGINE_PAR_RDL_TIME_UNIT"
    "$ENGINE_PAR_RDL_TYPE" "$ENGINE_PAR_RELEASE" "$ENGINE_PAR_RELEASE_TRIGGER"
    "$ENGINE_PAR_RELEASE_UNIT" "$ENGINE_PAR_RESONANCE" "$ENGINE_PAR_RT_ACCEL_HI"
    "$ENGINE_PAR_RT_ACCEL_LO" "$ENGINE_PAR_RT_BALANCE" "$ENGINE_PAR_RT_DISTANCE"
    "$ENGINE_PAR_RT_MIX" "$ENGINE_PAR_RT_SPEED" "$ENGINE_PAR_RV2_DAMPING"
    "$ENGINE_PAR_RV2_DIFF" "$ENGINE_PAR_RV2_HIGHCUT" "$ENGINE_PAR_RV2_LOWSHELF"
    "$ENGINE_PAR_RV2_MOD" "$ENGINE_PAR_RV2_PREDELAY" "$ENGINE_PAR_RV2_SIZE"
    "$ENGINE_PAR_RV2_STEREO" "$ENGINE_PAR_RV2_TIME" "$ENGINE_PAR_RV2_TYPE"
    "$ENGINE_PAR_RV_COLOUR" "$ENGINE_PAR_RV_DAMPING" "$ENGINE_PAR_RV_PREDELAY"
    "$ENGINE_PAR_RV_SIZE" "$ENGINE_PAR_RV_STEREO" "$ENGINE_PAR_SCOMP_ATTACK"
    "$ENGINE_PAR_SCOMP_LINK" "$ENGINE_PAR_SCOMP_MAKEUP" "$ENGINE_PAR_SCOMP_MIX"
    "$ENGINE_PAR_SCOMP_RATIO" "$ENGINE_PAR_SCOMP_RELEASE"
    "$ENGINE_PAR_SCOMP_THRESHOLD" "$ENGINE_PAR_SEND_EFFECT_BYPASS"
    "$ENGINE_PAR_SEND_EFFECT_DRY_LEVEL" "$ENGINE_PAR_SEND_EFFECT_OUTPUT_GAIN"
    "$ENGINE_PAR_SEND_EFFECT_TYPE" "$ENGINE_PAR_SENDLEVEL_0"
    "$ENGINE_PAR_SENDLEVEL_1" "$ENGINE_PAR_SENDLEVEL_2" "$ENGINE_PAR_SENDLEVEL_3"
    "$ENGINE_PAR_SENDLEVEL_4" "$ENGINE_PAR_SENDLEVEL_5" "$ENGINE_PAR_SENDLEVEL_6"
    "$ENGINE_PAR_SENDLEVEL_7" "$ENGINE_PAR_SENDLEVEL_SMOOTHED_0"
    "$ENGINE_PAR_SENDLEVEL_SMOOTHED_1" "$ENGINE_PAR_SENDLEVEL_SMOOTHED_2"
    "$ENGINE_PAR_SENDLEVEL_SMOOTHED_3" "$ENGINE_PAR_SENDLEVEL_SMOOTHED_4"
    "$ENGINE_PAR_SENDLEVEL_SMOOTHED_5" "$ENGINE_PAR_SENDLEVEL_SMOOTHED_6"
    "$ENGINE_PAR_SENDLEVEL_SMOOTHED_7" "$ENGINE_PAR_SEQ_HF_BELL"
    "$ENGINE_PAR_SEQ_HF_FREQ" "$ENGINE_PAR_SEQ_HF_GAIN" "$ENGINE_PAR_SEQ_HMF_FREQ"
    "$ENGINE_PAR_SEQ_HMF_GAIN" "$ENGINE_PAR_SEQ_HMF_Q" "$ENGINE_PAR_SEQ_LF_BELL"
    "$ENGINE_PAR_SEQ_LF_FREQ" "$ENGINE_PAR_SEQ_LF_GAIN" "$ENGINE_PAR_SEQ_LMF_FREQ"
    "$ENGINE_PAR_SEQ_LMF_GAIN" "$ENGINE_PAR_SEQ_LMF_Q" "$ENGINE_PAR_SHAPE"
    "$ENGINE_PAR_SHAPE_TYPE" "$ENGINE_PAR_SK_BASS" "$ENGINE_PAR_SK_BRIGHT"
    "$ENGINE_PAR_SK_DRIVE" "$ENGINE_PAR_SK_MIX" "$ENGINE_PAR_SK_TONE"
    "$ENGINE_PAR_SLICE_ATTACK" "$ENGINE_PAR_SLICE_RELEASE" "$ENGINE_PAR_SMOOTH"
    "$ENGINE_PAR_SP_DIVERGENCE" "$ENGINE_PAR_SP_LFE_VOLUME"
    "$ENGINE_PAR_SP_OFFSET_AZIMUTH" "$ENGINE_PAR_SP_OFFSET_DISTANCE"
    "$ENGINE_PAR_SP_OFFSET_X" "$ENGINE_PAR_SP_OFFSET_Y" "$ENGINE_PAR_SP_SIZE"
    "$ENGINE_PAR_SPEED" "$ENGINE_PAR_SPEED_UNIT"
    "$ENGINE_PAR_START_CRITERIA_CC_MAX" "$ENGINE_PAR_START_CRITERIA_CC_MIN"
    "$ENGINE_PAR_START_CRITERIA_CONTROLLER"
    "$ENGINE_PAR_START_CRITERIA_CYCLE_CLASS" "$ENGINE_PAR_START_CRITERIA_KEY_MAX"
    "$ENGINE_PAR_START_CRITERIA_KEY_MIN" "$ENGINE_PAR_START_CRITERIA_MODE"
    "$ENGINE_PAR_START_CRITERIA_NEXT_CRIT" "$ENGINE_PAR_START_CRITERIA_SEQ_ONLY"
    "$ENGINE_PAR_START_CRITERIA_SLICE_IDX" "$ENGINE_PAR_START_CRITERIA_ZONE_IDX"
    "$ENGINE_PAR_STEREO" "$ENGINE_PAR_STEREO_PAN" "$ENGINE_PAR_STEREO_PSEUDO"
    "$ENGINE_PAR_SUPERGT_ATTACK" "$ENGINE_PAR_SUPERGT_CHANNEL_LINK_MODE"
    "$ENGINE_PAR_SUPERGT_CHAR_MODE" "$ENGINE_PAR_SUPERGT_CHARACTER"
    "$ENGINE_PAR_SUPERGT_COMPRESS" "$ENGINE_PAR_SUPERGT_HPF_MODE"
    "$ENGINE_PAR_SUPERGT_MIX" "$ENGINE_PAR_SUPERGT_RELEASE"
    "$ENGINE_PAR_SUPERGT_SAT_MODE" "$ENGINE_PAR_SUPERGT_SATURATION"
    "$ENGINE_PAR_SUPERGT_TRIM" "$ENGINE_PAR_SUSTAIN" "$ENGINE_PAR_THRESHOLD"
    "$ENGINE_PAR_TP_GAIN" "$ENGINE_PAR_TP_HF_ROLLOFF" "$ENGINE_PAR_TP_QUALITY"
    "$ENGINE_PAR_TP_WARMTH" "$ENGINE_PAR_TR_ATTACK" "$ENGINE_PAR_TR_INPUT"
    "$ENGINE_PAR_TR_SMOOTH" "$ENGINE_PAR_TR_SUSTAIN" "$ENGINE_PAR_TRANSIENT_SIZE"
    "$ENGINE_PAR_TRANSLIM_CEILING" "$ENGINE_PAR_TRANSLIM_RELEASE"
    "$ENGINE_PAR_TRANSLIM_THRESHOLD" "$ENGINE_PAR_TUNE" "$ENGINE_PAR_TW_BASS"
    "$ENGINE_PAR_TW_BRIGHT" "$ENGINE_PAR_TW_MID" "$ENGINE_PAR_TW_MONO"
    "$ENGINE_PAR_TW_TREBLE" "$ENGINE_PAR_TW_VOLUME" "$ENGINE_PAR_V5_BASS"
    "$ENGINE_PAR_V5_BRIGHT" "$ENGINE_PAR_V5_CRUNCH" "$ENGINE_PAR_V5_HIGAIN"
    "$ENGINE_PAR_V5_LEADCHANNEL" "$ENGINE_PAR_V5_MID" "$ENGINE_PAR_V5_MONO"
    "$ENGINE_PAR_V5_POSTGAIN" "$ENGINE_PAR_V5_PREGAINLEAD"
    "$ENGINE_PAR_V5_PREGAINRHYTHM" "$ENGINE_PAR_V5_PRESENCE"
    "$ENGINE_PAR_V5_RESONANCE" "$ENGINE_PAR_V5_TREBLE" "$ENGINE_PAR_VOLUME"
    "$ENGINE_PAR_WT_FORM" "$ENGINE_PAR_WT_FORM_MODE" "$ENGINE_PAR_WT_INHARMONIC"
    "$ENGINE_PAR_WT_INHARMONIC_MODE" "$ENGINE_PAR_WT_PHASE"
    "$ENGINE_PAR_WT_PHASE_RAND" "$ENGINE_PAR_WT_POSITION" "$ENGINE_PAR_WT_QUALITY"
    "$ENGINE_UPTIME" "$ENV_TYPE_AHDSR" "$ENV_TYPE_DBD" "$ENV_TYPE_FLEX"
    "$EVENT_ID" "$EVENT_NOTE" "$EVENT_PAR_0" "$EVENT_PAR_1" "$EVENT_PAR_2"
    "$EVENT_PAR_3" "$EVENT_PAR_ALLOW_GROUP" "$EVENT_PAR_CUSTOM" "$EVENT_PAR_ID"
    "$EVENT_PAR_MIDI_BYTE_1" "$EVENT_PAR_MIDI_BYTE_2" "$EVENT_PAR_MIDI_CHANNEL"
    "$EVENT_PAR_MIDI_COMMAND" "$EVENT_PAR_MOD_VALUE_ID" "$EVENT_PAR_NOTE"
    "$EVENT_PAR_NOTE_LENGTH" "$EVENT_PAR_PAN" "$EVENT_PAR_PLAY_POS"
    "$EVENT_PAR_POS" "$EVENT_PAR_REL_VELOCITY" "$EVENT_PAR_SOURCE"
    "$EVENT_PAR_TRACK_NR" "$EVENT_PAR_TUNE" "$EVENT_PAR_VELOCITY"
    "$EVENT_PAR_VOLUME" "$EVENT_PAR_ZONE_ID" "$EVENT_STATUS_INACTIVE"
    "$EVENT_STATUS_MIDI_QUEUE" "$EVENT_STATUS_NOTE_QUEUE" "$EVENT_VELOCITY"
    "$FILTER_TYPE_AR_BP2" "$FILTER_TYPE_AR_BP24" "$FILTER_TYPE_AR_BP4"
    "$FILTER_TYPE_AR_HP2" "$FILTER_TYPE_AR_HP24" "$FILTER_TYPE_AR_HP4"
    "$FILTER_TYPE_AR_LP2" "$FILTER_TYPE_AR_LP24" "$FILTER_TYPE_AR_LP4"
    "$FILTER_TYPE_BP2POLE" "$FILTER_TYPE_BP4POLE" "$FILTER_TYPE_BR4POLE"
    "$FILTER_TYPE_DAFT_HP" "$FILTER_TYPE_DAFT_LP" "$FILTER_TYPE_EQ1BAND"
    "$FILTER_TYPE_EQ2BAND" "$FILTER_TYPE_EQ3BAND" "$FILTER_TYPE_FORMANT_1"
    "$FILTER_TYPE_FORMANT_2" "$FILTER_TYPE_HP1POLE" "$FILTER_TYPE_HP2POLE"
    "$FILTER_TYPE_HP4POLE" "$FILTER_TYPE_LADDER" "$FILTER_TYPE_LDR_BP2"
    "$FILTER_TYPE_LDR_BP4" "$FILTER_TYPE_LDR_HP1" "$FILTER_TYPE_LDR_HP2"
    "$FILTER_TYPE_LDR_HP3" "$FILTER_TYPE_LDR_HP4" "$FILTER_TYPE_LDR_LP1"
    "$FILTER_TYPE_LDR_LP2" "$FILTER_TYPE_LDR_LP3" "$FILTER_TYPE_LDR_LP4"
    "$FILTER_TYPE_LDR_NOTCH" "$FILTER_TYPE_LDR_PEAK" "$FILTER_TYPE_LP1POLE"
    "$FILTER_TYPE_LP2POLE" "$FILTER_TYPE_LP4POLE" "$FILTER_TYPE_LP6POLE"
    "$FILTER_TYPE_PHASER" "$FILTER_TYPE_PRO52" "$FILTER_TYPE_SIMPLE_LPHP"
    "$FILTER_TYPE_SV_BP2" "$FILTER_TYPE_SV_BP4" "$FILTER_TYPE_SV_HP1"
    "$FILTER_TYPE_SV_HP2" "$FILTER_TYPE_SV_HP4" "$FILTER_TYPE_SV_LP1"
    "$FILTER_TYPE_SV_LP2" "$FILTER_TYPE_SV_LP4" "$FILTER_TYPE_SV_NOTCH4"
    "$FILTER_TYPE_SV_PAR_BPBP" "$FILTER_TYPE_SV_PAR_LPHP"
    "$FILTER_TYPE_SV_SER_LPHP" "$FILTER_TYPE_VERSATILE" "$FILTER_TYPE_VOWELA"
    "$FILTER_TYPE_VOWELB" "$GET_FOLDER_FACTORY_DIR" "$GET_FOLDER_INSTALL_DIR"
    "$GET_FOLDER_LIBRARY_DIR" "$GET_FOLDER_PATCH_DIR" "$HIDE_PART_BG"
    "$HIDE_PART_CURSOR" "$HIDE_PART_MOD_LIGHT" "$HIDE_PART_NOTHING"
    "$HIDE_PART_TITLE" "$HIDE_PART_VALUE" "$HIDE_WHOLE_CONTROL"
    "$IDX_OFFSET_EXT_MOD" "$INST_ICON_ID" "$INST_LIB_COPYRIGHT_ID"
    "$INST_LIB_DESCRIPTION_ID" "$INST_LIB_PIC_ONE_ID" "$INST_LIB_PIC_TWO_ID"
    "$INST_WALLPAPER_ID" "$INTMOD_TYPE_ENV_FOLLOW" "$INTMOD_TYPE_ENVELOPE"
    "$INTMOD_TYPE_GLIDE" "$INTMOD_TYPE_LFO" "$INTMOD_TYPE_NONE"
    "$INTMOD_TYPE_STEPMOD" "$KEY_COLOR_BLACK" "$KEY_COLOR_BLUE" "$KEY_COLOR_CYAN"
    "$KEY_COLOR_DEFAULT" "$KEY_COLOR_FUCHSIA" "$KEY_COLOR_GREEN"
    "$KEY_COLOR_INACTIVE" "$KEY_COLOR_LIGHT_ORANGE" "$KEY_COLOR_LIME"
    "$KEY_COLOR_MAGENTA" "$KEY_COLOR_MINT" "$KEY_COLOR_NONE" "$KEY_COLOR_ORANGE"
    "$KEY_COLOR_PLUM" "$KEY_COLOR_PURPLE" "$KEY_COLOR_RED" "$KEY_COLOR_TURQUOISE"
    "$KEY_COLOR_VIOLET" "$KEY_COLOR_WARM_YELLOW" "$KEY_COLOR_WHITE"
    "$KEY_COLOR_YELLOW" "$KNOB_UNIT_DB" "$KNOB_UNIT_HZ" "$KNOB_UNIT_MS"
    "$KNOB_UNIT_NONE" "$KNOB_UNIT_OCT" "$KNOB_UNIT_PERCENT" "$KNOB_UNIT_ST"
    "$KSP_TIMER" "$LFO_TYPE_MULTI" "$LFO_TYPE_MULTI_DIGITAL" "$LFO_TYPE_RANDOM"
    "$LFO_TYPE_RECTANGLE" "$LFO_TYPE_SAWTOOTH" "$LFO_TYPE_SINE"
    "$LFO_TYPE_TRIANGLE" "$LOOP_PAR_COUNT" "$LOOP_PAR_LENGTH" "$LOOP_PAR_MODE"
    "$LOOP_PAR_START" "$LOOP_PAR_TUNING" "$LOOP_PAR_XFADE" "$MARK_1" "$MARK_2"
    "$MARK_3" "$MARK_4" "$MARK_5" "$MARK_6" "$MARK_7" "$MARK_8" "$MARK_9"
    "$MARK_10" "$MARK_11" "$MARK_12" "$MARK_13" "$MARK_14" "$MARK_15" "$MARK_16"
    "$MARK_17" "$MARK_18" "$MARK_19" "$MARK_20" "$MARK_21" "$MARK_22" "$MARK_23"
    "$MARK_24" "$MARK_25" "$MARK_26" "$MARK_27" "$MARK_28" "$MIDI_BYTE_1"
    "$MIDI_BYTE_2" "$MIDI_CHANNEL" "$MIDI_COMMAND" "$MIDI_COMMAND_CC"
    "$MIDI_COMMAND_MONO_AT" "$MIDI_COMMAND_NOTE_OFF" "$MIDI_COMMAND_NOTE_ON"
    "$MIDI_COMMAND_NRPN" "$MIDI_COMMAND_PITCH_BEND" "$MIDI_COMMAND_POLY_AT"
    "$MIDI_COMMAND_PROGRAM_CHANGE" "$MIDI_COMMAND_RPN" "$MOD_TARGET_INVERT_SOURCE"
    "$NI_ASYNC_EXIT_STATUS" "$NI_ASYNC_ID" "$NI_BAR_START_POSITION"
    "$NI_BUS_OFFSET" "$NI_CALLBACK_ID" "$NI_CALLBACK_TYPE"
    "$NI_CB_TYPE_ASYNC_COMPLETE" "$NI_CB_TYPE_CONTROLLER" "$NI_CB_TYPE_INIT"
    "$NI_CB_TYPE_LISTENER" "$NI_CB_TYPE_MIDI_IN" "$NI_CB_TYPE_NOTE"
    "$NI_CB_TYPE_NRPN" "$NI_CB_TYPE_PERSISTENCE_CHANGED" "$NI_CB_TYPE_PGS"
    "$NI_CB_TYPE_POLY_AT" "$NI_CB_TYPE_RELEASE" "$NI_CB_TYPE_RPN"
    "$NI_CB_TYPE_UI_CONTROL" "$NI_CB_TYPE_UI_UPDATE" "$NI_CHORAL_MODE_DIMENSION"
    "$NI_CHORAL_MODE_ENSEMBLE" "$NI_CHORAL_MODE_SYNTH" "$NI_CHORAL_MODE_UNIVERSAL"
    "$NI_COMP_TYPE_CLASSIC" "$NI_COMP_TYPE_ENHANCED" "$NI_COMP_TYPE_PRO"
    "$NI_CONTROL_PAR_IDX" "$NI_DETECT_DRUM_TYPE_CLAP"
    "$NI_DETECT_DRUM_TYPE_CLOSED_HH" "$NI_DETECT_DRUM_TYPE_CYMBAL"
    "$NI_DETECT_DRUM_TYPE_INVALID" "$NI_DETECT_DRUM_TYPE_KICK"
    "$NI_DETECT_DRUM_TYPE_OPEN_HH" "$NI_DETECT_DRUM_TYPE_PERC_DRUM"
    "$NI_DETECT_DRUM_TYPE_PERC_OTHER" "$NI_DETECT_DRUM_TYPE_SHAKER"
    "$NI_DETECT_DRUM_TYPE_SNARE" "$NI_DETECT_DRUM_TYPE_TOM"
    "$NI_DETECT_INSTRUMENT_TYPE_BASS" "$NI_DETECT_INSTRUMENT_TYPE_BOWED_STRING"
    "$NI_DETECT_INSTRUMENT_TYPE_BRASS" "$NI_DETECT_INSTRUMENT_TYPE_FLUTE"
    "$NI_DETECT_INSTRUMENT_TYPE_GUITAR" "$NI_DETECT_INSTRUMENT_TYPE_INVALID"
    "$NI_DETECT_INSTRUMENT_TYPE_KEYBOARD" "$NI_DETECT_INSTRUMENT_TYPE_MALLET"
    "$NI_DETECT_INSTRUMENT_TYPE_ORGAN" "$NI_DETECT_INSTRUMENT_TYPE_PLUCKED_STRING"
    "$NI_DETECT_INSTRUMENT_TYPE_REED" "$NI_DETECT_INSTRUMENT_TYPE_SYNTH"
    "$NI_DETECT_INSTRUMENT_TYPE_VOCAL" "$NI_DETECT_SAMPLE_TYPE_DRUM"
    "$NI_DETECT_SAMPLE_TYPE_INSTRUMENT" "$NI_DETECT_SAMPLE_TYPE_INVALID"
    "$NI_DISTORTION_TYPE_TRANS" "$NI_DISTORTION_TYPE_TUBE"
    "$NI_DND_ACCEPT_MULTIPLE" "$NI_DND_ACCEPT_NONE" "$NI_DND_ACCEPT_ONE"
    "$NI_FILE_EXTENSION" "$NI_FILE_FULL_PATH" "$NI_FILE_FULL_PATH_OS"
    "$NI_FILE_NAME" "$NI_FILE_TYPE_ARRAY" "$NI_FILE_TYPE_AUDIO"
    "$NI_FILE_TYPE_MIDI" "$NI_FLAIR_MODE_SCAN" "$NI_FLAIR_MODE_STANDARD"
    "$NI_FLAIR_MODE_THRU_ZERO" "$NI_FLAIR_SCANMODE_SAW_DOWN"
    "$NI_FLAIR_SCANMODE_SAW_UP" "$NI_FLAIR_SCANMODE_TRIANGLE"
    "$NI_GROUP_PAR_COLOR" "$NI_GROUP_PAR_HIGH_KEY" "$NI_GROUP_PAR_LOW_KEY"
    "$NI_GROUP_PAR_NUM_ZONES" "$NI_INSERT_BUS" "$NI_KEY_TYPE_CONTROL"
    "$NI_KEY_TYPE_DEFAULT" "$NI_KEY_TYPE_NONE" "$NI_KONTAKT_IS_HEADLESS"
    "$NI_LEVEL_METER_GROUP" "$NI_LEVEL_METER_INSERT" "$NI_LEVEL_METER_MAIN"
    "$NI_LOG_MESSAGE" "$NI_LOG_WARNING" "$NI_LOG_WATCHING" "$NI_MAIN_BUS"
    "$NI_MOUSE_EVENT_TYPE" "$NI_MOUSE_EVENT_TYPE_DRAG" "$NI_MOUSE_EVENT_TYPE_DROP"
    "$NI_MOUSE_EVENT_TYPE_LEFT_BUTTON_DOWN" "$NI_MOUSE_EVENT_TYPE_LEFT_BUTTON_UP"
    "$NI_MOUSE_OVER_CONTROL" "$NI_REPLIKA_TYPE_ANALOGUE"
    "$NI_REPLIKA_TYPE_DIFFUSION" "$NI_REPLIKA_TYPE_MODERN" "$NI_REPLIKA_TYPE_TAPE"
    "$NI_REPLIKA_TYPE_VINTAGE" "$NI_REVERB2_TYPE_HALL" "$NI_REVERB2_TYPE_ROOM"
    "$NI_SEND_BUS" "$NI_SHAPE_TYPE_CLASSIC" "$NI_SHAPE_TYPE_DRUMS"
    "$NI_SHAPE_TYPE_ENHANCED" "$NI_SIGNAL_TIMER_BEAT" "$NI_SIGNAL_TIMER_MS"
    "$NI_SIGNAL_TRANSP_START" "$NI_SIGNAL_TRANSP_STOP" "$NI_SIGNAL_TYPE"
    "$NI_SONG_POSITION" "$NI_SUPERGT_CHANNEL_LINK_MODE_DUAL_MONO"
    "$NI_SUPERGT_CHANNEL_LINK_MODE_MS" "$NI_SUPERGT_CHANNEL_LINK_MODE_STEREO"
    "$NI_SUPERGT_CHAR_MODE_BRIGHT" "$NI_SUPERGT_CHAR_MODE_FAT"
    "$NI_SUPERGT_CHAR_MODE_WARM" "$NI_SUPERGT_HPF_MODE_100"
    "$NI_SUPERGT_HPF_MODE_300" "$NI_SUPERGT_HPF_MODE_OFF"
    "$NI_SUPERGT_SAT_MODE_HOT" "$NI_SUPERGT_SAT_MODE_MILD"
    "$NI_SUPERGT_SAT_MODE_MODERATE" "$NI_SYNC_UNIT_16TH"
    "$NI_SYNC_UNIT_16TH_TRIPLET" "$NI_SYNC_UNIT_256TH" "$NI_SYNC_UNIT_32ND"
    "$NI_SYNC_UNIT_32ND_TRIPLET" "$NI_SYNC_UNIT_64TH" "$NI_SYNC_UNIT_64TH_TRIPLET"
    "$NI_SYNC_UNIT_8TH" "$NI_SYNC_UNIT_8TH_TRIPLET" "$NI_SYNC_UNIT_ABS"
    "$NI_SYNC_UNIT_HALF" "$NI_SYNC_UNIT_HALF_TRIPLET" "$NI_SYNC_UNIT_QUARTER"
    "$NI_SYNC_UNIT_QUARTER_TRIPLET" "$NI_SYNC_UNIT_WHOLE"
    "$NI_SYNC_UNIT_WHOLE_TRIPLET" "$NI_SYNC_UNIT_ZONE" "$NI_TRANSPORT_RUNNING"
    "$NI_VL_TMPRO_HQ" "$NI_VL_TMPRO_STANDARD" "$NI_WF_VIS_MODE_1"
    "$NI_WF_VIS_MODE_2" "$NI_WF_VIS_MODE_3" "$NI_WT_FORM_ASYMM"
    "$NI_WT_FORM_ASYMMP" "$NI_WT_FORM_ASYMP" "$NI_WT_FORM_BENDM"
    "$NI_WT_FORM_BENDMP" "$NI_WT_FORM_BENDP" "$NI_WT_FORM_FLIP"
    "$NI_WT_FORM_LINEAR" "$NI_WT_FORM_MIRROR" "$NI_WT_FORM_PWM"
    "$NI_WT_FORM_QUANTIZE" "$NI_WT_FORM_SYNC1" "$NI_WT_FORM_SYNC2"
    "$NI_WT_FORM_SYNC3" "$NI_WT_QUALITY_BEST" "$NI_WT_QUALITY_HIGH"
    "$NI_WT_QUALITY_LOFI" "$NI_WT_QUALITY_MEDIUM" "$NI_WT_VIS_2D" "$NI_WT_VIS_3D"
    "$NOTE_HELD" "$NUM_GROUPS" "$NUM_OUTPUT_CHANNELS" "$NUM_ZONES"
    "$OUTPUT_TYPE_DEFAULT" "$OUTPUT_TYPE_MASTER_OUT" "$OUTPUT_TYPE_AUX_OUT"
    "$OUTPUT_TYPE_BUS_OUT" "$PLAYED_VOICES_INST" "$PLAYED_VOICES_TOTAL"
    "$POLY_AT_NUM" "$REF_GROUP_IDX" "$RPN_ADDRESS" "$RPN_VALUE" "$SIGNATURE_DENOM"
    "$SIGNATURE_NUM" "$START_CRITERIA_AND_NEXT" "$START_CRITERIA_AND_NOT_NEXT"
    "$START_CRITERIA_CYCLE_RANDOM" "$START_CRITERIA_CYCLE_ROUND_ROBIN"
    "$START_CRITERIA_NONE" "$START_CRITERIA_ON_CONTROLLER"
    "$START_CRITERIA_ON_KEY" "$START_CRITERIA_OR_NEXT"
    "$START_CRITERIA_SLICE_TRIGGER" "$UI_WAVEFORM_TABLE_IS_BIPOLAR"
    "$UI_WAVEFORM_USE_MIDI_DRAG" "$UI_WAVEFORM_USE_SLICES"
    "$UI_WAVEFORM_USE_TABLE" "$UI_WF_PROP_FLAGS"
    "$UI_WF_PROP_MIDI_DRAG_START_NOTE" "$UI_WF_PROP_PLAY_CURSOR"
    "$UI_WF_PROP_TABLE_IDX_HIGHLIGHT" "$UI_WF_PROP_TABLE_VAL"
    "$VALUE_EDIT_MODE_NOTE_NAMES" "$VCC_MONO_AT" "$VCC_PITCH_BEND"
    "$ZONE_PAR_FADE_HIGH_KEY" "$ZONE_PAR_FADE_HIGH_VELO" "$ZONE_PAR_FADE_LOW_KEY"
    "$ZONE_PAR_FADE_LOW_VELO" "$ZONE_PAR_GROUP" "$ZONE_PAR_HIGH_KEY"
    "$ZONE_PAR_HIGH_VELO" "$ZONE_PAR_LOW_KEY" "$ZONE_PAR_LOW_VELO" "$ZONE_PAR_PAN"
    "$ZONE_PAR_ROOT_KEY" "$ZONE_PAR_SAMPLE_END" "$ZONE_PAR_SAMPLE_MOD_RANGE"
    "$ZONE_PAR_SAMPLE_START" "$ZONE_PAR_TUNE" "$ZONE_PAR_VOLUME" "%CC"
    "%CC_TOUCHED" "%EVENT_PAR" "%GROUPS_AFFECTED" "%GROUPS_SELECTED" "%KEY_DOWN"
    "%KEY_DOWN_OCT" "%NI_USER_ZONE_IDS" "%NOTE_DURATION" "%POLY_AT"
    "~NI_DETECT_LOUDNESS_INVALID" "~NI_DETECT_PEAK_INVALID"
    "~NI_DETECT_PITCH_INVALID" "~NI_DETECT_RMS_INVALID" "~NI_MATH_E" "~NI_MATH_PI"
    "!NI_DND_ITEMS_ARRAY" "!NI_DND_ITEMS_AUDIO" "!NI_DND_ITEMS_MIDI"))

(defconst ksp-functions
  '("END_USE_CODE" "RESET_CONDITION" "SET_CONDITION" "USE_CODE_IF"
    "USE_CODE_IF_NOT" "_delay_event_for_loading_slots" "_get_engine_par"
    "_get_engine_par_disp" "_get_folder" "_load_ir_sample" "_num_slices"
    "_pgs_create_key" "_pgs_get_key_val" "_pgs_key_exists" "_pgs_set_key_val"
    "_read_persistent_var" "_reset_rls_trig_counter" "_set_engine_par"
    "_set_skin_offset" "_slice_idx_loop_end" "_slice_idx_loop_start"
    "_slice_length" "_slice_loop_count" "_slice_start" "_will_never_terminate"
    "abs" "acos" "add_menu_item" "add_text_line" "allow_group" "array_equal"
    "asin" "atan" "attach_level_meter" "attach_zone" "by_marks" "by_track"
    "cc_delivery_request" "ceil" "change_listener_par" "change_note" "change_pan"
    "change_time_with_pitch" "change_tune" "change_velo" "change_vol" "cos" "dec"
    "delay_event_for_loading_slots" "delete_event_mark" "detect_pitch"
    "detect_rms" "detect_peak" "detect_loudness" "detect_sample_type"
    "detect_instrument_type" "detect_drum_type" "disable_logging" "disallow_group"
    "dont_use_machine_mode" "event_status" "exit" "exp" "fade_in" "fade_out"
    "find_group" "find_mod" "find_target" "find_zone" "floor" "fs_get_filename"
    "fs_navigate" "get_control_par" "get_control_par_arr" "get_control_par_str"
    "get_control_par_str_arr" "get_engine_par" "get_engine_par_disp"
    "get_engine_par_disp_m" "get_engine_par_m" "get_event_ids" "get_event_mark"
    "get_event_par" "get_event_par_arr" "get_folder" "get_font_id" "get_group_par"
    "get_key_color" "get_key_name" "get_key_triggerstate" "get_key_type"
    "get_keyrange_max_note" "get_keyrange_min_note" "get_keyrange_name"
    "get_loop_par" "get_menu_item_str" "get_menu_item_value"
    "get_menu_item_visibility" "get_purge_state" "get_sample" "get_sample_length"
    "get_ui_id" "get_ui_wf_property" "get_voice_limit" "get_zone_par" "group_name"
    "guiidx_to_slotidx" "hide_part" "ignore_controller" "ignore_event"
    "ignore_midi" "import_nckp" "in_range" "inc" "int_to_real" "is_zone_empty"
    "iterate_macro" "literate_macro" "load_array" "load_array_str"
    "load_ir_sample" "load_ir_sample_m" "load_midi_file" "load_patch"
    "load_performance_view" "log" "lsb" "make_instr_persistent" "make_perfview"
    "make_persistent" "message" "mf_copy_export_area" "mf_get_buffer_size"
    "mf_get_byte_one" "mf_get_byte_two" "mf_get_channel" "mf_get_command"
    "mf_get_event_par" "mf_get_first" "mf_get_id" "mf_get_last" "mf_get_length"
    "mf_get_mark" "mf_get_next" "mf_get_next_at" "mf_get_note_length"
    "mf_get_num_tracks" "mf_get_pos" "mf_get_prev" "mf_get_prev_at"
    "mf_get_track_idx" "mf_insert_event" "mf_insert_file" "mf_remove_event"
    "mf_reset" "mf_set_buffer_size" "mf_set_byte_one" "mf_set_byte_two"
    "mf_set_channel" "mf_set_command" "mf_set_event_par" "mf_set_export_area"
    "mf_set_note_length" "mf_set_num_export_areas" "mf_set_length" "mf_set_mark"
    "mf_set_pos" "move_control" "move_control_px" "ms_to_ticks" "msb" "note_off"
    "num_elements" "num_slices" "num_slices_zone" "output_channel_name"
    "pgs_create_key" "pgs_create_str_key" "pgs_get_key_val" "pgs_get_str_key_val"
    "pgs_key_exists" "pgs_set_key_val" "pgs_set_str_key_val" "pgs_str_key_exists"
    "play_note" "pow" "purge_group" "random" "read_persistent_var" "real_to_int"
    "redirect_midi" "redirect_output" "remove_keyrange" "reset_engine"
    "reset_ksp_timer" "reset_rls_trig_counter" "round" "save_array"
    "save_array_str" "save_midi_file" "search" "set_bounds"
    "set_button_properties" "set_control_help" "set_control_par"
    "set_control_par_arr" "set_control_par_str" "set_control_par_str_arr"
    "set_controller" "set_engine_par" "set_engine_par_m" "set_event_mark"
    "set_event_par" "set_event_par_arr" "set_group_dyn_par_name" "set_key_color"
    "set_key_name" "set_key_pressed" "set_key_pressed_support" "set_key_type"
    "set_keyrange" "set_knob_defval" "set_knob_label" "set_knob_properties"
    "set_knob_unit" "set_label_properties" "set_level_meter_properties"
    "set_listener" "set_loop_par" "set_menu_item_str" "set_menu_item_value"
    "set_menu_item_visibility" "set_menu_properties" "set_midi" "set_nrpn"
    "set_num_user_zones" "set_rpn" "set_sample" "set_script_title"
    "set_skin_offset" "set_slider_properties" "set_snapshot_type"
    "set_switch_properties" "set_table_properties" "set_table_steps_shown"
    "set_text" "set_text_edit_properties" "set_ui_color" "set_ui_height"
    "set_ui_height_px" "set_ui_wf_property" "set_ui_width_px"
    "set_value_edit_properties" "set_voice_limit" "set_waveform_properties"
    "set_wavetable2d_properties" "set_wavetable3d_properties" "set_zone_par"
    "sh_left" "sh_right" "show_library_tab" "sin" "slice_idx_loop_end"
    "slice_idx_loop_start" "slice_length" "slice_loop_count" "slice_start"
    "slotidx_to_guiidx" "sort" "sqrt" "stop_wait" "tan" "ticks_to_ms"
    "unload_slot" "wait" "wait_async" "watch_var" "watch_array_idx" "wait_ticks"
    "will_never_terminate" "zone_slice_idx_loop_end" "zone_slice_idx_loop_start"
    "zone_slice_length" "zone_slice_loop_count" "zone_slice_start"))

(defconst ksp-keywords
  '("_pgs_changed" "and" "as" "call" "case" "const" "controller" "declare"
    "downto" "else" "end" "end family" "end for" "end function" "end if"
    "end macro" "end on" "end_on" "end property" "end select" "end taskfunc"
    "end while" "family" "for" "function" "if" "import" "init" "macro"
    "midi_in" "not" "note" "nrpn" "on" "on async_complete" "on controller"
    "on init" "on listener" "on midi_in" "on note" "on nrpn"
    "on persistence_changed" "on pgs_changed" "on_pgs_changed" "on poly_at"
    "on release" "on rpn" "on ui_control" "on ui_update" "or" "out" "override"
    "pgs_changed" "poly_at" "property" "release" "rpn" "select"
    "step" "taskfunc" "to" "ui_control" "ui_update" "var" "while"))

(defun ksp-regexp-opt (keywords)
  "Make an optimized regexp from the list of KEYWORDS."
  (regexp-opt keywords 'symbols))

(defvar ksp-font-lock-keywords
  `((,(ksp-regexp-opt ksp-functions) . font-lock-function-name-face)
    (,(ksp-regexp-opt ksp-keywords)  . font-lock-keyword-face)
    (,(ksp-regexp-opt ksp-variables) . font-lock-type-face)))

(defvar ksp-mode-map (make-sparse-keymap)
  "Keymap for ksp-mode.")

;;;###autoload
(define-derived-mode ksp-mode prog-mode "KSP"
  "Major mode for editing ksp files"
  :group 'ksp-mode
  :syntax-table ksp-mode-syntax-table

  (setq-local indent-tabs-mode nil)
  (setq-local tab-width 4)
  (setq-local comment-start "// ")
  (setq-local comment-end "")
  (setq-local comment-start-skip "// *")
  (setq-local font-lock-defaults '(ksp-font-lock-keywords)))

;;;###autoload
(add-to-list 'auto-mode-alist '("\\.ksp\\'" . ksp-mode))

(provide 'ksp-mode)
;;; ksp-mode.el ends here
