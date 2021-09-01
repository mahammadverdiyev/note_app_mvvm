import "package:flutter/material.dart";
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:note_app_mvvm/constants/app_text_styles.dart';
import 'package:note_app_mvvm/models/note.dart';
import 'package:note_app_mvvm/services/service_locator.dart';
import 'package:note_app_mvvm/view_models/note_view_model.dart';
import 'package:note_app_mvvm/views/dialogs.dart';

import '../note_detail_view.dart';

class NoteWidget extends StatelessWidget {
  final Note note;

  const NoteWidget({Key? key, required this.note}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new LayoutBuilder(
      builder: (context, constraints) => new InkWell(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
              builder: (_) => new NoteDetailView(note: note)));
        },
        child: new Slidable(
          key: new UniqueKey(),
          actionPane: SlidableDrawerActionPane(),
          secondaryActions: _buildActions(constraints, context),
          movementDuration: new Duration(milliseconds: 350),
          actionExtentRatio: 0.25,
          child: Container(
            constraints: new BoxConstraints(
              maxHeight: 80,
              maxWidth: MediaQuery.of(context).size.width,
            ),
            decoration: new BoxDecoration(
              boxShadow: [
                const BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2.0,
                ),
              ],
              color: Colors.white,
              borderRadius: new BorderRadius.circular(4),
            ),
            // margin: const EdgeInsets.only(bottom: 8),
            child: new Row(
              children: [
                const ColoredContainer(),
                const SizedBox(
                  width: 20,
                ),
                new Expanded(
                  flex: 50,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      new Text("${note.title}", style: AppTextStyles.size20),
                      new SizedBox(height: 10),
                      new Text(
                        "${note.content}",
                        style: new TextStyle(color: Colors.black45),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildActions(BoxConstraints constraints, BuildContext context) {
    return <Widget>[
      new SizedBox.expand(
        child: new Container(
          height: double.infinity,
          width: constraints.maxWidth,
          decoration: new BoxDecoration(
            boxShadow: [
              const BoxShadow(
                color: Colors.black38,
                blurRadius: 2.0,
              ),
            ],
            color: Colors.blue,
          ),
          child: new IconButton(
            icon: new Icon(Icons.archive, size: 30, color: Colors.white),
            onPressed: () async {},
          ),
        ),
      ),
      new SizedBox.expand(
        child: new Container(
          height: constraints.maxHeight - 10,
          width: constraints.maxWidth,
          decoration: new BoxDecoration(
            boxShadow: [
              const BoxShadow(
                color: Colors.black38,
                blurRadius: 2.0,
              ),
            ],
            borderRadius: new BorderRadius.only(
                topRight: new Radius.circular(4),
                bottomRight: new Radius.circular(4)),
            color: Colors.red,
          ),
          child: new IconButton(
            icon: new Icon(Icons.delete, size: 30, color: Colors.white),
            onPressed: () async {
              final noteViewModel = getIt<NoteViewModel>();

              bool allowToDelete = await promptUser(
                  "Are you sure you want to delete a note ?", context);

              if (allowToDelete) {
                noteViewModel.delete(note);
              }
            },
          ),
        ),
      ),
    ];
  }
}

class ColoredContainer extends StatelessWidget {
  const ColoredContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(4), bottomLeft: Radius.circular(4)),
        ),
        width: double.infinity,
        height: double.infinity,
      ),
    );
  }
}
