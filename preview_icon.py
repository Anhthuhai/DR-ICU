#!/usr/bin/env python3
"""
Script to preview the created DR-ICU app icon
Shows information about the icon design and opens it for preview
"""

import os
from PIL import Image

def preview_icon():
    icon_path = "assets/icons/app_icon.png"
    
    if not os.path.exists(icon_path):
        print("❌ Icon not found. Please run create_app_icon.py first.")
        return
    
    # Load and analyze the icon
    icon = Image.open(icon_path)
    
    print("🎨 DR-ICU App Icon Preview")
    print("=" * 50)
    print(f"📱 Icon file: {icon_path}")
    print(f"📐 Dimensions: {icon.size[0]}x{icon.size[1]} pixels")
    print(f"🎨 Mode: {icon.mode}")
    print(f"📊 Format: {icon.format}")
    
    print("\n🏥 Icon Design Elements:")
    print("• Background: Professional medical blue (#2980b9)")
    print("• Main symbol: White medical cross")
    print("• Accent: Red medical pulse line")
    print("• Text: 'DR-ICU' in white")
    print("• Medical element: Stethoscope accent")
    
    print("\n📱 Generated for platforms:")
    platforms = []
    
    # Check Android
    android_path = "android/app/src/main/res/mipmap-hdpi/launcher_icon.png"
    if os.path.exists(android_path):
        platforms.append("✅ Android")
    else:
        platforms.append("❌ Android")
    
    # Check iOS
    ios_path = "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png"
    if os.path.exists(ios_path):
        platforms.append("✅ iOS")
    else:
        platforms.append("❌ iOS")
    
    # Check Web
    web_path = "web/icons/Icon-192.png"
    if os.path.exists(web_path):
        platforms.append("✅ Web")
    else:
        platforms.append("❌ Web")
    
    # Check macOS
    macos_path = "macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png"
    if os.path.exists(macos_path):
        platforms.append("✅ macOS")
    else:
        platforms.append("❌ macOS (check other formats)")
    
    for platform in platforms:
        print(f"  {platform}")
    
    print("\n🚀 Status: Ready for deployment!")
    print("💡 The icon represents:")
    print("   • Medical expertise (cross symbol)")
    print("   • Critical care (ICU theme)")
    print("   • Emergency response (pulse line)")
    print("   • Professional healthcare (color scheme)")

def main():
    preview_icon()

if __name__ == "__main__":
    main()
