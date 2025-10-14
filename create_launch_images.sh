#!/bin/bash

# Script to create simple launch images using app icon
# Run this in the project root directory

echo "Creating Launch Images for DR-ICU..."

# Create launch images directory if it doesn't exist
mkdir -p launch_images_temp

# Copy the largest app icon to work with
cp "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png" "launch_images_temp/base_icon.png"

# You can use ImageMagick or similar tools to create launch images
# Example commands (requires ImageMagick):

# Create 1x version (168x185)
echo "Creating 1x launch image..."
# magick launch_images_temp/base_icon.png -resize 120x120 -background "#0077BE" -gravity center -extent 168x185 "ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage.png"

# Create 2x version (336x370)
echo "Creating 2x launch image..."
# magick launch_images_temp/base_icon.png -resize 240x240 -background "#0077BE" -gravity center -extent 336x370 "ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@2x.png"

# Create 3x version (504x555)
echo "Creating 3x launch image..."
# magick launch_images_temp/base_icon.png -resize 360x360 -background "#0077BE" -gravity center -extent 504x555 "ios/Runner/Assets.xcassets/LaunchImage.imageset/LaunchImage@3x.png"

echo "Launch images created! (ImageMagick commands commented out)"
echo "To use this script:"
echo "1. Install ImageMagick: brew install imagemagick"
echo "2. Uncomment the magick commands above"
echo "3. Run: bash create_launch_images.sh"

# Manual instructions
echo ""
echo "MANUAL STEPS:"
echo "1. Open launch_images_temp/base_icon.png in any image editor"
echo "2. Create a 168x185 canvas with medical blue background (#0077BE)"
echo "3. Center the icon and resize to fit nicely"
echo "4. Export as LaunchImage.png"
echo "5. Repeat for 2x and 3x sizes"
echo "6. Replace files in ios/Runner/Assets.xcassets/LaunchImage.imageset/"
