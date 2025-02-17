import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {required this.label,
      required this.controller,
      super.key,
      required this.theme,
      required this.required,
      required this.disabled});
  final String label;
  final String theme;
  final TextEditingController controller;
  final bool disabled;
  final bool required;
  @override
  State<CustomTextField> createState() {
    return _CustomTextFieldState();
  }
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(context) {
    Widget content = Theme(
      data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
        cursorColor: Theme.of(context).colorScheme.primary,
        selectionColor: Theme.of(context).colorScheme.tertiary,
        selectionHandleColor: Theme.of(context).colorScheme.primary,
      )),
      child: TextFormField(
        textCapitalization: TextCapitalization.words,
        readOnly: widget.disabled,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if ((value == null || value.isEmpty) && widget.required) {
            return '${widget.label} is Required';
          } else {
            return null;
          }
        },
        controller: widget.controller,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          filled: true,
          fillColor: Theme.of(context).colorScheme.tertiary,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0.5,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          labelText: widget.label,
          labelStyle: TextStyle(color: Theme.of(context).colorScheme.outline),
        ),
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
