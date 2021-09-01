import 'package:note_app_mvvm/models/note.dart';
import 'package:note_app_mvvm/services/storage_service/storage_service.dart';

class FakeStorage extends StorageService {
  List<Note> notes = [
    new Note(
        title: "State management",
        content: "State management is very important topic in flutter."),
    new Note(title: "Flutter", content: "Flutter is awesome!")
  ];

  @override
  Future<List<Note>> getNoteLeft() async {
    return notes;
  }

  @override
  Future<void> saveNoteLeft(List<Note> notes) async {
    this.notes = notes;
  }
}
