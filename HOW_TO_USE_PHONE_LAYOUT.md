# 📱 How to View Your Flutter App in Phone Layout

## ✅ Your App is Now Running!

Flutter is running your app in Chrome. Chrome should have opened automatically showing your app.

If Chrome didn't open automatically, the app is running on: **http://localhost:PORT** (Flutter shows the port in the terminal)

---

## 🎯 Step-by-Step: Switch to Phone Layout

### Method 1: Chrome DevTools (Recommended)

1. **Open Chrome DevTools**
   - Press **F12** (or right-click → Inspect)

2. **Toggle Device Toolbar**
   - Press **Ctrl + Shift + M**
   - Or click the phone/tablet icon in DevTools toolbar

3. **Select a Phone Device**
   - At the top of the page, click the dropdown that says "Dimensions: Responsive"
   - Select a phone model:
     - **iPhone 14 Pro** (393 × 852)
     - **iPhone 12 Pro** (390 × 844) ← Recommended
     - **iPhone SE** (375 × 667)
     - **Galaxy S20** (360 × 800)
     - **Pixel 5** (393 × 851)

4. **Adjust if Needed**
   - Zoom: Use the zoom dropdown if content is too small/large
   - Rotate: Click rotate icon to test landscape mode
   - Throttling: Can simulate slower networks

### Visual Guide:

```
┌─────────────────────────────────────────────────────┐
│ Chrome DevTools                                     │
├─────────────────────────────────────────────────────┤
│ ┌─────────────────────────────────────────────────┐ │
│ │ [Dimensions: iPhone 12 Pro ▼]  [100% ▼]  [🔄]  │ │ ← Select device here
│ └─────────────────────────────────────────────────┘ │
│ ┌───────────────┐                                   │
│ │               │                                   │
│ │   📱 Your     │                                   │
│ │   App Here    │ ← Phone view (390×844)           │
│ │               │                                   │
│ │               │                                   │
│ └───────────────┘                                   │
└─────────────────────────────────────────────────────┘
```

---

## 🎮 Method 2: Custom Dimensions

If you want specific dimensions:

1. Press **Ctrl + Shift + M** to enter Device Mode
2. Click **"Responsive"** dropdown
3. Select **"Edit"** at the bottom
4. Click **"Add custom device"**
5. Enter custom dimensions (e.g., 390 × 844)

---

## 🔥 Hot Reload (Super Fast Development!)

Now that Flutter is running, you can make changes and see them instantly:

### How to Use Hot Reload:

1. **Make a code change** in Cursor (any `.dart` file)
2. **Save the file** (`Ctrl + S`)
3. **Go to the terminal** where Flutter is running
4. **Press `r`** (lowercase) for hot reload
5. **See changes instantly** in Chrome (< 1 second!)

### Hot Reload Commands:

- **`r`** - Hot Reload (reload code changes, keeps app state)
- **`R`** - Hot Restart (restart app from scratch)
- **`q`** - Quit (stop the app)
- **`h`** - Show all commands

---

## 🎯 Test Your Demo Authentication

Once the app is in phone view:

1. You should see a **Login Screen**
2. Click **"Sign in with Google"** button
3. Wait **1 second** (demo delay)
4. You're signed in as **"Demo User"** (demo@example.com)
5. **Explore the app!**

No real Google account needed - it's all simulated!

---

## 💡 Pro Tips

### 1. Keep DevTools Open
- Always have F12 DevTools open while developing
- You can see console errors, network requests, etc.

### 2. Use Multiple Views
- You can open the same app in multiple Chrome windows
- Set different phone dimensions in each to test different screens

### 3. Mobile Chrome Simulation
- Device Mode also simulates:
  - Touch events (instead of mouse)
  - Mobile user agent
  - Device pixel ratio
  - Viewport meta tag behavior

### 4. Performance Testing
- In DevTools, go to "Performance" tab
- Click "Record" to profile app performance
- Useful for finding slow renders

