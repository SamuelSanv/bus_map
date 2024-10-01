import 'package:flutter/material.dart';
import 'package:my_map/pages/constants/constants.dart';

class TextfieldLayout extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String validatorMessage;
  final double height;
  final Color cursorColor;
  final String? Function(String?)? validator; // Allow custom validation

  const TextfieldLayout({
    Key? key,
    required this.controller,
    required this.label,
    required this.icon,
    required this.validatorMessage,
    this.height = 50.0, // Default height of the textfield
    this.cursorColor = greyColor, // Default cursor color
    this.validator, // Custom validator
  }) : super(key: key);

  @override
  _TextfieldLayoutState createState() => _TextfieldLayoutState();
}

class _TextfieldLayoutState extends State<TextfieldLayout> {
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
            prefixIcon: Icon(
              widget.icon,
              color: greyColor,
              size: 20.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: greyColor),
              borderRadius: BorderRadius.circular(40.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: myMainColor),
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
