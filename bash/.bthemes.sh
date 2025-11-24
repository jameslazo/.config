#---PROMPT---#
# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|xterm-kitty) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#---THEMES---#
# Git status parser
parse_git() {
  local br_name
  if br_name=$(git symbolic-ref --short -q HEAD 2>/dev/null); then
    local git_stat=""
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      git_stat="*"
    fi
    echo -e "\e[${theme_dir}m:\e[${theme_git}m${br_name}${git_stat}"
  fi
}

# Theme, syntax formatting and export
bash_theme() {
  # Themes provided with descriptive color names
  local oasis=(
    214_orange1
    202_orangered1
    037_lightseagreen
    108_darkseagreen
    068_steelblue3
    130_darkorange3
    132_dusty_pink
    223_navajowhite1
  )

  local eighties=(
    118_chartreuse1
    086_aquamarine1
    201_magenta1
    108_darkseagreen
    068_steelblue3
    029_springgreen4
    132_dusty_pink
    225_thistle1
  )

  local lightning=(
  240_grey35
  226_yellow1
  196_red1
  108_darkseagreen
  068_steelblue3
  136_darkgoldenrod
  132_dusty_pink
  229_wheat
  )

  local monochrome=(
  250_grey75
  240_grey35
  231_white
  108_darkseagreen
  068_steelblue3
  250_grey75
  132_dusty_pink
  253_grey8
  )

  local sweetsixteen=(
  010_16green
  012_16blue
  014_16cyan
  011_16yellow
  013_16magenta
  008_16grey
  003_16darkyellow
  007_16offwhite
  )

  # Set theme with theme=("${themename[@]}")
  local theme_var=()
  local th_fg='38;5;'
  local th_bg='48;5;'
  if [[ -z $theme_var ]]; then
    theme_var=("${oasis[@]}")
  fi

  for i in "${theme_var[@]}";
    do local theme+=("38;5;${i%%_*}")
  done

  # Vars - strip descriptive color names
  local mk_col='\[\e['
  local rm_col='m\]'
  local login="${theme[0]}"
  theme_dir="${theme[1]}"
  theme_git="${theme[2]}"
  local execute="${theme[3]}"
  local link="${theme[4]}"
  local backup="${theme[5]}"
  local conf="${theme[6]}"
  local neutral="${theme[7]}"

  # Export vars
  export PS1="$mk_col$login$rm_col\u$mk_col$theme_dir$rm_col@$mk_col$login$rm_col\H$mk_col$login$rm_col $mk_col$theme_dir$rm_col\w\$(parse_git)$mk_col$neutral$rm_col> "

  export LS_COLORS="rs=0:no=$neutral:ow=$neutral:di=01;$theme_dir:ex=$execute:ln=$link:*.bak=$backup:*~=$backup:*.conf=$conf:"
}

# Apply theme
bash_theme

#---DARK-MODE---#
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark

