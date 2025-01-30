// ignore_for_file: camel_case_types
import 'package:flutter/material.dart';

class Custom_TextField extends StatefulWidget {
  final TextEditingController themeController;
  final String labelTexts;
  final IconData? icon;
  final bool? havePassword;
  final List<String>? autofillHints;

  Custom_TextField({
    super.key,
    required this.themeController,
    required this.labelTexts,
    this.havePassword,
    required this.icon,
    this.autofillHints,
  });
  @override
  _Custom_TextFieldState createState() => _Custom_TextFieldState();
}

class _Custom_TextFieldState extends State<Custom_TextField> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth <= 414
          ? screenWidth * 0.8
          : screenWidth <= 810
              ? screenWidth * 0.75
              : screenWidth * 0.65,
      height: screenWidth <= 414
          ? screenWidth * 0.15
          : screenWidth <= 810
              ? screenWidth * 0.12
              : screenWidth * 0.1,
      child: TextField(
        obscureText: widget.havePassword == true ? _obscureText : false,
        decoration: InputDecoration(
          labelText: widget.labelTexts,
          labelStyle: TextStyle(
            color: Colors.white70,
            fontSize: screenWidth <= 414
                ? screenWidth * 0.035
                : screenWidth <= 810
                    ? screenWidth * 0.03
                    : screenWidth * 0.025,
          ),
          icon: Icon(
            widget.icon,
            color: Colors.white70,
            size: screenWidth <= 414
                ? screenWidth * 0.07
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white70,
              width: screenWidth <= 414
                  ? screenWidth * 0.003
                  : screenWidth <= 810
                      ? screenWidth * 0.003
                      : screenWidth * 0.003,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                screenWidth <= 414
                    ? screenWidth * 0.005
                    : screenWidth <= 810
                        ? screenWidth * 0.005
                        : screenWidth * 0.005,
              ),
            ),
          ),
          contentPadding: EdgeInsets.fromLTRB(
            screenWidth <= 414
                ? screenWidth * 0.01
                : screenWidth <= 810
                    ? screenWidth * 0.01
                    : screenWidth * 0.01,
            screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05,
            0,
            screenWidth <= 414
                ? screenWidth * 0.05
                : screenWidth <= 810
                    ? screenWidth * 0.05
                    : screenWidth * 0.05,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white70,
              width: screenWidth <= 414
                  ? screenWidth * 0.003
                  : screenWidth <= 810
                      ? screenWidth * 0.003
                      : screenWidth * 0.003,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(
                screenWidth <= 414
                    ? screenWidth * 0.005
                    : screenWidth <= 810
                        ? screenWidth * 0.005
                        : screenWidth * 0.005,
              ),
            ),
          ),
          suffixIcon: widget.havePassword == true
              ? IconButton(
                  icon: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    color: Colors.white70,
                    size: screenWidth <= 414
                        ? screenWidth * 0.05
                        : screenWidth <= 810
                            ? screenWidth * 0.05
                            : screenWidth * 0.05,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
              : null,
        ),
        style: TextStyle(
          color: Colors.white70,
          fontSize: screenWidth <= 414
              ? screenWidth * 0.04
              : screenWidth <= 810
                  ? screenWidth * 0.03
                  : screenWidth * 0.03,
        ),
        controller: widget.themeController,
        autofillHints: widget.autofillHints,
      ),
    );
  }
}
