import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:notes/screens/create_note.dart';
import 'package:notes/styles/app.dart';
import 'package:notes/widgets/button.dart';
import 'package:notes/widgets/float_button.dart';
import 'package:notes/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Widget> items = <Widget>[];

  @override
  void initState() {
    super.initState();
    setItens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        label: "Notas",
      ),
      body: ListView(
        padding: items.isNotEmpty
            ? const EdgeInsets.all(15)
            : const EdgeInsets.only(top: 50, right: 15, left: 15),
        children: <Widget>[
          if (items.isNotEmpty)
            ...items
          else ...[
            const Center(
              child: Text(
                'Nenhuma nota cadastrada',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            )
          ],
        ],
      ),
      floatingActionButton: FloatButton(onPressed: () async {
        await Navigator.push(context,
            MaterialPageRoute(builder: (context) => const CreateNote()));
        setItens();
      }),
    );
  }

  void setItens() async {
    final prefs = await SharedPreferences.getInstance();

    List<Widget> widget = [];
    // await prefs.remove('items');
    for (var item in prefs.getStringList('items') ?? <String>[]) {
      var note = jsonDecode(item);

      widget.add(Container(
        padding: const EdgeInsets.only(bottom: 15),
        child: Button(
          onClick: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CreateNote(id: note['id'])));
            setItens();
          },
          primaryColor: const Color(0xFFFF9E9E),
          buttonColor: const Color(0xFFFF9E9E),
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
                child: Text(
              note['title'],
              style: const TextStyle(
                  color: Style.primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            )),
          ),
        ),
      ));
    }

    setState(() {
      items = widget;
    });
  }
}
