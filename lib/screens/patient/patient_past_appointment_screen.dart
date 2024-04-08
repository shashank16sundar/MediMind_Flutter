// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
// import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:http/http.dart' as http;

class PatientPastScreen extends StatefulWidget {
  final int appointmentID;

  const PatientPastScreen({
    Key? key,
    required this.appointmentID,
  }) : super(key: key);

  @override
  State<PatientPastScreen> createState() => _PatientPastScreenState();
}

class _PatientPastScreenState extends State<PatientPastScreen> {
  List<dynamic> files = [];
  List<dynamic> files2 = [];
  String summary = '';
  static const String baseUrl = 'https://763f-1-6-74-117.ngrok-free.app';

  void _sendSummarizeRequest() async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/api/summarize/2/${widget.appointmentID}'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        // Decode the response JSON
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
  void initState() {
    super.initState();
    getImageFromFlask();
    _sendSummarizeRequest();
  }

  Future<void> getImageFromFlask() async {
    final response = await http.get(
      Uri.parse(
        'https://763f-1-6-74-117.ngrok-free.app/api/sendFiles/2',
      ),
    );

    if (response.statusCode == 200) {
      print("290000");
      setState(() {
        files = jsonDecode(response.body)['files'];
        print(files);
      });
    } else {
      print("wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xffFFE2E2),
        title: const Text(
          'Get Your Report',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            const SizedBox(height: 20),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: files.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                String data = files[index]['data'];
                Uint8List bytes = base64.decode(data);
                return ListTile(
                  title: Image.memory(bytes),
                );
              },
            ),
            const SizedBox(height: 30),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
              child: Column(
                children: [
                  const Text(
                    "Your Summary",
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 20),
                  Text(summary),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
