import 'package:flutter/material.dart';

import '../styles/app.dart';

class NavBar extends AppBar {
  final List<Widget>? children;
  final String? label;

  NavBar({Key? key, this.children, this.label})
      : super(
          key: key,
          elevation: 0,
          toolbarHeight: 50,
          backgroundColor: Style.primaryColor,
          title: Text(label ?? ''),
          centerTitle: false,
          titleTextStyle:
              const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 25),
              child: Column(
                children: children ?? [Container()],
              ),
            )
          ],
        );
}
