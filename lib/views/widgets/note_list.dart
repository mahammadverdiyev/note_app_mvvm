import "package:flutter/material.dart";
import 'package:note_app_mvvm/models/note.dart';
import 'package:note_app_mvvm/services/service_locator.dart';
import 'package:note_app_mvvm/view_models/note_view_model.dart';

import 'note_widget.dart';

class NoteList extends StatelessWidget {
  const NoteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final noteViewModel = getIt<NoteViewModel>();

    return ValueListenableBuilder<List<Note>>(
        valueListenable: noteViewModel.noteNotifier,
        builder: (context, notes, child) {
          return Container(
              padding: const EdgeInsets.all(12),
              child: new ListView.separated(
                  separatorBuilder: (_, index) =>
                      const Divider(color: Colors.transparent),
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return new NoteWidget(
                        note: notes[notes.length - index - 1]);
                  }));
        });
  }
}
