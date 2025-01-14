import 'package:flutter/material.dart';

class LoginFormInput extends StatefulWidget {
  const LoginFormInput(
      {required this.label,
      required this.secured,
      required this.controller,
      super.key,
      required this.theme,
      required this.icon,
      required this.maxLines});
  final Widget icon;
  final String label;
  final String theme;
  final bool secured;
  final int maxLines;
  final TextEditingController controller;
  @override
  State<LoginFormInput> createState() {
    return _LoginFormInputState();
  }
}

class _LoginFormInputState extends State<LoginFormInput> {
  @override
  Widget build(context) {
    Widget content = Theme(
      data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
        cursorColor: Theme.of(context).colorScheme.secondary,
        selectionColor: Theme.of(context).colorScheme.secondary,
        selectionHandleColor: Theme.of(context).colorScheme.secondary,
      )),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.label} is Required';
          } else {
            return null;
          }
        },
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.bottom,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        maxLines: widget.maxLines,
        obscureText: widget.secured,
        cursorColor: Theme.of(context).colorScheme.secondary,
        decoration: InputDecoration(
            prefixIcon: widget.icon,
            prefixIconColor: Theme.of(context).colorScheme.primary,
            filled: true,
            fillColor: Theme.of(context).colorScheme.tertiary,
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1.0,
                color: Theme.of(context).colorScheme.outline,
              ),
            ),
            labelText: widget.label,
            labelStyle:
                TextStyle(color: Theme.of(context).colorScheme.outline)),
      ),
    );

    // if (widget.theme == 'dark') {
    //   content = TextFormField(
    //     validator: (value) {
    //       if (value == null || value.isEmpty) {
    //         return '${widget.label} is Required';
    //       } else {
    //         return null;
    //       }
    //     },
    //     controller: widget.controller,
    //     style: TextStyle(
    //       color: Theme.of(context).colorScheme.secondary,
    //     ),
    //     obscureText: widget.secured,
    //     cursorColor: Theme.of(context).colorScheme.secondary,
    //     decoration: InputDecoration(
    //         filled: true,
    //         fillColor: Theme.of(context).colorScheme.primary,
    //         focusedBorder: OutlineInputBorder(
    //           borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
    //         ),
    //         enabledBorder: OutlineInputBorder(
    //           borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
    //         ),
    //         labelText: widget.label,
    //         labelStyle: TextStyle(color: Theme.of(context).colorScheme.secondary)),
    //   );
    // }
    return content;
  }
}
