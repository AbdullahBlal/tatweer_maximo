import 'package:flutter/material.dart';
import 'package:tatweer_maximo/custom_functions/datetime_format.dart';
import 'package:tatweer_maximo/widgets/custom_text_field.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker(
      {super.key,
      required this.setSelectedValue,
      required this.label,
      required this.theme,
      required this.disabled,
      required this.selectedDate});

  final Function setSelectedValue;
  final String label;
  final String theme;
  final bool disabled;
  final dynamic selectedDate;

  State<CustomDatePicker> createState() {
    return _CustomDatePickerState();
  }
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final _dateController = TextEditingController();

  @override
  void initState() {
    _dateController.text = widget.selectedDate == null
        ? ''
        : displayDateFormatter.format(widget.selectedDate);
    super.initState();
  }

  void _persentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 100);
    final lastDate = DateTime.now();
    var pickedDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: lastDate,
        builder: (context, child) {
          //  here you can return  a child
          return Theme(
              data: Theme.of(context).copyWith(
                // override MaterialApp ThemeData
                colorScheme: ColorScheme.light(
                  primary: Theme.of(context)
                      .colorScheme
                      .secondary, //header and selced day background color
                  onPrimary: Colors.white, // titles and
                  onSurface: Theme.of(context)
                      .colorScheme
                      .secondary, // Month days , years
                ),
                textButtonTheme: TextButtonThemeData(
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context)
                        .colorScheme
                        .secondary, // ok , cancel    buttons
                  ),
                ),
              ),
              child: child!); // pass child to this child
        });

    pickedDate = pickedDate == null
        ? null
        : DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
          );
    setState(() {
      _dateController.text =
          pickedDate == null ? '' : displayDateFormatter.format(pickedDate);
    });
    widget.setSelectedValue(pickedDate, widget.label);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            label: widget.label,
            theme: widget.theme,
            controller: _dateController,
            required: true,
            disabled: true,
          ),
        ),
        IconButton(
            onPressed: widget.disabled ? () {} : _persentDatePicker,
            icon: const Icon(Icons.calendar_month)),
      ],
    );
  }
}
