import 'package:flutter/material.dart';

class PatientUpcomingApptFormWidget extends StatefulWidget {
  final String labelText;
  final TextEditingController controller;
  const PatientUpcomingApptFormWidget({
    super.key,
    required this.labelText,
    required this.controller,
  });

  @override
  State<PatientUpcomingApptFormWidget> createState() =>
      _PatientUpcomingApptFormWidgetState();
}

class _PatientUpcomingApptFormWidgetState
    extends State<PatientUpcomingApptFormWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelText),
        const SizedBox(height: 10),
        TextFormField(
          controller: widget.controller,
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