### 5. Network Throttling
- In Device Mode, select network speed
- Options: Fast 3G, Slow 3G, Offline
- Tests how app behaves on slow connections

---

## 📊 Recommended Phone Dimensions

| Device | Width | Height | When to Use |
|--------|-------|--------|-------------|
| iPhone 14 Pro | 393px | 852px | Latest iOS |
| iPhone 12 Pro | 390px | 844px | Most popular iOS |
| iPhone SE | 375px | 667px | Smaller iOS screens |
| Galaxy S20 | 360px | 800px | Popular Android |
| Pixel 5 | 393px | 851px | Latest Android |
| iPhone 8 | 375px | 667px | Legacy iOS |

**Recommendation**: Test on **iPhone 12 Pro** (390×844) first, then **Galaxy S20** (360×800) to cover most users.

---

## 🔧 Troubleshooting

### Chrome didn't open automatically
- Check the terminal for the URL (usually `http://localhost:port`)
- Manually open Chrome and navigate to that URL
- Or run: `flutter run -d chrome --web-port=5000` to use port 5000

### Page is blank or loading forever
- Check console for errors (F12 → Console tab)
- Try hot reload: press `r` in the terminal
- Try hot restart: press `R` in the terminal

### Device toolbar not working
- Make sure you're in Chrome (not Edge or Firefox)
- Try closing DevTools (F12) and reopening
- Refresh the page (F5)

### App looks weird in device mode
- Check zoom level (should be 100%)
- Make sure device orientation is correct
- Try a different device preset

### Changes not showing after hot reload
- Some changes require hot restart (press `R`)
- Or stop the app (`q`) and run again

---

## 🚀 Next Steps

### Development Workflow:

1. **Make changes** in Cursor
2. **Save** (`Ctrl + S`)
3. **Hot reload** (`r` in terminal)
4. **See results** in Chrome
5. **Repeat!**

### Testing Workflow:

1. Test on **iPhone 12 Pro** (390×844)
2. Test on **Galaxy S20** (360×800)
3. Test in **landscape mode** (rotate device)
4. Test with **slow 3G** network
5. Check **console for errors**

---

## 📝 Current Status

✅ Flutter installed and configured  
✅ Flutter & Dart extensions in Cursor  
✅ Web support enabled  
✅ Dependencies installed  
✅ App running in Chrome  
✅ Demo mode configured  
✅ Hot reload ready!

---

## 🎨 Chrome DevTools Shortcuts

| Shortcut | Action |
|----------|--------|
| **F12** | Toggle DevTools |
| **Ctrl + Shift + M** | Toggle Device Toolbar |
| **Ctrl + Shift + C** | Inspect Element |
| **Ctrl + ]** | Next panel |
| **Ctrl + [** | Previous panel |
| **Ctrl + Shift + P** | Command palette |
| **F5** | Refresh page |
| **Ctrl + F5** | Hard refresh (clear cache) |

---

## 🎉 You're All Set!

Your Flutter app is now running in Chrome with hot reload enabled. You can:

1. ✅ View it in phone layout (Ctrl + Shift + M)
2. ✅ Make code changes and see them instantly (press `r`)
3. ✅ Test demo authentication
4. ✅ Debug with DevTools
5. ✅ Test on multiple device sizes

**Happy coding!** 🚀

---

## 📚 Useful Resources

- **Chrome DevTools Docs**: https://developer.chrome.com/docs/devtools/
- **Flutter DevTools**: https://docs.flutter.dev/tools/devtools
- **Flutter for Web**: https://docs.flutter.dev/platform-integration/web
- **Hot Reload**: https://docs.flutter.dev/tools/hot-reload

---

## 🆘 Need Help?

If you encounter any issues:

1. Check the terminal output for errors
2. Check Chrome console (F12 → Console)
3. Try hot restart (`R` in terminal)
4. Try `flutter clean` then rebuild
5. Check `QUICK_START.md` for more troubleshooting

