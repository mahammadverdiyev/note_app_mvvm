import 'dart:async';

import 'package:flutter/material.dart';

Future<bool> promptUser(String text, BuildContext context) async {
  TextStyle whiteText = new TextStyle(color: Colors.white);

  return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return new AlertDialog(
          content: new Text(text,
              style: new TextStyle(
                  fontFamily: '', color: Colors.black, fontSize: 20)),
          actions: [
            new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  Navigator.of(context).pop<bool>(true);
                },
                child: new Text('Yes', style: whiteText)),
            new TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  Navigator.of(context).pop<bool>(false);
                },
                child: new Text('No', style: whiteText)),
          ],
        );
      });
}
