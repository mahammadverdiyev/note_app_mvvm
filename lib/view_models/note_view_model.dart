import 'package:flutter/cupertino.dart';
import 'package:note_app_mvvm/models/note.dart';
import 'package:note_app_mvvm/view_models/notifiers/note_notifier.dart';

class NoteViewModel {
  final noteNotifier = new NoteNotifier();

  void initNotes() {
    noteNotifier.initialize();
  }

  Future<void> addNote(Map<String, dynamic> noteJson) async {
    noteNotifier.addNote(noteJson);
  }

  Future<void> delete(Note note) async {
    noteNotifier.delete(note);
  }

  Future<void> update(Note note, Map<String, dynamic> noteJson) async {
    noteNotifier.update(note, noteJson);
  }

  void dispose() {
    noteNotifier.dispose();
  }
}
