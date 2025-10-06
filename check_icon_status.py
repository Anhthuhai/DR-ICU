#!/usr/bin/env python3
"""
Script to verify app icon has been correctly applied
"""

import os
import subprocess

def check_icon_status():
    print("🔍 DR-ICU Icon Status Check")
    print("=" * 50)
    
    # Check if icon files exist
    icon_checks = [
        ("Master Icon", "assets/icons/app_icon.png"),
        ("macOS App Bundle", "build/macos/Build/Products/Release/dr_icu.app/Contents/Resources/AppIcon.icns"),
        ("Android Icons", "android/app/src/main/res/mipmap-hdpi/launcher_icon.png"),
        ("iOS Icons", "ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png"),
        ("Web Icons", "web/icons/Icon-192.png"),
    ]
    
    print("\n📁 File Existence Check:")
    all_exist = True
    for name, path in icon_checks:
        if os.path.exists(path):
            print(f"  ✅ {name}: {path}")
        else:
            print(f"  ❌ {name}: {path} (Missing)")
            all_exist = False
    
    # Check macOS app info
    print("\n🍎 macOS App Info:")
    app_path = "build/macos/Build/Products/Release/dr_icu.app"
    if os.path.exists(app_path):
        print(f"  ✅ App Bundle: {app_path}")
        
        # Check app size
        try:
            result = subprocess.run(['du', '-sh', app_path], capture_output=True, text=True)
            if result.returncode == 0:
                size = result.stdout.strip().split('\t')[0]
                print(f"  📦 App Size: {size}")
        except:
            pass
        
        # Check if app is running
        try:
            result = subprocess.run(['pgrep', '-f', 'dr_icu'], capture_output=True, text=True)
            if result.returncode == 0:
                print(f"  🏃 Running Process ID: {result.stdout.strip()}")
            else:
                print(f"  💤 App not currently running")
        except:
            pass
    else:
        print(f"  ❌ App Bundle not found")
    
    # Instructions
    print("\n📋 Icon Troubleshooting Steps:")
    if all_exist:
        print("  1. ✅ All icon files are present")
        print("  2. 🔄 Try: killall Dock (restart Dock)")
        print("  3. 🔄 Try: flutter clean && flutter build macos")
        print("  4. 🔄 Try: Quit app completely and relaunch")
        print("  5. 🔍 Check Activity Monitor for 'dr_icu' process")
        print("  6. 📱 Look for app in Applications folder or Dock")
    else:
        print("  1. ❌ Some icon files are missing")
        print("  2. 🔄 Run: dart run flutter_launcher_icons:main")
        print("  3. 🔄 Run: flutter clean && flutter build macos")
    
    print("\n💡 Debug Commands:")
    print("  • Check running app: pgrep -f dr_icu")
    print("  • Open app folder: open build/macos/Build/Products/Release/")
    print("  • View in Finder: open -R build/macos/Build/Products/Release/dr_icu.app")
    print("  • Force rebuild: flutter clean && flutter pub get && dart run flutter_launcher_icons:main")

def main():
    check_icon_status()

if __name__ == "__main__":
    main()
