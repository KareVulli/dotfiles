#!/usr/bin/bash
# =====================================================
# -----------------------------------------------------
# Gather the current keybinds from hyprctl,
# and open a rofi menu to search/execute them.
#    Jason Bradberry (2025)
# -----------------------------------------------------
# =====================================================

binds_file="$HOME/.config/.settings/hyprbinds.json"

key_m="Super"

# Function to map modmask values to strings
map_modmask() {
  case "$1" in
  0) echo "(NONE)" ;;
  1) echo "Shift" ;;
  4) echo "Ctrl" ;;
  5) echo "Ctrl-Shift" ;;
  8) echo "Alt" ;;
  12) echo "Ctrl-Alt" ;;
  13*) echo "MEH(C-A-S)" ;;
  64) echo "$key_m" ;;
  65) echo "$key_m-Shift" ;;
  68) echo "$key_m-Ctrl" ;;
  72) echo "$key_m-Alt" ;;
  *) echo "Unknown: $1" ;;
  esac
}

# Get JSON output from hyprctl
json_output=$(hyprctl binds -j)

# Process JSON: Convert modmask values using a loop
updated_json=$(echo "$json_output" | jq -c '.[]' | while read -r bind; do
  modmask_value=$(echo "$bind" | jq -r '.modmask')
  modmask_str=$(map_modmask "$modmask_value")
  echo "$bind" | jq --arg modmask_str "$modmask_str" '.modmask = $modmask_str'
done | jq -s '.')

# Filter JSON entries based on criteria
filtered_entries=$(echo $updated_json | jq -r '.[] | select(.submap == "" and .dispatcher != "submap") | 
    "\(.modmask)-\(.key) \"\(.description)\": \(.dispatcher) \(.arg)"')

# Show options in rofi and get user selection
selected=$(echo "$filtered_entries" | rofi -dmenu -p 'keybinds')

# Extract dispatcher and arg from the selected entry
dispatcher=$(echo "$selected" | sed -E 's/.*: ([^ ]+) .*/\1/')
arg=$(echo "$selected" | sed -E 's/.*: [^ ]+ (.*)/\1/')

# Debugging output
echo "debug: dispatcher='$dispatcher', arg='$arg'"

# Execute the selected command
if [ -n "$dispatcher" ] && [ -n "$arg" ]; then
  hyprctl dispatch "$dispatcher" "$arg"
else
  echo "Invalid selection or missing arguments"
fi
