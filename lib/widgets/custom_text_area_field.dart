import 'package:flutter/material.dart';

class CustomTextAreaField extends StatefulWidget {
  const CustomTextAreaField(
      {required this.label,
      required this.secured,
      required this.controller,
      super.key,
      required this.theme,
      required this.maxLines,
      required this.required,
      required this.disabled});
  final String label;
  final String theme;
  final bool secured;
  final int maxLines;
  final TextEditingController controller;
  final bool disabled;
  final bool required;
  @override
  State<CustomTextAreaField> createState() {
    return _CustomTextAreaFieldState();
  }
}

class _CustomTextAreaFieldState extends State<CustomTextAreaField> {
  @override
  Widget build(context) {
    Widget content = Theme(
      data: Theme.of(context).copyWith(
          textSelectionTheme: TextSelectionThemeData(
        cursorColor: Theme.of(context).colorScheme.secondary,
        selectionColor: Theme.of(context).colorScheme.tertiary,
        selectionHandleColor: Theme.of(context).colorScheme.secondary,
      )),
      child: TextFormField(
        enabled: !widget.disabled,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            if ((value == null || value.isEmpty) && widget.required) {
              return '${widget.label} is Required';
            } else {
              return null;
            }
          },
          controller: widget.controller,
          textAlignVertical: TextAlignVertical.bottom,
          style: TextStyle(
            color: Theme.of(context).colorScheme.secondary,
          ),
          maxLines: widget.maxLines,
          obscureText: widget.secured,
          cursorColor: Theme.of(context).colorScheme.secondary,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1.0),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1.0),
              ),
              hintText: widget.label,
              filled: true,
              fillColor: Theme.of(context).colorScheme.tertiary,
              hintStyle: TextStyle(
                color: Theme.of(context).colorScheme.outline
              ),
              contentPadding: const EdgeInsets.all(10),
              )),
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
