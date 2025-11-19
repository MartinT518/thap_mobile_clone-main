# Replit Setup Guide

## After Pushing to Git

Once you've pushed your code to GitHub/GitLab, follow these steps in Replit:

### 1. Import Your Repository
1. Go to [Replit](https://replit.com)
2. Click "Create Repl" → "Import from GitHub"
3. Select your repository
4. Replit will automatically detect it's a Flutter project

### 2. Replit Will Automatically:
- ✅ Install Flutter SDK (configured in `.replit` file)
- ✅ Run `flutter pub get` to install dependencies
- ✅ Set up the development environment

### 3. Run Tests
Once Replit finishes setup, open the Shell and run:

```bash
cd source
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter test
```

### 4. Build and Run Web App
The `.replit` file is already configured to:
- Build: `cd source && flutter build web --release`
- Serve: `dhttpd --host=0.0.0.0 --port=5000`
- Deploy: Static deployment from `source/build/web`

Just click the "Run" button in Replit!

### 5. View Your App
- The app will be available in the webview
- External URL will be provided for sharing

## What's Configured

The `.replit` file includes:
- ✅ Flutter package in nix packages
- ✅ Build workflow for Flutter web
- ✅ Web server on port 5000
- ✅ Static deployment configuration

## Troubleshooting

### If Flutter isn't detected:
```bash
flutter doctor
```

### If dependencies fail:
```bash
cd source
flutter clean
flutter pub get
```

### If build fails:
```bash
cd source
flutter pub run build_runner build --delete-conflicting-outputs
flutter build web --release
```

### If tests fail:
Make sure code generation is complete:
```bash
cd source
flutter pub run build_runner build --delete-conflicting-outputs
```

## Next Steps

1. Push to Git (you're doing this now!)
2. Import to Replit
3. Run tests: `flutter test`
4. Build and deploy: Click "Run" button
5. View your app in the webview

