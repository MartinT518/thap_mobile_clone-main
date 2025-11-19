# 🔄 How to Restart Your Flutter App

## The Issue

When you modify `web/index.html` or other configuration files, hot reload (`r`) won't work. You need to do a **hot restart** or **full restart**.

## ✅ Fixed: PDF.js Library Added

The pdfx package required PDF.js to be added to `web/index.html`. This has been done automatically.

---

## Quick Restart Methods

### Method 1: Hot Restart (Fastest)

In the terminal where Flutter is running:

**Press `R`** (capital R)

This will restart your app while keeping the Flutter process running.

---

### Method 2: Full Restart

If hot restart doesn't work:

1. **Press `q`** to quit the app
2. Wait for Flutter to stop
3. Run again:
   ```powershell
   flutter run -d chrome
   ```

---

## What Was Added to index.html

The following PDF.js scripts were added:

```html
<script
  src="https://cdn.jsdelivr.net/npm/pdfjs-dist@4.6.82/build/pdf.min.mjs"
  type="module"
></script>
<script type="module">
  var { pdfjsLib } = globalThis;
  pdfjsLib.GlobalWorkerOptions.workerSrc =
    "https://cdn.jsdelivr.net/npm/pdfjs-dist@4.6.82/build/pdf.worker.mjs";

  var pdfRenderOptions = {
    cMapUrl: "https://cdn.jsdelivr.net/npm/pdfjs-dist@4.6.82/cmaps/",
    cMapPacked: true,
  };
</script>
```

This allows the `pdfx` package to display PDFs in your Flutter web app.

---

## After Restart

1. Chrome should reload automatically
2. Press **F12** to open DevTools
3. Press **Ctrl + Shift + M** for phone view
4. The white screen error should be gone
5. Your app should load properly!

---

## Common Commands Reference

When Flutter is running:

- **`r`** - Hot reload (for code changes)
- **`R`** - Hot restart (for major changes, config changes)
- **`q`** - Quit the app
- **`h`** - Show all commands
- **`c`** - Clear the screen
- **`d`** - Detach (keep app running, stop Flutter)

---

## Still Seeing Errors?

### Clear Browser Cache

1. In Chrome, press **Ctrl + Shift + Delete**
2. Select "Cached images and files"
3. Click "Clear data"
4. Refresh the page (**Ctrl + F5**)

### Hard Refresh

Press **Ctrl + F5** in Chrome (hard refresh, bypasses cache)

### Clean Build

If nothing else works:

```powershell
flutter clean
flutter pub get
flutter run -d chrome
```

---

## Expected Result

After restart, you should see:

1. ✅ No more PDF.js error
2. ✅ Login screen loads
3. ✅ "Sign in with Google" button visible
4. ✅ App works in phone layout

---

Ready to test your demo authentication! 🚀
