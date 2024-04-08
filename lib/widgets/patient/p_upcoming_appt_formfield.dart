// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PatientUpcomingApptFormWidget extends StatefulWidget {
  final String labelText;
  final int fieldType;
  final TextEditingController controller;

  const PatientUpcomingApptFormWidget({
    super.key,
    required this.labelText,
    required this.controller,
    required this.fieldType,
  });

  @override
  State<PatientUpcomingApptFormWidget> createState() =>
      _PatientUpcomingApptFormWidgetState();
}

class _PatientUpcomingApptFormWidgetState
    extends State<PatientUpcomingApptFormWidget> {
  TimeOfDay? _selectedTime;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
          onTap: () async {
            if (widget.fieldType == 1) {
              DateTime date = DateTime(1900);
              FocusScope.of(context).requestFocus(FocusNode());

              date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100)) as DateTime;

              String formattedDate = DateFormat('yyyy-MM-dd').format(date);
              widget.controller.text = formattedDate;
            } else if (widget.fieldType == 2) {
              final TimeOfDay? pickedTime = await showTimePicker(
                context: context,
                initialTime: _selectedTime ?? TimeOfDay.now(),
              );

              if (pickedTime != null) {
                setState(() {
                  _selectedTime = pickedTime;
                  widget.controller.text = _selectedTime!.format(context);
                });
              }
            } else {}
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.blue),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.grey),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
