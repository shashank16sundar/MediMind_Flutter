import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<String?> uploadFileAndGetDownloadUrl(
      String folder, File file, String fileExtension) async {
    try {
      // Upload file to Firebase Storage
      final fileName =
          '${DateTime.now().millisecondsSinceEpoch}.$fileExtension';
      final storageRef = firebase_storage.FirebaseStorage.instance
          .ref()
          .child(folder)
          .child(fileName);
      await storageRef.putFile(file);

      // Get download URL
      final downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Error uploading file: $e');
      return null;
    }
  }

  static Future<void> createAppointmentInFirestore(
      String userID,
      String doctorID,
      String prescriptionUrl,
      String reportUrl,
      String xrayUrl) async {
    try {
      // Add appointment details to Firestore with auto-generated document ID
      final appointmentRef =
          FirebaseFirestore.instance.collection('appointments').doc();
      await appointmentRef.set({
        'user_id': userID,
        'doctor_id': doctorID,
        'prescription_url': prescriptionUrl,
        'report_url': reportUrl,
        'xray_url': xrayUrl,
      });

      // Optionally, return the auto-generated appointment ID
      final appointmentID = appointmentRef.id;
      print('Created appointment with ID: $appointmentID');
    } catch (e) {
      print('Error creating appointment: $e');
    }
  }
}
