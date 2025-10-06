#!/usr/bin/env python3
"""
Script to create app icon for DR-ICU medical application
Creates a professional medical-themed icon with cross and ICU elements
"""

import os
from PIL import Image, ImageDraw, ImageFont
import math

def create_app_icon():
    # Icon dimensions (1024x1024 for high resolution)
    size = 1024
    icon = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(icon)
    
    # Color scheme - Medical professional colors
    bg_color = (41, 128, 185)  # Professional blue
    cross_color = (255, 255, 255)  # White cross
    accent_color = (231, 76, 60)  # Medical red accent
    text_color = (255, 255, 255)  # White text
    
    # Background circle
    margin = 50
    circle_size = size - 2 * margin
    draw.ellipse([margin, margin, margin + circle_size, margin + circle_size], 
                 fill=bg_color, outline=None)
    
    # Medical cross in the center
    cross_width = 80
    cross_height = 300
    center_x, center_y = size // 2, size // 2
    
    # Vertical bar of cross
    left = center_x - cross_width // 2
    right = center_x + cross_width // 2
    top = center_y - cross_height // 2
    bottom = center_y + cross_height // 2
    draw.rectangle([left, top, right, bottom], fill=cross_color)
    
    # Horizontal bar of cross
    cross_h_width = 300
    cross_h_height = 80
    h_left = center_x - cross_h_width // 2
    h_right = center_x + cross_h_width // 2
    h_top = center_y - cross_h_height // 2
    h_bottom = center_y + cross_h_height // 2
    draw.rectangle([h_left, h_top, h_right, h_bottom], fill=cross_color)
    
    # Add medical pulse line accent
    pulse_y = center_y + 180
    pulse_points = []
    pulse_width = 400
    pulse_start_x = center_x - pulse_width // 2
    
    # Create pulse line points
    for i in range(0, pulse_width, 20):
        x = pulse_start_x + i
        if i % 80 == 0:
            y = pulse_y - 30  # Peak
        elif i % 80 == 20:
            y = pulse_y + 30  # Valley
        elif i % 80 == 40:
            y = pulse_y - 15  # Small peak
        else:
            y = pulse_y  # Baseline
        pulse_points.append((x, y))
    
    # Draw pulse line
    if len(pulse_points) > 1:
        for i in range(len(pulse_points) - 1):
            draw.line([pulse_points[i], pulse_points[i + 1]], 
                     fill=accent_color, width=8)
    
    # Add text "DR-ICU"
    try:
        # Try to use a system font
        font_size = 80
        font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", font_size)
    except:
        try:
            font = ImageFont.truetype("/usr/share/fonts/truetype/liberation/LiberationSans-Bold.ttf", font_size)
        except:
            # Fallback to default font
            font = ImageFont.load_default()
    
    text = "DR-ICU"
    # Get text bounding box
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    text_x = center_x - text_width // 2
    text_y = center_y + 250
    
    # Add text shadow for better visibility
    shadow_offset = 3
    draw.text((text_x + shadow_offset, text_y + shadow_offset), text, 
              fill=(0, 0, 0, 100), font=font)
    draw.text((text_x, text_y), text, fill=text_color, font=font)
    
    # Add small medical stethoscope accent
    steth_center_x = center_x - 200
    steth_center_y = center_y - 200
    
    # Stethoscope earpieces
    draw.ellipse([steth_center_x - 20, steth_center_y - 20, 
                  steth_center_x + 20, steth_center_y + 20], 
                 fill=accent_color)
    draw.ellipse([steth_center_x + 40, steth_center_y - 20, 
                  steth_center_x + 80, steth_center_y + 20], 
                 fill=accent_color)
    
    # Stethoscope tubes
    draw.line([steth_center_x, steth_center_y + 20, 
               steth_center_x + 20, steth_center_y + 80], 
              fill=accent_color, width=6)
    draw.line([steth_center_x + 60, steth_center_y + 20, 
               steth_center_x + 40, steth_center_y + 80], 
              fill=accent_color, width=6)
    
    # Stethoscope chest piece
    draw.ellipse([steth_center_x + 15, steth_center_y + 75, 
                  steth_center_x + 45, steth_center_y + 105], 
                 fill=accent_color)
    
    return icon

def main():
    print("Creating DR-ICU app icon...")
    
    # Create assets/icons directory if it doesn't exist
    os.makedirs("assets/icons", exist_ok=True)
    
    # Create the icon
    icon = create_app_icon()
    
    # Save the main icon file
    icon_path = "assets/icons/app_icon.png"
    icon.save(icon_path, "PNG")
    print(f"✅ Created app icon: {icon_path}")
    
    # Create different sizes for various platforms
    sizes = [16, 32, 48, 64, 128, 256, 512, 1024]
    
    for size in sizes:
        resized_icon = icon.resize((size, size), Image.Resampling.LANCZOS)
        size_path = f"assets/icons/app_icon_{size}x{size}.png"
        resized_icon.save(size_path, "PNG")
        print(f"✅ Created {size}x{size} icon: {size_path}")
    
    print("\n🎉 All icons created successfully!")
    print("📱 Next steps:")
    print("1. Run: flutter pub get")
    print("2. Run: flutter pub run flutter_launcher_icons:main")
    print("3. Your app icons will be automatically applied to all platforms!")

if __name__ == "__main__":
    main()
