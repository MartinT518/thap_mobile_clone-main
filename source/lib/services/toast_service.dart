import 'package:flutter/widgets.dart';
import 'package:oktoast/oktoast.dart';
import 'package:thap/ui/common/colors.dart';

class ToastService {
  void regular(String message, [int? durationSeconds]) =>
      _buildToast(message, TingsColors.black, durationSeconds);

  void success(String message, [int? durationSeconds]) =>
      _buildToast(message, TingsColors.green, durationSeconds);

  void error(String message, [int? durationSeconds]) =>
      _buildToast(message, TingsColors.red, durationSeconds);

  void _buildToast(String message, Color color, [int? durationSeconds = 4]) {
    showToast(message,
        position: ToastPosition.bottom,
        duration: const Duration(seconds: 4),
        backgroundColor: color,
        radius: 50,
        textPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 16),
        textStyle: const TextStyle(
            color: TingsColors.white, fontFamily: 'Manrope', fontSize: 14),
        dismissOtherToast: true);
  }
}
