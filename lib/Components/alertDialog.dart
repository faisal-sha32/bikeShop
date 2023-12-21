// ignore_for_file: file_names

import 'package:flutter/material.dart';

showAlertDialog({
  required BuildContext? context,
  required VoidCallback? onConfirm,
  required String? dialogMessage,
}) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: const Text("No"),
    onPressed: () {
      Navigator.of(context!).pop();
    },
  );
  Widget continueButton = TextButton(
    onPressed: onConfirm,
    child: const Text(
      "Yes",
    ),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text(
      "Alert",
    ),
    content: Text(
      dialogMessage!,
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    barrierDismissible: false,
    context: context!,
    builder: (
      BuildContext context,
    ) {
      return alert;
    },
  );
}
