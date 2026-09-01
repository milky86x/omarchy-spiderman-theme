#!/bin/bash
# Build the Spider-Man-Red icon theme inside the spiderman theme repo.
# Recolors every Yaru-red-dark place/folder icon to Spider-Man red #e23636,
# preserving luminance shading. Everything else inherits from Yaru-dark.
set -euo pipefail

REPO="/home/milky86x/Work/omarchy-spiderman-theme"
DST="$REPO/icon-theme/Spider-Man-Red"
SRC="/usr/share/icons/Yaru-red-dark"
RED="#E50914"

SIZES=(16 24 32 48 256)

mkdir -p "$DST"
rm -rf "$DST"/{16x16,24x24,32x32,48x48,256x256}

for s in "${SIZES[@]}"; do
  outdir="$DST/${s}x${s}/places"
  mkdir -p "$outdir"
  srcdir="$SRC/${s}x${s}/places"
  [ -d "$srcdir" ] || continue
  for png in "$srcdir"/*.png; do
    [ -e "$png" ] || continue
    name=$(basename "$png")
    # Bright red tint: blend pure Spider-Man red against the grayscale
    # luminance with overlay so the body stays vivid #e23636 while shape and
    # shading (tab highlight, bottom shade) are preserved.
    magick "$png" -modulate 100,0,100 /tmp/opencode/sm-gray.png
    magick -size "${s}x${s}" xc:"$RED" /tmp/opencode/sm-red.png
    magick /tmp/opencode/sm-red.png /tmp/opencode/sm-gray.png -compose overlay -composite \
      \( "$png" -alpha extract \) -alpha off -compose copyopacity -composite "$outdir/$name"
  done
done

cat > "$DST/index.theme" <<EOF
[Icon Theme]
Name=Spider-Man-Red
Comment=Spider-Man red folders for Omarchy
Inherits=Yaru-dark
Example=folder
Directories=16x16/places,24x24/places,32x32/places,48x48/places,256x256/places

[16x16/places]
Context=Places
Size=16
Type=Fixed

[24x24/places]
Context=Places
Size=24
Type=Fixed

[32x32/places]
Context=Places
Size=32
Type=Fixed

[48x48/places]
Context=Places
Size=48
Type=Fixed

[256x256/places]
Context=Places
Size=256
MinSize=64
MaxSize=256
Type=Scalable
EOF

echo "Built $DST"
find "$DST" -name "*.png" | wc -l
