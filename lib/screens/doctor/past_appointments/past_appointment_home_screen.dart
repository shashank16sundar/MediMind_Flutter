import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:medimind_app/services/api_service.dart';
import 'package:http/http.dart' as http;

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
  File? report;
  File? prescriptionImage;
  File? xRayScanImage;
  static const String baseUrl = 'https://763f-1-6-74-117.ngrok-free.app';

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

  void _sendSummarizeRequest() async {
    try {
      var response = await http.get(
        Uri.parse(
            '$baseUrl/api/summarize/2/${widget.appointmentID}'), // Replace with your API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        // Decode the response JSON
        var jsonResponse = json.decode(response.body);
        setState(() {
          summary = jsonResponse['summary']['message'];
        });
      } else {
        // Request failed, show an error message
        setState(() {
          summary = 'Failed to get summary';
        });
      }
    } catch (e) {
      // Exception occurred, show an error message
      setState(() {
        summary = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Medical Documents'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: _pickReport,
                child: const Text('Upload Report (PDF)'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickPrescriptionImage,
                child: const Text('Upload Prescription Image'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
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
                child: const Text("Send Report to Flask"),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
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
              ElevatedButton(
                onPressed: () {
                  // APIService.sendSummarizeRequestToFlask(widget.appointmentID);
                  _sendSummarizeRequest();
                },
                child: Text("Summarize"),
              ),
              const SizedBox(height: 20),
              Text(summary),
            ],
          ),
        ),
      ),
    );
  }
}
