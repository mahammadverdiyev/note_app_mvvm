import 'package:flutter/material.dart';
import 'package:note_app_mvvm/constants/app_colors.dart';
import 'package:note_app_mvvm/models/note.dart';
import 'package:note_app_mvvm/services/service_locator.dart';
import 'package:note_app_mvvm/view_models/note_view_model.dart';
import 'package:note_app_mvvm/views/widgets/text_fields.dart';

class NoteDetailView extends StatefulWidget {
  final Note note;
  const NoteDetailView({Key? key, required this.note}) : super(key: key);

  @override
  _NoteDetailViewState createState() => _NoteDetailViewState();
}

class _NoteDetailViewState extends State<NoteDetailView> {
  late final String oldTitle;
  late final String oldContent;

  late final TextEditingController titleController;
  late final TextEditingController contentController;

  final noteViewModel = getIt<NoteViewModel>();

  late final ValueNotifier<bool> extendedNotifier;
  late final ValueNotifier<bool> saveNoteButtonNotifier;

  @override
  void initState() {
    this.oldTitle = this.widget.note.title;
    this.oldContent = this.widget.note.content;

    this.extendedNotifier = new ValueNotifier<bool>(false);
    this.saveNoteButtonNotifier = new ValueNotifier<bool>(false);

    this.titleController = new TextEditingController(text: this.oldTitle)
      ..addListener(() {
        print("Title changed");
        handleSaveButton(oldTitle, oldContent, this.titleController.text,
            this.contentController.text);
      });

    this.contentController = new TextEditingController(text: this.oldContent)
      ..addListener(() {
        print("Content changed");
        handleSaveButton(oldTitle, oldContent, this.titleController.text,
            this.contentController.text);
      });

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();

    saveNoteButtonNotifier.dispose();
    extendedNotifier.dispose();
    titleController.dispose();
    contentController.dispose();
  }

  void handleSaveButton(
      String oldTitle, String oldContent, String newTitle, String newContent) {
    if (oldTitle.trim() == newTitle.trim() &&
        oldContent.trim() == newContent.trim()) {
      saveNoteButtonNotifier.value = false;
    } else {
      saveNoteButtonNotifier.value = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: AppColors.mainGrey,
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
      appBar: new AppBar(
        title: new Text("Edit"),
        backgroundColor: AppColors.mainPink,
      ),
      floatingActionButton: new ValueListenableBuilder<bool>(
          valueListenable: saveNoteButtonNotifier,
          builder: (context, value, child) => value
              ? new ValueListenableBuilder<bool>(
                  valueListenable: extendedNotifier,
                  builder: (context, extendedValue, child) =>
                      new FloatingActionButton.extended(
                          backgroundColor: AppColors.mainPink,
                          onPressed: () async {
                            if (!extendedNotifier.value) {
                              extendedNotifier.value = true;
                            } else {
                              noteViewModel.update(this.widget.note, {
                                "title": titleController.text,
                                "content": contentController.text
                              });
                              Navigator.pop(context);
                            }
                          },
                          label: AnimatedSwitcher(
                            duration: Duration(milliseconds: 500),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) =>
                                    FadeTransition(
                              opacity: animation,
                              child: SizeTransition(
                                child: child,
                                sizeFactor: animation,
                                axis: Axis.horizontal,
                              ),
                            ),
                            child: !extendedValue
                                ? Icon(Icons.save)
                                : Row(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 4.0),
                                        child: Icon(Icons.save),
                                      ),
                                      Text("Save note")
                                    ],
                                  ),
                          )),
                )
              : new Container()),
    );
  }
}
