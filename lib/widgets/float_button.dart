import 'package:flutter/material.dart';

import '../styles/app.dart';

class FloatButton extends FloatingActionButton {
  @override
  final Function()? onPressed;

  FloatButton({Key? key, required this.onPressed})
      : super(
          key: key,
          onPressed: onPressed,
          backgroundColor: Style.primaryColor,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Style.primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(100),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.4),
                  spreadRadius: 4,
                  blurRadius: 10,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: const Center(
                child: Icon(
              Icons.add,
              color: Style.textColor,
              size: 40,
            )),
          ),
        );
}
