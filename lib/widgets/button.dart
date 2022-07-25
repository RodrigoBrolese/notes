import 'package:flutter/material.dart';
import 'package:notes/styles/app.dart';

class Button extends StatelessWidget {
  const Button(
      {Key? key,
      required this.onClick,
      required this.child,
      this.buttonColor = Style.buttonColor,
      this.primaryColor = Style.primaryColor})
      : super(key: key);

  final Function() onClick;
  final Widget child;
  final Color buttonColor;
  final Color primaryColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(buttonColor),
          backgroundColor: MaterialStateProperty.all<Color>(buttonColor),
          minimumSize: MaterialStateProperty.all<Size>(const Size(50, 50)),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0))),
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(13)),
          overlayColor: MaterialStateProperty.resolveWith<Color?>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return primaryColor.withOpacity(0.08);
              }
              if (states.contains(MaterialState.focused) ||
                  states.contains(MaterialState.pressed)) {
                return primaryColor.withOpacity(0.45);
              }
              return null; // Defer to the widget's default.
            },
          ),
        ),
        onPressed: onClick,
        child: child);
  }
}
