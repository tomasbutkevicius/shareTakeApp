import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_take/constants/theme/theme_colors.dart';

class ProxyTextFormField extends StatelessWidget {
  final String? initialValue;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final InputDecoration? decoration;
  final String labelText;
  final Icon? icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final bool enabled;

  const ProxyTextFormField({
    Key? key,
    this.controller,
    this.textInputAction,
    this.initialValue,
    this.validator,
    this.onChanged,
    this.onFieldSubmitted,
    this.decoration,
    this.icon,
    this.labelText = "text",
    this.obscureText = false,
    this.enabled = true,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      keyboardType: keyboardType,
      minLines: keyboardType == TextInputType.multiline ? 3 : null,
      maxLines: keyboardType == TextInputType.multiline ? null : 1,
      obscureText: obscureText,
      controller: controller,
      textInputAction: textInputAction,
      initialValue: initialValue,
      validator: validator,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      decoration: decoration ?? InputDecoration(
        floatingLabelBehavior:FloatingLabelBehavior.always,
        icon: icon,
        labelText: labelText,
      ),
    );
  }
}
