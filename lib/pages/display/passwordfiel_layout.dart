import 'package:flutter/material.dart';
import 'package:my_map/pages/constants/constants.dart';

class PasswordfielLayout extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String validatorMessage;
  final bool isPasswordVisible;
  final ValueChanged<bool> onVisibilityChanged;
  final double height;
  final Color cursorColor;
  final String? Function(String?)? validator; // Custom validator support

  const PasswordfielLayout({
    Key? key,
    required this.controller,
    required this.label,
    required this.validatorMessage,
    required this.isPasswordVisible,
    required this.onVisibilityChanged,
    this.height = 50.0, // Default height of the textfield
    this.cursorColor = greyColor, // Default cursor color
    this.validator, // Optional custom validator
  }) : super(key: key);

  @override
  _PasswordfielLayoutState createState() => _PasswordfielLayoutState();
}

class _PasswordfielLayoutState extends State<PasswordfielLayout> {
  bool hasError = false;
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      onFocusChange: (focus) {
        setState(() {
          isFocused = focus;
        });
      },
      child: SizedBox(
        height: widget.height,
        child: TextFormField(
          controller: widget.controller,
          cursorColor: widget.cursorColor,
          obscureText: !widget.isPasswordVisible,
          validator: (value) {
            final error = widget.validator?.call(value) ??
                (value == null || value.isEmpty
                    ? widget.validatorMessage
                    : null);
            setState(() {
              hasError = error != null;
            });
            return error;
          },
          decoration: InputDecoration(
            labelText: hasError ? null : widget.label,
            labelStyle: TextStyle(
              color: greyColor,
              fontSize: hasError ? 13.0 : 15.0,
            ),
            prefixIcon: const Icon(
              Icons.lock_outlined,
              color: greyColor,
              size: 20.0,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                widget.isPasswordVisible
                    ? Icons.visibility_outlined
                    : Icons.visibility_off,
                color: greyColor,
                size: 20,
              ),
              onPressed: () {
                widget.onVisibilityChanged(!widget.isPasswordVisible);
              },
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: greyColor),
              borderRadius: BorderRadius.circular(40.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: myMainColor,
              ),
              borderRadius: BorderRadius.circular(40.0),
            ),
            errorStyle: const TextStyle(
              fontSize: 12.0,
            ),
          ),
        ),
      ),
    );
  }
}
