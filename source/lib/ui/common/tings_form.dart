import 'package:flutter/material.dart';
import 'package:thap/ui/common/colors.dart';
import 'package:thap/ui/common/ting_icon.dart';

class TingsTextField extends StatelessWidget {
  const TingsTextField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.rightIcon,
    this.onChanged,
    this.onSubmitted,
    this.maxLines = 1,
    this.textInputType,
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final int maxLines;
  final Widget? rightIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    return TextField(
      textCapitalization: TextCapitalization.sentences,
      style: const TextStyle(color: TingsColors.black, fontSize: 14),
      maxLines: maxLines,
      decoration: getTingsFieldDecoration(label, hint, rightIcon),
      controller: controller,
      onChanged: onChanged,
      onSubmitted: onSubmitted,
      keyboardType: textInputType,
    );
  }
}

class TingsDropdownButtonFormField<T> extends StatelessWidget {
  const TingsDropdownButtonFormField({
    super.key,
    required this.label,
    this.value,
    this.items,
    this.onChanged,
    this.validator,
  });

  final String label;
  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final void Function(T?)? onChanged;
  final String? Function(T?)? validator;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      validator: validator,
      icon: const TingIcon('arrow_chevron-down', height: 18),
      decoration: getTingsFieldDecoration(label),
      borderRadius: BorderRadius.circular(8),
      dropdownColor: TingsColors.white,
      value: value,
      items: items,
      onChanged: onChanged,
    );
  }
}

InputDecoration getTingsFieldDecoration(
  String? label, [
  String? hint,
  Widget? rightIcon,
]) {
  return InputDecoration(
    floatingLabelBehavior: FloatingLabelBehavior.always,
    labelText: label,
    hintText: hint,
    fillColor: TingsColors.white,
    filled: true,
    suffixIcon: rightIcon,
    suffixIconConstraints:
        rightIcon != null ? const BoxConstraints(maxHeight: 24) : null,
    labelStyle: const TextStyle(color: TingsColors.grayVeryDark, fontSize: 14),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: TingsColors.grayMedium),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: TingsColors.black),
      borderRadius: BorderRadius.circular(8),
    ),
    errorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: TingsColors.red),
      borderRadius: BorderRadius.circular(8),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 2, color: TingsColors.red),
      borderRadius: BorderRadius.circular(8),
    ),
    contentPadding: const EdgeInsets.all(13),
  );
}
