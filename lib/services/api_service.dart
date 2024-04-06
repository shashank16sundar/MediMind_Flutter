// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class APIService {
  static const String baseUrl = 'https://763f-1-6-74-117.ngrok-free.app';

  static Future<Map<String, dynamic>> sendReportToFlask(
      int appointmentID, File report) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/api/pdf/2/$appointmentID'));

      request.fields['appointmentID'] = appointmentID.toString();

      request.files
          .add(await http.MultipartFile.fromPath('report', report.path));
      print("generating");
      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print(responseBody);

        var jsonResponse = json.decode(responseBody);
        print(jsonResponse);
        return jsonResponse;
      } else {
        return {'success': false, 'message': 'Failed to upload report'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  static Future<Map<String, dynamic>> sendPrescriptionImageToFlask(
      int appointmentID, File prescriptionImage) async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(
          '$baseUrl/api/prescription/2/$appointmentID',
        ),
      );

      request.fields['appointmentID'] = appointmentID.toString();

      request.files.add(await http.MultipartFile.fromPath(
          'prescriptionImage', prescriptionImage.path));

      var response = await request.send();
      print(response);

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var jsonResponse = json.decode(responseBody);
        print(jsonResponse);
        return jsonResponse;
      } else {
        return {'success': false, 'message': 'Failed to upload prescription'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  static Future<Map<String, dynamic>> sendXRayScanImageToFlask(
      int appointmentID, File xRayScanImage) async {
    try {
      var request = http.MultipartRequest(
          'POST', Uri.parse('$baseUrl/api/xray/2/${appointmentID}'));

      request.fields['appointmentID'] = appointmentID.toString();

      request.files.add(await http.MultipartFile.fromPath(
          'xRayScanImage', xRayScanImage.path));

      var response = await request.send();

      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        print(responseBody);
        var jsonResponse = json.decode(responseBody);
        print(jsonResponse);
        return jsonResponse;
      } else {
        return {'success': false, 'message': 'Failed to upload x-ray'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }

  static Future<Map<String, dynamic>> sendSummarizeRequestToFlask(
      int appointmentID) async {
    try {
      var response = await http.get(
        Uri.parse('$baseUrl/api/summarize/2/$appointmentID'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        return jsonResponse;
      } else {
        return {'success': false, 'message': 'Failed to summarize'};
      }
    } catch (e) {
      return {'success': false, 'message': 'Error: $e'};
    }
  }
}
