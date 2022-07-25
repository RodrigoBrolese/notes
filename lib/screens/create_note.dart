import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/text.dart' as text;
import 'package:flutter_quill/flutter_quill.dart';
import 'package:notes/styles/app.dart' as app_style;
import 'package:notes/widgets/button.dart';
import 'package:notes/widgets/nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({Key? key, this.id}) : super(key: key);

  final int? id;

  @override
  State<CreateNote> createState() => _CreateNoteState(id: id);
}

class _CreateNoteState extends State<CreateNote> {
  _CreateNoteState({Key? key, this.id});

  QuillController _controller = QuillController.basic();

  final int? id;

  @override
  void initState() {
    if (id != null) {
      setNote();
    }
    super.initState();
  }

  void setNote() async {
    final prefs = await SharedPreferences.getInstance();

    var note = prefs
        .getStringList('items')
        ?.firstWhere((element) => jsonDecode(element)['id'] == id);
    setState(() {
      _controller = QuillController(
          document: Document.fromJson(
              jsonDecode(jsonEncode(jsonDecode(note ?? '')['body']))),
          selection: const TextSelection.collapsed(offset: 0));
    });
  }

  Future saveNote(Document document) async {
    final prefs = await SharedPreferences.getInstance();

    var note = {
      'id': _controller.hashCode,
      'title': document.toPlainText().split('\n')[0],
      'body': document.toDelta().toJson(),
    };

    var json = jsonEncode(note);

    final List<String>? items = prefs.getStringList('items');
    if (items == null || items.isEmpty) {
      List<String>? items = <String>[json];
      await prefs.setStringList('items', items);
    } else {
      items.add(json);
      await prefs.setStringList('items', items);
    }
  }

  Future editNote(Document document) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? items = prefs.getStringList('items');
    int? key = items?.indexWhere((element) => jsonDecode(element)['id'] == id);
    var note = jsonDecode(
        items?.firstWhere((element) => jsonDecode(element)['id'] == id) ?? '');
    if (key == null || note == null) {
      return;
    }

    items![key] = jsonEncode({
      'id': note['id'],
      'title': document.toPlainText().split('\n')[0],
      'body': document.toDelta().toJson(),
    });
    await prefs.setStringList('items', items);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: NavBar(
          label: "Nova nota",
          children: [
            Button(
                onClick: () async {
                  if (_controller.document.isEmpty()) {
                    AlertDialog alert = const AlertDialog(
                      title: text.Text("Ops!!"),
                      content: text.Text("A nota está vazia."),
                      actions: [],
                    );

                    // show the dialog
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return alert;
                      },
                    );
                    return;
                  }

                  if (id == null) {
                    saveNote(_controller.document)
                        .then((value) => Navigator.pop(context));
                  } else {
                    editNote(_controller.document)
                        .then((value) => Navigator.pop(context));
                  }
                },
                child: const Icon(
                  Icons.save_outlined,
                  color: app_style.Style.textColor,
                  size: 20,
                )),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(15),
                child: QuillEditor.basic(
                  controller: _controller,
                  readOnly: false, // true for view only mode
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 30, top: 15, left: 15, right: 15),
              child: QuillToolbar.basic(controller: _controller),
            ),
          ],
        ));
  }
}
