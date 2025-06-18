#\\\\\\\\\\\\#
#\\\COLORS\\\#
#\\\\\\\\\\\\#
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


#\\\\\\\\\\\\#
#\\\THEMES\\\#
#\\\\\\\\\\\\#

# Theme names: oasis (default),eighties,lightning,monochrome,sweetsixteen
export BASH_THEME=

# Git context
function parse_git {
  local branch
  if branch=$(git symbolic-ref --short -q HEAD 2>/dev/null); then
    local status=""
    if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
      status="*"
    fi
    echo -e "\033[${fg}${directory}m:\033[${fg}${git}m${branch}${status}"
  fi
}

# Theme
bash_theme() {
  if [ -z "$BASH_THEME" ]; then
    export BASH_THEME=oasis
  fi

  case "$BASH_THEME" in
    "oasis")
      login="${color_map[orange1]}"
      directory="${color_map[orangered1]}"
      git="${color_map[lightseagreen]}"
      execute="${color_map[palegreen1]}"
      link="${color_map[steelblue3]}"
      backup="${color_map[darkorange3]}"
      conf="${color_map[deeppink4]}"
      neutral="${color_map[navajowhite1]}"
      ;;
    "eighties")
      login="${color_map[chartreuse1]}"
      directory="${color_map[aquamarine1]}"
      git="${color_map[magenta1]}"
      execute="${color_map[palegreen1]}"
      link="${color_map[steelblue3]}"
      backup="${color_map[springgreen4]}"
      conf="${color_map[deeppink4]}"
      neutral="${color_map[thistle1]}"
      ;;
    "lightning")
      login="${color_map[grey35]}"
      directory="${color_map[yellow1]}"
      git="${color_map[red1]}"
      execute="${color_map[palegreen1]}"
      link="${color_map[steelblue3]}"
      backup="${color_map[darkgoldenrod]}"
      conf="${color_map[deeppink4]}"
      neutral="${color_map[wheat1]}"
      ;;
    "monochrome")
      login="${color_map[grey75]}"
      directory="${color_map[grey35]}"
      git="${color_map[white]}"
      execute="${color_map[palegreen1]}"
      link="${color_map[steelblue3]}"
      backup="${color_map[grey75]}"
      conf="${color_map[deeppink4]}"
      neutral="${color_map[grey87]}"
      ;;
    "sweetsixteen")
      login="${color_map[16green]}"
      directory="${color_map[16blue]}"
      git="${color_map[16cyan]}"
      execute="${color_map[16yellow]}"
      link="${color_map[16magenta]}"
      backup="${color_map[16grey]}"
      conf="${color_map[16darkyellow]}"
      neutral="${color_map[16offwhite]}"
      ;;
    *)
      echo "$BASH_THEME theme not found, applying oasis theme"
      login="${color_map[orange1]}"
      directory="${color_map[orangered1]}"
      git="${color_map[lightseagreen]}"
      execute="${color_map[palegreen1]}"
      link="${color_map[steelblue3]}"
      backup="${color_map[darkorange3]}"
      conf="${color_map[deeppink4]}"
      neutral="${color_map[navajowhite1]}"
      ;;
  esac
  export PS1='${debian_chroot:+($debian_chroot)}\[\033[${fg}${login}m\]\u@\h\[\033[${fg}${login}m\]:\[\033[${fg}${directory}m\]\w$(parse_git)\[\033[${fg}${neutral}m\]> '
  export LS_COLORS="rs=0:no=${fg}${neutral}:ow=${fg}${neutral}:di=01;${fg}${directory}:ex=${fg}${execute}:ln=${fg}${link}:*.bak=${fg}${backup}:*~=${fg}${backup}:*.conf=${fg}${conf}:"
}


#\\\\\\\\\\\\\\\\\\#
#\\\XTERM\COLORS\\\#
#\\\\\\\\\\\\\\\\\\#
declare -A color_map

