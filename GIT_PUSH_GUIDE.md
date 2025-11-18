# Git Push Guide for Replit Deployment

## Quick Steps to Push to Git

### 1. Check Current Status
```powershell
cd C:\Users\mtamm\Documents\thap_mobile_clone-main
git status
```

### 2. Add All Changes
```powershell
git add .
```

### 3. Commit Changes
```powershell
git commit -m "Update AI functionality tests and fix demo responses"
```

### 4. Push to Remote
```powershell
git push origin main
```
(Or `git push origin master` if your default branch is master)

## What's Being Pushed

### New Test Files
- `source/test/ai_service_test.dart`
- `source/test/ai_repository_test.dart`
- `source/test/ai_demo_responses_test.dart`
- `source/test/ai_question_selection_test.dart`
- `source/test/ai_chat_widget_test.dart`
- `source/test/test_helper.dart`

### Updated Files
- `source/lib/features/ai_assistant/data/repositories/ai_repository_impl.dart` - Fixed to pass full prompt for product-specific responses
- `source/test/widget_test.dart` - Updated placeholder
- `source/test/ai_question_selection_test.dart` - Updated tests

### Documentation
- `RUN_TESTS.md` - Test execution guide
- `TEST_STATUS.md` - Test status summary
- `FLUTTER_INSTALLATION_GUIDE.md` - Flutter installation guide
- `GIT_PUSH_GUIDE.md` - This file

## Replit Configuration

The `.replit` file is already configured for Flutter:
- ✅ Flutter package included in nix packages
- ✅ Build command: `cd source && flutter build web --release`
- ✅ Web server configured on port 5000
- ✅ Deployment target set to static

## After Pushing to Git

1. **Import to Replit**:
   - Go to Replit
   - Click "Import from GitHub"
   - Select your repository
   - Replit will automatically detect Flutter and install dependencies

2. **Replit will automatically**:
   - Install Flutter SDK
   - Run `flutter pub get`
   - Build the web app
   - Serve it on port 5000

3. **Run Tests in Replit**:
   ```bash
   cd source
   flutter test
   ```

## Troubleshooting

### If git push fails:
- Check if you have a remote configured: `git remote -v`
- If no remote, add one: `git remote add origin <your-repo-url>`
- Make sure you're authenticated with GitHub/GitLab

### If Replit doesn't detect Flutter:
- The `.replit` file should handle it automatically
- You can manually run: `flutter doctor` in Replit shell

### If tests fail in Replit:
- Make sure to run `flutter pub get` first
- Run `flutter pub run build_runner build` if needed for code generation
- Check Replit console for specific error messages

