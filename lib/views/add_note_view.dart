import "package:flutter/material.dart";
import 'package:note_app_mvvm/constants/app_colors.dart';
import 'package:note_app_mvvm/constants/decorations.dart';
import 'package:note_app_mvvm/constants/app_text_styles.dart';
import 'package:note_app_mvvm/services/service_locator.dart';
import 'package:note_app_mvvm/view_models/note_view_model.dart';
import 'package:note_app_mvvm/views/widgets/text_fields.dart';

class AddNoteView extends StatefulWidget {
  AddNoteView({Key? key}) : super(key: key);

  @override
  _AddNoteViewState createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> {
  late final TextEditingController titleController;
  late final TextEditingController contentController;

  @override
  void initState() {
    titleController = new TextEditingController();
    contentController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColors.mainGrey,
      appBar: AppBar(
        backgroundColor: AppColors.mainPink,
        title: const Text("Add note"),
      ),
      body: new Container(
        child: new SingleChildScrollView(
          child: new Column(
            children: [
              new TitleTextField(controller: titleController),
              new SizedBox(height: 10),
              new ContentTextField(controller: contentController)
            ],
          ),
        ),
      ),
      floatingActionButton: _buildAddButton(),
    );
  }

  Widget _buildAddButton() {
    return new InkWell(
      onTap: () {
        final noteViewModel = getIt<NoteViewModel>();

        print(titleController.text);
        print(contentController.text);

        if (titleController.text.trim().isEmpty ||
            contentController.text.trim().isEmpty) return;

        noteViewModel.addNote({
          "title": titleController.text,
          "content": contentController.text,
        });

        Navigator.of(context).pop();
      },
      child: new Container(
        width: 100,
        height: 30,
        child: Center(
          child: new Text("Add",
              style: AppTextStyles.size18.copyWith(color: Colors.white)),
        ),
        decoration: new BoxDecoration(
            color: AppColors.mainPink,
            borderRadius: new BorderRadius.circular(4)),
      ),
    );
  }
}
