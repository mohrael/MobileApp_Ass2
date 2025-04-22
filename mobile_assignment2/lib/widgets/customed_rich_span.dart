import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class CustomedRichSpan extends StatelessWidget {
  final String text;
  final String inkwellText;
  final Widget screen;
  const CustomedRichSpan(
      {super.key,
      required this.text,
      required this.inkwellText,
      required this.screen});

  @override
  Widget build(BuildContext context) {
    return RichText(
        text: TextSpan(children: [
      TextSpan(text: text, style: const TextStyle(color: Colors.black)),
      TextSpan(
        text: inkwellText,
        style: const TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => screen));
          },
      )
    ]));
  }
}
