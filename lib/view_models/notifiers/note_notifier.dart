import 'package:flutter/material.dart';
import 'package:note_app_mvvm/models/note.dart';
import 'package:note_app_mvvm/services/service_locator.dart';
import 'package:note_app_mvvm/services/storage_service/storage_service.dart';

class NoteNotifier extends ValueNotifier<List<Note>> {
  NoteNotifier() : super(_initialValue);

  final _storageService = getIt<StorageService>();

  static const List<Note> _initialValue = [];

  @override
  set value(List<Note> newValue) {
    super.value = newValue;
    if (this.value == newValue && this.value.length == newValue.length) return;

    if (this.value != newValue || this.value.length != newValue.length) {
      this.value = newValue;
      notifyListeners();
    }
  }

  Future<void> delete(Note note) async {
    this.value = List.from(this.value)..remove(note);
    _storageService.saveNoteLeft(this.value);
  }

  Future<void> update(Note note, Map<String, dynamic> noteJson) async {
    for (int i = 0; i < this.value.length; i++) {
      if (this.value[i] == note) {
        this.value[i] = Note.fromMap(noteJson);
      }
    }
    this.value = List.from(this.value);
    _storageService.saveNoteLeft(this.value);
  }

  Future<void> initialize() async {
    final savedNotes = await _storageService.getNoteLeft();
    _updateNotes(savedNotes);
  }

  Future<void> addNote(Map<String, dynamic> noteMap) async {
    Note note = Note.fromMap(noteMap);
    this.value = List.from(this.value)..add(note);
    _storageService.saveNoteLeft(this.value);
  }

  void _updateNotes(List<Note> notes) {
    this.value = notes;
  }

  @override
  void dispose() {
    _storageService.saveNoteLeft(this.value);
    super.dispose();
  }
}
