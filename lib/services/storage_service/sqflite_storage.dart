import 'package:note_app_mvvm/models/note.dart';
import 'package:note_app_mvvm/services/storage_service/storage_service.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteStorage extends StorageService {
  static Database? _database;

  List<Note> oldNotes = <Note>[];

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    return await openDatabase(join(await getDatabasesPath(), "note_app.db"),
        onCreate: (db, version) async {
      await db.execute('''
          CREATE TABLE notes (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          content TEXT
          )
          ''');
    }, version: 1);
  }

  @override
  Future<List<Note>> getNoteLeft() async {
    List<Note> notesList = [];
    final db = await database;
    if (db != null) {
      final res = await db.query("notes");
      if (res.length == 0) {
        return notesList;
      } else {
        res.toList().forEach((map) => notesList.add(new Note.fromMap(map)));
        oldNotes = List.from(notesList);
        return notesList;
      }
    }
    return notesList;
  }

  @override
  Future<void> saveNoteLeft(List<Note> notes) async {
    if (oldNotes.length < notes.length) {
      addNewNote(notes.last);
      oldNotes.add(notes.last);
    } else if (oldNotes.length > notes.length) {
      for (int i = 0; i < oldNotes.length; i++) {
        if (i > (notes.length - 1)) {
          if (notes[i].id != null) {
            deleteNote(oldNotes.last.id as int);
            oldNotes.removeLast();
            break;
          }
        } else if (oldNotes[i] != notes[i] || oldNotes[i].id != notes[i].id) {
          deleteNote(oldNotes[i].id as int);
          oldNotes.removeAt(i);
          break;
        }
      }
    }
  }

  addNewNote(Note note) async {
    final db = await database;
    if (db != null) {
      int id = await db.insert('notes', note.toMap(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      note.id = id;
    }
  }

  deleteNote(int id) async {
    final db = await database;
    if (db != null) {
      db.delete('notes', where: "id = ?", whereArgs: [id]);
    }
  }
}
