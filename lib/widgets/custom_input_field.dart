  import 'package:flutter/material.dart';

  class CustomInputField extends StatefulWidget {
    const CustomInputField(this.label, this.secured, this.controller,
        {super.key, required this.theme});
    final String label;
    final String theme;
    final bool secured;
    final TextEditingController controller;
    @override
    State<CustomInputField> createState() {
      return _CustomInputFieldState();
    }
  }

  class _CustomInputFieldState extends State<CustomInputField> {
    @override
    Widget build(context) {
      Widget content = TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '${widget.label} is Required';
          } else {
            return null;
          }
        },
        controller: widget.controller,
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
        ),
        obscureText: widget.secured,
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
            filled: true,
            fillColor: Theme.of(context).colorScheme.tertiary,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
            ),
            labelText: widget.label,
            labelStyle: TextStyle(color: Theme.of(context).colorScheme.primary)),
      );

      if (widget.theme == 'dark') {
        content = TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return '${widget.label} is Required';
            } else {
              return null;
            }
          },
          controller: widget.controller,
          style: TextStyle(
            color: Theme.of(context).colorScheme.tertiary,
          ),
          obscureText: widget.secured,
          cursorColor: Theme.of(context).colorScheme.tertiary,
          decoration: InputDecoration(
              filled: true,
              fillColor: Theme.of(context).colorScheme.primary,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).colorScheme.primary, width: 1.0),
              ),
              labelText: widget.label,
              labelStyle: TextStyle(color: Theme.of(context).colorScheme.tertiary)),
        );
      }
      return content;
    }
  }
