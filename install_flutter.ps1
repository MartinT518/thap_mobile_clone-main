# Flutter Installation Script for Windows
# Run this in PowerShell as Administrator

Write-Host "🚀 Flutter Installation Script" -ForegroundColor Cyan
Write-Host "================================" -ForegroundColor Cyan
Write-Host ""

# Check if Flutter already exists
if (Test-Path "C:\src\flutter\bin\flutter.bat") {
    Write-Host "✅ Flutter already installed at C:\src\flutter" -ForegroundColor Green
    Write-Host "Verifying installation..." -ForegroundColor Yellow
    & C:\src\flutter\bin\flutter.bat --version
    exit 0
}

Write-Host "📥 Step 1: Creating directory C:\src" -ForegroundColor Yellow
New-Item -Path "C:\src" -ItemType Directory -Force | Out-Null

Write-Host "✅ Directory created" -ForegroundColor Green
Write-Host ""

Write-Host "📥 Step 2: Downloading Flutter SDK..." -ForegroundColor Yellow
Write-Host "Download link: https://docs.flutter.dev/get-started/install/windows" -ForegroundColor Cyan
Write-Host ""
Write-Host "⚠️  MANUAL STEP REQUIRED:" -ForegroundColor Red
Write-Host "1. Open: https://docs.flutter.dev/get-started/install/windows" -ForegroundColor White
Write-Host "2. Click 'Download Flutter SDK' (stable channel, ~1.5 GB)" -ForegroundColor White
Write-Host "3. Extract the ZIP file to: C:\src\" -ForegroundColor White
Write-Host "   (This will create C:\src\flutter\)" -ForegroundColor White
Write-Host ""

$continue = Read-Host "Press Enter after you've extracted Flutter to C:\src\flutter"

# Verify extraction
if (-not (Test-Path "C:\src\flutter\bin\flutter.bat")) {
    Write-Host "❌ Flutter not found at C:\src\flutter" -ForegroundColor Red
    Write-Host "Please make sure you extracted the ZIP to C:\src\" -ForegroundColor Red
    Write-Host "The folder structure should be: C:\src\flutter\bin\flutter.bat" -ForegroundColor Yellow
    exit 1
}

Write-Host "✅ Flutter extracted successfully!" -ForegroundColor Green
Write-Host ""

Write-Host "📥 Step 3: Adding Flutter to PATH..." -ForegroundColor Yellow

# Get current PATH
$currentPath = [Environment]::GetEnvironmentVariable("Path", "User")

# Check if Flutter is already in PATH
if ($currentPath -like "*flutter\bin*") {
    Write-Host "⚠️  Flutter already in PATH" -ForegroundColor Yellow
} else {
    # Add Flutter to PATH
    $newPath = $currentPath + ";C:\src\flutter\bin"
    [Environment]::SetEnvironmentVariable("Path", $newPath, "User")
    Write-Host "✅ Flutter added to PATH" -ForegroundColor Green
    
    # Update current session PATH
    $env:PATH += ";C:\src\flutter\bin"
}

Write-Host ""
Write-Host "📥 Step 4: Running Flutter Doctor..." -ForegroundColor Yellow
Write-Host ""

# Run Flutter Doctor
& C:\src\flutter\bin\flutter.bat doctor

Write-Host ""
Write-Host "🎉 Flutter installation complete!" -ForegroundColor Green
Write-Host ""
Write-Host "📝 Next steps:" -ForegroundColor Cyan
Write-Host "1. Restart your terminal/PowerShell" -ForegroundColor White
Write-Host "2. Run: flutter doctor" -ForegroundColor White
Write-Host "3. Run: flutter config --enable-web" -ForegroundColor White
Write-Host "4. Navigate to your project and run: flutter pub get" -ForegroundColor White
Write-Host ""
Write-Host "💡 To test Flutter is working, run:" -ForegroundColor Cyan
Write-Host "   flutter --version" -ForegroundColor White
Write-Host ""

