import 'package:note_app_mvvm/models/note.dart';

abstract class StorageService {
  Future<void> saveNoteLeft(List<Note> notes);
  Future<List<Note>> getNoteLeft();
}
