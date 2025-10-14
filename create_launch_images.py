#!/usr/bin/env python3
"""
Script to create Launch Images for DR-ICU app
"""
from PIL import Image, ImageDraw, ImageFont
import os

def create_launch_image(width, height, filename):
    """Create a launch image with medical theme"""
    
    # Create new image with medical blue background
    img = Image.new('RGB', (width, height), color='#0077BE')
    draw = ImageDraw.Draw(img)
    
    # Load app icon if available
    icon_path = "temp_launch_images/app_icon.png"
    if os.path.exists(icon_path):
        try:
            # Open and resize app icon
            icon = Image.open(icon_path)
            icon_size = min(width, height) // 3  # Make icon 1/3 of smallest dimension
            icon = icon.resize((icon_size, icon_size), Image.Resampling.LANCZOS)
            
            # Calculate position to center the icon
            icon_x = (width - icon_size) // 2
            icon_y = (height - icon_size) // 2 - 20  # Slightly above center
            
            # Paste icon (handle transparency)
            if icon.mode == 'RGBA':
                img.paste(icon, (icon_x, icon_y), icon)
            else:
                img.paste(icon, (icon_x, icon_y))
                
            # Add app name below icon
            try:
                # Try to use a system font
                font_size = width // 12
                font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", font_size)
            except:
                # Fallback to default font
                font = ImageFont.load_default()
            
            text = "DR-ICU"
            # Get text bounding box
            bbox = draw.textbbox((0, 0), text, font=font)
            text_width = bbox[2] - bbox[0]
            text_height = bbox[3] - bbox[1]
            
            text_x = (width - text_width) // 2
            text_y = icon_y + icon_size + 20
            
            draw.text((text_x, text_y), text, fill='white', font=font)
            
        except Exception as e:
            print(f"Error processing icon: {e}")
            # Fallback: just draw text
            draw.text((width//2 - 40, height//2), "DR-ICU", fill='white')
    else:
        # No icon available, just draw text centered
        try:
            font_size = width // 8
            font = ImageFont.truetype("/System/Library/Fonts/Helvetica.ttc", font_size)
        except:
            font = ImageFont.load_default()
        
        text = "DR-ICU"
        bbox = draw.textbbox((0, 0), text, font=font)
        text_width = bbox[2] - bbox[0]
        text_height = bbox[3] - bbox[1]
        
        text_x = (width - text_width) // 2
        text_y = (height - text_height) // 2
        
        draw.text((text_x, text_y), text, fill='white', font=font)
    
    # Save the image
    output_path = f"ios/Runner/Assets.xcassets/LaunchImage.imageset/{filename}"
    img.save(output_path, 'PNG', quality=95)
    print(f"Created {filename} ({width}x{height})")

def main():
    """Create all required launch image sizes"""
    sizes = [
        (168, 185, "LaunchImage.png"),
        (336, 370, "LaunchImage@2x.png"),
        (504, 555, "LaunchImage@3x.png")
    ]
    
    print("Creating Launch Images for DR-ICU...")
    
    for width, height, filename in sizes:
        create_launch_image(width, height, filename)
    
    print("✅ All Launch Images created successfully!")
    print("📱 Files created:")
    for _, _, filename in sizes:
        path = f"ios/Runner/Assets.xcassets/LaunchImage.imageset/{filename}"
        if os.path.exists(path):
            size = os.path.getsize(path)
            print(f"   {filename}: {size} bytes")

if __name__ == "__main__":
    main()