color_map=(
  [16black]=000
  [16maroon]=001
  [16darkgreen]=002
  [16darkyellow]=003
  [16darkblue]=004
  [16darkmagenta]=005
  [16darkcyan]=006
  [16offwhite]=007
  [16grey]=008
  [16red]=009
  [16green]=010
  [16yellow]=011
  [16blue]=012
  [16magenta]=013
  [16cyan]=014
  [16white]=015
  [black]=016
  [navy_blue]=017
  [deep_maroon]=018
  [rich_purple]=019
  [deep_indigo]=020
  [dark_violet]=021
  [dark_green]=022
  [teal]=023
  [deep_sky_blue]=024
  [royal_blue]=025
  [sky_blue]=026
  [electric_blue]=027
  [medium_green]=028
  [springgreen4]=029
  [dark_cyan]=030
  [medium_turquoise]=031
  [cerulean]=032
  [bright_azure]=033
  [bright_green]=034
  [medium_sea_green]=035
  [cyan_blue]=036
  [lightseagreen]=037
  [bright_sky]=038
  [neon_blue]=039
  [lime_green]=040
  [spring_green]=041
  [aquamarine]=042
  [light_aqua]=043
  [clear_blue]=044
  [light_sky]=045
  [neon_green]=046
  [light_green]=047
  [light_cyan]=048
  [ice_blue]=049
  [light_blue]=050
  [glacial_blue]=051
  [maroon]=052
  [charcoal]=053
  [muted_purple]=054
  [soft_indigo]=055
  [deep_lavender]=056
  [soft_purple]=057
  [dark_olive]=058
  [dull_green]=059
  [slate_blue]=060
  [steel_blue]=061
  [dusty_blue]=062
  [bluebell]=063
  [chartreuse4]=064
  [gray_green]=065
  [soft_teal]=066
  [blue_gray]=067
  [steelblue3]=068
  [powder_blue]=069
  [yellow_green]=070
  [soft_green]=071
  [blue_green]=072
  [turquoise_blue]=073
  [muted_blue]=074
  [arctic_blue]=075
  [muted_blue]=076
  [mint_green]=077
  [light_teal]=078
  [aquamarine3]=079
  [soft_blue]=080
  [steelblue1]=081
  [chartreuse2]=082
  [pastel_green]=083
  [pale_turquoise]=084
  [frost_blue]=085
  [aquamarine1]=086
  [cyan]=087
  [pure_red]=088
  [deeppink4]=089
  [vivid_purple]=090
  [rich_magenta]=091
  [vibrant_magenta]=092
  [pure_purple]=093
  [dark_red]=094
  [muted_red]=095
  [deep_pink]=096
  [mulberry]=097
  [deep_purple]=098
  [deep_lilac]=099
  [goldenrod]=100
  [warm_brown]=101
  [faded_rose]=102
  [grayish_purple]=103
  [muted_violet]=104
  [pale_violet1]=105
  [deep_amber]=106
  [faded_gold]=107
  [soft_gray]=108
  [dull_blue]=109
  [dusty_periwinkle]=110
  [lavender]=111
  [dark_gold]=112
  [burnt_olive]=113
  [warm_gray]=114
  [muted_cyan]=115
  [frosty_lavender]=116
  [soft_lilac]=117
  [chartreuse1]=118
  [dried_moss]=119
  [light_sage]=120
  [faded_mint]=121
  [cool_gray]=122
  [light_periwinkle]=123
  [dusky_red]=124
  [warm_red]=125
  [dull_maroon]=126
  [subtle_magenta]=127
  [dim_magenta]=128
  [muted_fuchsia]=129
  [darkorange3]=130
  [warm_tan]=131
  [dusky_pink]=132
  [pastel_purple]=133
  [pastel_purple]=134
  [soft_magenta1]=135
  [darkgoldenrod]=136
  [bronzed_yellow]=137
  [muted_amber]=138
  [grayish_green]=139
  [silver_blue]=140
  [mauve]=141
  [muted_chartreuse]=142
  [soft_gold]=143
  [earthy_green]=144
  [faded_green]=145
  [light_gray_blue]=146
  [faded_periwinkle]=147
  [bright_chartreuse]=148
  [faint_yellow]=149
  [soft_turquoise]=150
  [warm_mint]=151
  [washed_turquoise]=152
  [icy_lavender]=153
  [neon_yellow]=154
  [pale_chartreuse]=155
  [palegreen1]=156
  [soft_mint]=157
  [misty_mint]=158
  [pale_turquoise]=159
  [crimson]=160
  [intense_red]=161
  [hot_pink]=162
  [neon_pink]=163
  [intense_pink]=164
  [intense_magenta]=165
  [tangerine]=166
  [bright_crimson]=167
  [deep_rose]=168
  [bold_magenta]=169
  [vibrant_fuchsia]=170
  [bright_magenta]=171
  [orange_gold]=172
  [burnt_red]=173
  [warm_rose]=174
  [muted_magenta]=175
  [warm_violet]=176
  [electric_purple]=177
  [warm_yellow]=178
  [copper]=179
  [dusty_magenta]=180
  [dusty_magenta]=181
  [pale_violet2]=182
  [soft_periwinkle]=183
  [gold]=184
  [faded_coral]=185
  [soft_blush]=186
  [faded_fuchsia]=187
  [light_lavender]=188
  [warm_periwinkle]=189
  [bright_yellow]=190
  [dusky_coral]=191
  [faded_blush]=192
  [light_fuchsia]=193
  [faint_lavender]=194
  [cool_periwinkle]=195
  [red1]=196
  [bright_pink]=197
  [hot_magenta]=198
  [deep_fuchsia]=199
  [soft_magenta2]=200
  [magenta1]=201
  [orangered1]=202
  [faded_salmon]=203
  [misty_rose]=204
  [faint_magenta]=205
  [frosted_magenta]=206
  [bright_pink]=207
  [darkorange]=208
  [warm_apricot]=209
  [faint_rose]=210
  [soft_fuchsia]=211
  [dusty_pink]=212
  [light_magenta]=213
  [orange1]=214
  [soft_orange]=215
  [mild_apricot]=216
  [pale_fuchsia]=217
  [warm_white]=218
  [pastel_pink]=219
  [pure_yellow]=220
  [peach]=221
  [soft_peach]=222
  [navajowhite1]=223
  [off_white]=224
  [thistle1]=225
  [yellow1]=226
  [warm_peach]=227
  [pastel_blush]=228
  [pastel_fuchsia]=229
  [wheat1]=229
  [cornsilk1]=230
  [white]=231
  [grey3]=232
  [grey7]=233
  [grey11]=234
  [grey15]=235
  [grey19]=236
  [grey23]=237
  [grey27]=238
  [grey31]=239
  [grey35]=240
  [grey39]=241
  [grey43]=242
  [grey47]=243
  [grey51]=244
  [grey55]=245
  [grey59]=246
  [grey63]=247
  [grey67]=248
  [grey71]=249
  [grey75]=250
  [grey79]=251
  [grey83]=252
  [grey87]=253
  [grey91]=254
  [grey95]=255
)

# Simplify xterm color code
fg='38;5;'
bg='48;5;'

# Apply theme
bash_theme
#------------#

#\\\\\\\\\\\\\\\#
#\\\DARK\MODE\\\#
#\\\\\\\\\\\\\\\#
export GTK_THEME=Adwaita:dark
export GTK2_RC_FILES=/usr/share/themes/Adwaita-dark/gtk-2.0/gtkrc
export QT_STYLE_OVERRIDE=Adwaita-Dark
#---------------#

