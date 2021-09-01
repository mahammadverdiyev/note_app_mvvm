import 'package:flutter/material.dart';
import 'package:note_app_mvvm/constants/app_text_styles.dart';
import 'package:note_app_mvvm/constants/decorations.dart';

class ContentTextField extends StatelessWidget {
  final TextEditingController controller;

  const ContentTextField({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: new TextField(
        controller: controller,
        style: AppTextStyles.size18.copyWith(
          decoration: TextDecoration.none,
        ),
        decoration:
            AppInputDecorations.withNoBorder.copyWith(hintText: "Content"),
        keyboardType: TextInputType.multiline,
        maxLines: null,
        minLines: 30,
      ),
    );
  }
}

class TitleTextField extends StatelessWidget {
  final TextEditingController controller;

  const TitleTextField({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: new TextField(
            controller: controller,
            style: AppTextStyles.size20w500
                .copyWith(decoration: TextDecoration.none),
            maxLines: 1,
            maxLength: 30,
            decoration: AppInputDecorations.withNoBorder.copyWith(
              hintText: "Title",
            ),
          )),
    );
  }
}
