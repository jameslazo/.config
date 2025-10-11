#!/bin/bash

# --- CONFIGURATION ---
readonly CACHE_DIR="$HOME/.cache/colorpicker"
readonly COLOR_LIST="$CACHE_DIR/colors"
readonly COLOR_LIMIT=10
# hyprpicker sends the signal to waybar to refresh custom modules

# --- UTILITY FUNCTIONS ---
check() {
  command -v "$1" &>/dev/null
}

notify() {
  # Check for wal colors if available, otherwise use a generic icon
  local icon
  if check notify-send; then
    source "$HOME/.config/wal/colors.sh" 2>/dev/null
    icon=${wallpaper:-"dialog-information"}
    notify-send "Color Picker" "$1" -i "$icon"
  fi
}

# --- INITIAL SETUP & CLEANUP ---
mkdir -p "$CACHE_DIR"
touch "$COLOR_LIST"

# **FIX:** Deduplicate, clean, and format the list using a temporary file.
cleanup_palette() {
  if [[ -s "$COLOR_LIST" ]]; then # Check if the file is not empty
    local temp_list
    temp_list=$(mktemp)
    # 1. Read the list.
    # 2. Convert to uppercase (tr '[:lower:]' '[:upper:]').
    # 3. Deduplicate consecutive lines (uniq).
    # 4. Filter empty lines (grep -v '^$').
    # 5. Take the top $COLOR_LIMIT lines (head).
    # 6. Write the cleaned list to the temporary file.
    # 7. Overwrite the original file with the cleaned list.
    cat "$COLOR_LIST" | 
    tr '[:lower:]' '[:upper:]' | 
    grep -v '^$' | 
    uniq | 
    head -n "$COLOR_LIMIT" > "$temp_list"
    mv "$temp_list" "$COLOR_LIST"
  fi
}

# Ensure the list is clean before the script runs or on startup
cleanup_palette

# --- EXECUTION MODES ---

# Option -l: List colors for debugging/other scripts (UNCHANGED)
if [[ $# -eq 1 && $1 == "-l" ]]; then
# ... (same as before) ...
  exit 0
fi

# Option -j: JSON output for Waybar custom module (REVISED)
if [[ $# -eq 1 && $1 == "-j" ]]; then
    # Read all colors into an array, ignoring potential empty lines
    mapfile -t all_colors < <(grep -v '^$' "$COLOR_LIST")
    
    # Use the first color as the main display color
    current_color="${all_colors[0]:-FFD7AF}" # Default to white if list is empty
    
    # Build the tooltip
    tooltip="<b>   COLORS</b>\n\n"
    
    # 1. Add the most recent color to the top of the tooltip
    tooltip+="-> <b>$current_color</b>  <span color='$current_color'></span>  \n"

    # 2. Loop through all *other* colors for the rest of the tooltip body
    for (( i=1; i<${#all_colors[@]}; i++ )); do
        color="${all_colors[$i]}"
        tooltip+="   <b>$color</b>  <span color='$color'></span>  \n"
    done

    # JSON output for Waybar
    cat <<EOF
{ "text":"<span color='$current_color'>󰙒</span>", "tooltip":"$tooltip"}
EOF
    exit 0
fi

# --- MAIN COLOR PICKING LOGIC ---

# 1. Check dependencies
check hyprpicker || {
  notify "hyprpicker is not installed"
  exit 1
}

# 2. Pick color
killall -q hyprpicker # Ensure any previous instance is stopped
color=$(hyprpicker | grep '#')

# Exit if no valid color was picked (e.g., user cancelled)
if [[ -z "$color" ]]; then
  exit 0
fi

# 3. Copy color (converted to uppercase for uniformity)
color_uc=$(echo "$color" | tr '[:lower:]' '[:upper:]' | sed -z 's/\n//g')
check wl-copy && {
  echo "$color_uc" | wl-copy
}

# 4. Update the color list (REVISED)
# Read current list, prepend the new color, clean, and write back
{
  echo "$color_uc"  # 1. Prepend the new, uppercase color
  cat "$COLOR_LIST" # 2. Append the current list
} | tr '[:lower:]' '[:upper:]' | grep -v '^$' | head -n "$((COLOR_LIMIT + 1))" | awk '!seen[$0]++' > "$COLOR_LIST.tmp"
mv "$COLOR_LIST.tmp" "$COLOR_LIST"

# 5. Notify and Refresh Waybar (UNCHANGED)
notify "Copied color: $color_uc"
pkill -RTMIN+1 waybar

