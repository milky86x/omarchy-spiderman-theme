#!/bin/bash
# Build a clean Spider-Man theme preview thumbnail.
set -euo pipefail

W=1920 H=1080
OUT="/home/milky86x/Pictures/spiderman-theme-preview.png"

BG_DARK="#0d0d16"
BG_SIDEBAR="#0a0a12"
RED="#e23636"
BLUE="#1f3a93"
FG="#eceff4"
MUTED="#4c566a"
BORDER="#23232f"

FONT_B="/usr/share/fonts/liberation/LiberationSans-Bold.ttf"
FONT_R="/usr/share/fonts/liberation/LiberationSans-Regular.ttf"
FONT_M="/usr/share/fonts/liberation/LiberationMono-Regular.ttf"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT

REPO="/home/milky86x/Work/omarchy-spiderman-theme"
ICON="$REPO/icon-theme/Spider-Man-Red"

# --- Base desktop: wallpaper resized/cropped to fill ---
magick "$REPO/backgrounds/spider-man-dark-red-minimal-3840x2160-167.jpg" \
  -resize "${W}x${H}^" -gravity center -extent ${W}x${H} "$TMP/wall.jpg"
magick "$TMP/wall.jpg" -fill "rgba(13,13,22,0.22)" -draw "rectangle 0,0 $W,$H" "$TMP/wall.jpg"

# --- Top status bar ---
magick -size ${W}x48 xc:"#0d0d16" "$TMP/bar.png"
magick "$TMP/bar.png" -fill "$RED" -font "$FONT_B" -pointsize 20 -annotate +20+32 "  Weba" \
  -fill "$FG" -annotate +200+32 "spiderman" \
  "$TMP/bar.png"

# --- Terminal window ---
TERM_W=880 TERM_H=470 TERM_X=60 TERM_Y=90
magick -size ${TERM_W}x${TERM_H} xc:"$BG_DARK" "$TMP/term.png"
magick "$TMP/term.png" -fill "#1a1a28" -draw "rectangle 0,0 $TERM_W,44" \
  -fill "$FG" -font "$FONT_R" -pointsize 17 -annotate +16+28 " ~/Projects/spiderman-theme" \
  -fill "#3a3a4c" -draw "circle $((TERM_W-110)),22  $((TERM_W-110)),26" \
  -draw "circle $((TERM_W-80)),22  $((TERM_W-80)),26" \
  -fill "$RED" -draw "circle $((TERM_W-50)),22  $((TERM_W-50)),27" \
  "$TMP/term.png"

magick "$TMP/term.png" \
  -font "$FONT_M" -pointsize 19 \
  -fill "$RED" -annotate +28+100 "milky86x@omarchy:~$" \
  -fill "$FG" -annotate +250+100 " omarchy theme set spiderman" \
  -fill "$MUTED" -annotate +28+132 "Applying Spider-Man theme..." \
  -fill "$FG" -annotate +28+164 "  colors.toml            [OK]" \
  -fill "$FG" -annotate +28+196 "  backgrounds/           [OK]" \
  -fill "$FG" -annotate +28+228 "  icons (red folders)    [OK]" \
  -fill "$RED" -annotate +28+262 "Spider-Man desktop ready" \
  "$TMP/term.png"

# --- Nautilus / file manager window ---
FM_W=880 FM_H=720 FM_X=980 FM_Y=240
magick -size ${FM_W}x${FM_H} xc:"$BG_DARK" "$TMP/fm.png"
magick "$TMP/fm.png" -fill "#11111c" -draw "rectangle 0,0 $FM_W,56" \
  -fill "$FG" -font "$FONT_R" -pointsize 18 -annotate +28+36 " Files - Home" \
  -fill "#2a2a3c" -draw "roundrectangle 340,10 700,46 6,6" \
  -fill "$MUTED" -draw "text 356,33 'Search'" \
  "$TMP/fm.png"
magick "$TMP/fm.png" -fill "$BG_SIDEBAR" -draw "rectangle 0,56 260,$FM_H" \
  -fill "$RED" -draw "roundrectangle 8,80 252,126 8,8" \
  -fill "$FG" -font "$FONT_B" -pointsize 16 -annotate +24+106 "  Home" \
  -fill "$FG" -font "$FONT_R" -pointsize 15 \
  -annotate +24+158 "  Documents" \
  -annotate +24+202 "  Downloads" \
  -annotate +24+246 "  Pictures" \
  -annotate +24+290 "  Music" \
  -annotate +24+334 "  Videos" \
  "$TMP/fm.png"

FOLDER_ICON="$ICON/48x48/places/folder.png"
magick "$FOLDER_ICON" -resize 72x72 "$TMP/f1.png"
FOLDERX=320 FOLDERY=130 SPACEX=130 SPACEY=170
labels=("Projects" "Documents" "Downloads" "Pictures" "Videos" "Music")
for i in 0 1 2 3 4 5; do
  cx=$(( FOLDERX + (i % 3) * SPACEX ))
  cy=$(( FOLDERY + (i / 3) * SPACEY ))
  magick "$TMP/fm.png" "$TMP/f1.png" -geometry +${cx}+${cy} -composite "$TMP/fm.png"
  magick "$TMP/fm.png" -fill "$FG" -font "$FONT_R" -pointsize 15 \
    -annotate +${cx}+$((cy+90)) "${labels[$i]}" "$TMP/fm.png"
done

# --- Root composite ---
magick -size ${W}x${H} xc:"$BG_DARK" "$TMP/root.png"
magick "$TMP/root.png" "$TMP/wall.jpg" -composite "$TMP/root.png"
magick "$TMP/root.png" "$TMP/bar.png" -geometry +0+0 -composite "$TMP/root.png"
magick "$TMP/root.png" "$TMP/term.png" -geometry +${TERM_X}+${TERM_Y} -composite "$TMP/root.png"
magick "$TMP/root.png" "$TMP/fm.png" -geometry +${FM_X}+${FM_Y} -composite "$TMP/root.png"

# --- Title banner at bottom ---
magick "$TMP/root.png" \
  -fill "rgba(13,13,22,0.75)" -draw "rectangle 0,$((H-90)) $W,$H" \
  -fill "$FG" -font "$FONT_R" -pointsize 24 -annotate +40+$((H-30)) "for Omarchy" \
  -fill "$RED" -font "$FONT_B" -pointsize 44 -annotate +40+$((H-62)) "Spider-Man" \
  "$TMP/root.png"

cp "$TMP/root.png" "$OUT"
echo "Saved $OUT"
file "$OUT"