import 'package:flutter/material.dart';
import 'package:note_app_mvvm/constants/app_colors.dart';
import 'package:note_app_mvvm/services/service_locator.dart';
import 'package:note_app_mvvm/view_models/note_view_model.dart';
import 'package:note_app_mvvm/views/add_note_view.dart';
import 'package:note_app_mvvm/views/widgets/note_list.dart';

class NotesView extends StatefulWidget {
  const NotesView({Key? key}) : super(key: key);

  @override
  _NotesViewState createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  final noteViewModel = getIt<NoteViewModel>();

  @override
  void initState() {
    noteViewModel.initNotes();
    super.initState();
  }

  @override
  void dispose() {
    noteViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColors.mainGrey,
      appBar: new AppBar(
        title: new Text("NoteMe"),
        backgroundColor: AppColors.mainPink,
      ),
      body: new NoteList(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: new FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              new MaterialPageRoute(builder: (context) => new AddNoteView()));
        },
        child: new Icon(Icons.add, size: 30),
        backgroundColor: Color.fromARGB(255, 239, 93, 93),
      ),
      drawer: new Drawer(),
    );
  }
}
