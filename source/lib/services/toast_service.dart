import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thap/core/theme/app_theme.dart';

/// Toast Service following Design System v2.0 specifications
/// Background: Gray 900 (#212121)
/// Border Radius: 4px
/// Text: White, Body Medium (14px)
/// Position: Bottom, 60px margin
class ToastService {
  void regular(String message, [int? durationSeconds]) =>
      _buildToast(message, AppTheme.gray900, durationSeconds);

  void success(String message, [int? durationSeconds]) =>
      _buildToast(message, AppTheme.successGreen, durationSeconds);

  void error(String message, [int? durationSeconds]) =>
      _buildToast(message, AppTheme.errorRed, durationSeconds);

  void _buildToast(String message, Color color, [int? durationSeconds = 4]) {
    showToast(
      message,
      position: ToastPosition.bottom,
      duration: Duration(seconds: durationSeconds ?? 4),
      backgroundColor: color,
      radius: AppTheme.radiusXS, // Design System: 4px
      textPadding: const EdgeInsets.symmetric(
        horizontal: AppTheme.spacingM, // 16px
        vertical: AppTheme.spacingS, // 12px
      ),
      margin: const EdgeInsets.symmetric(
        vertical: 60, // Design System: 60px bottom margin
        horizontal: AppTheme.spacingM, // 16px
      ),
      textStyle: const TextStyle(
        color: Colors.white, // Design System: White text
        fontFamily: 'Manrope',
        fontSize: 14, // Design System: Body Medium (14px)
        fontWeight: FontWeight.w400,
      ),
      dismissOtherToast: true,
    );
  }
}
