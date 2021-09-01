import 'package:get_it/get_it.dart';
import 'package:note_app_mvvm/services/storage_service/fake_storage.dart';
import 'package:note_app_mvvm/services/storage_service/sqflite_storage.dart';
import 'package:note_app_mvvm/services/storage_service/storage_service.dart';
import 'package:note_app_mvvm/view_models/note_view_model.dart';

final getIt = GetIt.instance;

void setupGetIt() {
  // View Model layer
  getIt.registerLazySingleton<NoteViewModel>(() => new NoteViewModel());

  //service layer
  // getIt.registerLazySingleton<StorageService>(() => new FakeStorage());

  getIt.registerLazySingleton<StorageService>(() => new SqfliteStorage());
}
