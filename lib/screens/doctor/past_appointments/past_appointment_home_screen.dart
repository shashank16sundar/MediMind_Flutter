// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medimind_app/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:provider/provider.dart';

class PastAppointmentHomeScreen extends StatefulWidget {
  final int appointmentID;
  const PastAppointmentHomeScreen({
    Key? key,
    required this.appointmentID,
  }) : super(key: key);

  @override
  State<PastAppointmentHomeScreen> createState() =>
      _PastAppointmentHomeScreenState();
}

class _PastAppointmentHomeScreenState extends State<PastAppointmentHomeScreen> {
  String summary = '';
  String doctorNote = '';
  File? report;
  File? prescriptionImage;
  File? xRayScanImage;
  bool isNoteSubmitted = false;
  static const String baseUrl = 'https://763f-1-6-74-117.ngrok-free.app';

  void submitDoctorNote() {
    // You can implement the functionality to submit the note here
    print('Doctor note submitted: $doctorNote');
    setState(() {
      // Update the state to reflect the submitted note and set flag to true
      doctorNote = doctorNote;
      isNoteSubmitted = true;
    });
  }

  Widget buildDoctorNote() {
    return Visibility(
      visible: doctorNote.isNotEmpty, // Only visible when note is submitted
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 10),
          Text(
            'Doctor Note: $doctorNote',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _pickReport() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);

    if (result != null) {
      setState(() {
        report = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickPrescriptionImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        prescriptionImage = File(result.files.single.path!);
      });
    }
  }

  Future<void> _pickXRayScanImage() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() {
        xRayScanImage = File(result.files.single.path!);
      });
    }
  }

  void _sendSummarizeRequest(User user) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/api/summarize/2/${widget.appointmentID}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        setState(() {
          summary = jsonResponse['summary']['message'];
        });
      } else {
        setState(() {
          summary = 'Failed to get summary';
        });
      }
    } catch (e) {
      setState(() {
        summary = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Disable the default back arrow
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black, // Change the color of the arrow
          ),
          onPressed: () {
            // Define the action when the arrow is pressed
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: const Color(0xffFFE2E2),
        title: const Text(
          'Upload Medical Documents',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffAEDEFC),
                  onPrimary: Colors.black,
                ),
                onPressed: _pickReport,
                child: const Text('Upload Report (PDF)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffAEDEFC),
                  onPrimary: Colors.black,
                ),
                onPressed: _pickPrescriptionImage,
                child: const Text('Upload Prescription Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffAEDEFC),
                  onPrimary: Colors.black,
                ),
                onPressed: _pickXRayScanImage,
                child: const Text('Upload X-Ray Scan Image'),
              ),
              const SizedBox(height: 20),
              if (report != null) Text('Report: ${report!.path}'),
              if (prescriptionImage != null)
                Text('Prescription Image: ${prescriptionImage!.path}'),
              if (xRayScanImage != null)
                Text('X-Ray Scan Image: ${xRayScanImage!.path}'),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (report != null) {
                    APIService.sendReportToFlask(widget.appointmentID, report!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please upload the report')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffAEDEFC),
                  onPrimary: Colors.black,
                ),
                child: const Text("Send Report to Flask"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffAEDEFC),
                  onPrimary: Colors.black,
                ),
                onPressed: () {
                  if (prescriptionImage != null) {
                    APIService.sendPrescriptionImageToFlask(
                        widget.appointmentID, prescriptionImage!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content:
                              Text('Please upload the prescription image')),
                    );
                  }
                },
                child: const Text("Send Prescription Image to Flask"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffAEDEFC),
                  onPrimary: Colors.black,
                ),
                onPressed: () {
                  if (xRayScanImage != null) {
                    APIService.sendXRayScanImageToFlask(
                        widget.appointmentID, xRayScanImage!);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Please upload the X-ray scan image')),
                    );
                  }
                },
                child: const Text("Send X-Ray Scan Image to Flask"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: const Color(0xffAEDEFC),
                  onPrimary: Colors.black,
                ),
                onPressed: () {
                  // APIService.sendSummarizeRequestToFlask(widget.appointmentID);
                  _sendSummarizeRequest(user);
                },
                child: const Text("Summarize"),
              ),
              const SizedBox(height: 20),
              Text(summary),
              const SizedBox(height: 30),
              TextField(
                onChanged: (value) {
                  setState(() {
                    doctorNote = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: 'Add Note',
                  border: OutlineInputBorder(),
                ),
                maxLines: null,
                enabled: !isNoteSubmitted,
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  submitDoctorNote();
                },
                child: const Text('Add Note'),
              ),
              Visibility(
                visible: isNoteSubmitted,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Doctor Note: $doctorNote',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
