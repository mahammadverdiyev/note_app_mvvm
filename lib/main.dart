import 'package:flutter/material.dart';
import 'package:note_app_mvvm/services/service_locator.dart';

import 'views/notes_view.dart';

void main() {
  setupGetIt();
  runApp(new NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new NotesView(),
    );
  }
}
