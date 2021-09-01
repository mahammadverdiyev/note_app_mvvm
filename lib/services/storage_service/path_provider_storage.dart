import 'package:note_app_mvvm/models/note.dart';
import 'package:note_app_mvvm/services/storage_service/storage_service.dart';

class PathProviderStorage implements StorageService {
  @override
  Future<void> saveNoteLeft(List<Note> notes) {
    throw UnimplementedError();
  }

  @override
  Future<List<Note>> getNoteLeft() {
    throw UnimplementedError();
  }
}
