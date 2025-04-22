import 'package:flutter/material.dart';

class CustomedTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool regexActive;
  final bool isPassword;
  String? helperText = "";
  RegExp? regExp = RegExp("");

  CustomedTextFormField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.regexActive,
    required this.isPassword,
    this.helperText,
    this.regExp,
  });

  @override
  State<CustomedTextFormField> createState() => _CustomedTextFormFieldState();
}

class _CustomedTextFormFieldState extends State<CustomedTextFormField> {
  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isPassword ? !_show : false,
      controller: widget.controller,
      cursorColor: Colors.black,
      onChanged: (s) {
        setState(() {});
      },
      decoration: InputDecoration(
        helperText: widget.regexActive
            ? (widget.controller.text.isEmpty ? "" : widget.helperText)
            : null,
        helperStyle: widget.regexActive
            ? TextStyle(
                color: widget.regExp!.hasMatch(widget.controller.text)
                    ? const Color(0xff007C04)
                    : const Color(0xffD10000),
                fontWeight: FontWeight.bold,
              )
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                onPressed: () {
                  setState(() {
                    _show = !_show;
                  });
                },
                icon: !_show
                    ? const Icon(Icons.remove_red_eye)
                    : const Icon(Icons.close),
              )
            : null,
        labelText: widget.labelText,
        labelStyle: const TextStyle(color: Color(0xffBE7C01)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 2)),
      ),
    );
  }
}