#---XTERM COLORS---#
#000_16black
#001_16maroon
#002_16darkgreen
#003_16darkyellow
#004_16darkblue
#005_16darkmagenta
#006_16darkcyan
#007_16offwhite
#008_16grey
#009_16red
#010_16green
#011_16yellow
#012_16blue
#013_16magenta
#014_16cyan
#015_16white
#016_black
#017_navy_blue
#018_deep_maroon
#019_rich_purple
#020_deep_indigo
#021_dark_violet
#022_dark_green
#023_teal
#024_deep_sky_blue
#025_royal_blue
#026_sky_blue
#027_electric_blue
#028_medium_green
#029_springgreen4
#030_dark_cyan
#031_medium_turquoise
#032_cerulean
#033_bright_azure
#034_bright_green
#035_medium_sea_green
#036_cyan_blue
#037_lightseagreen
#038_bright_sky
#039_neon_blue
#040_lime_green
#041_spring_green
#042_aquamarine
#043_light_aqua
#044_clear_blue
#045_light_sky
#046_neon_green
#047_light_green
#048_light_cyan
#049_ice_blue
#050_light_blue
#051_glacial_blue
#052_maroon
#053_charcoal
#054_muted_purple
#055_soft_indigo
#056_deep_lavender
#057_soft_purple
#058_dark_olive
#059_dull_green
#060_slate_blue
#061_steel_blue
#062_dusty_blue
#063_bluebell
#064_chartreuse4
#065_gray_green
#066_soft_teal
#067_blue_gray
#068_steelblue3
#069_powder_blue
#070_yellow_green
#071_soft_green
#072_blue_green
#073_turquoise_blue
#074_muted_blue
#075_arctic_blue
#076_muted_blue
#077_mint_green
#078_light_teal
#079_aquamarine3
#080_soft_blue
#081_steelblue1
#082_chartreuse2
#083_pastel_green
#084_pale_turquoise
#085_frost_blue
#086_aquamarine1
#087_cyan
#088_pure_red
#089_deeppink4
#090_vivid_purple
#091_rich_magenta
#092_vibrant_magenta
#093_pure_purple
#094_dark_red
#095_muted_red
#096_deep_pink
#097_mulberry
#098_deep_purple
#099_deep_lilac
#100_goldenrod
#101_warm_brown
#102_faded_rose
#103_grayish_purple
#104_muted_violet
#105_pale_violet1
#106_deep_amber
#107_faded_gold
#108_darkseagreen
#109_dull_blue
#110_dusty_periwinkle
#111_lavender
#112_dark_gold
#113_burnt_olive
#114_warm_gray
#115_muted_cyan
#116_frosty_lavender
#117_soft_lilac
#118_chartreuse1
#119_dried_moss
#120_light_sage
#121_faded_mint
#122_cool_gray
#123_light_periwinkle
#124_dusky_red
#125_warm_red
#126_dull_maroon
#127_subtle_magenta
#128_dim_magenta
#129_muted_fuchsia
#130_darkorange3
#131_warm_tan
#132_dusky_pink
#133_pastel_purple
#134_pastel_purple
#135_soft_magenta1
#136_darkgoldenrod
#137_bronzed_yellow
#138_muted_amber
#139_grayish_green
#140_silver_blue
#141_mauve
#142_muted_chartreuse
#143_soft_gold
#144_earthy_green
#145_faded_green
#146_light_gray_blue
#147_faded_periwinkle
#148_bright_chartreuse
#149_faint_yellow
#150_soft_turquoise
#151_warm_mint
#152_washed_turquoise
#153_icy_lavender
#154_neon_yellow
#155_pale_chartreuse
#156_palegreen1
#157_soft_mint
#158_misty_mint
#159_pale_turquoise
#160_crimson
#161_intense_red
#162_hot_pink
#163_neon_pink
#164_intense_pink
#165_intense_magenta
#166_tangerine
#167_bright_crimson
#168_deep_rose
#169_bold_magenta
#170_vibrant_fuchsia
#171_bright_magenta
#172_orange_gold
#173_burnt_red
#174_warm_rose
#175_muted_magenta
#176_warm_violet
#177_electric_purple
#178_warm_yellow
#179_copper
#180_dusty_magenta
#181_dusty_magenta
#182_pale_violet2
#183_soft_periwinkle
#184_gold
#185_faded_coral
#186_soft_blush
#187_faded_fuchsia
#188_light_lavender
#189_warm_periwinkle
#190_bright_yellow
#191_dusky_coral
#192_faded_blush
#193_light_fuchsia
#194_faint_lavender
#195_cool_periwinkle
#196_red1
#197_bright_pink
#198_hot_magenta
#199_deep_fuchsia
#200_soft_magenta2
#201_magenta1
#202_orangered1
#203_faded_salmon
#204_misty_rose
#205_faint_magenta
#206_frosted_magenta
#207_bright_pink
#208_darkorange
#209_warm_apricot
#210_faint_rose
#211_soft_fuchsia
#212_dusty_pink
#213_light_magenta
#214_orange1
#215_soft_orange
#216_mild_apricot
#217_pale_fuchsia
#218_warm_white
#219_pastel_pink
#220_pure_yellow
#221_peach
#222_soft_peach
#223_navajowhite1
#224_off_white
#225_thistle1
#226_yellow1
#227_warm_peach
#228_pastel_blush
#229_pastel_fuchsia
#229_wheat1
#230_cornsilk1
#231_white
#232_grey3
#233_grey7
#234_grey11
#235_grey15
#236_grey19
#237_grey23
#238_grey27
#239_grey31
#240_grey35
#241_grey39
#242_grey43
#243_grey47
#244_grey51
#245_grey55
#246_grey59
#247_grey63
#248_grey67
#249_grey71
#250_grey75
#251_grey79
#252_grey83
#253_grey87
#254_grey91
#255_grey95

