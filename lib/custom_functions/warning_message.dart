import 'package:flutter/material.dart';
import 'package:tatweer_maximo/widgets/custom_rectangle_button.dart';

void showWarningMessage(String message, BuildContext context) {
  showDialog(
    barrierDismissible: false, // user must tap button!
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Center(
        child: Icon(
          size: 50,
          Icons.warning,
          color: Colors.red,
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 10,
          ),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          )
        ],
      ),
      actions: <Widget>[
        CustomRectangleButton(
          onClick: () {
            Navigator.pop(ctx);
          },
          text: 'Ok',
          theme: 'dark',
          loading: false,
          disabled: false,
        )
      ],
    ),
  ).then((onValue) => {});
}
