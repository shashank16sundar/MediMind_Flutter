// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:medimind_app/models/patients/patient_upcoming_appointment_model.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';

class CancelAppointment extends StatefulWidget {
  final PatientAppointment patientAppointment;
  final String appointmentID;
  final VoidCallback refreshData;

  const CancelAppointment({
    Key? key,
    required this.patientAppointment,
    required this.appointmentID,
    required this.refreshData,
  }) : super(key: key);

  @override
  State<CancelAppointment> createState() => _CancelAppointmentState();
}

class _CancelAppointmentState extends State<CancelAppointment> {
  Future<void> deleteAppointment(BuildContext context, User user) async {
    try {
      await FirebaseFirestore.instance
          .collection("patient_upcoming_appointments")
          .doc(user.uid)
          .collection("appointment")
          .doc(widget.appointmentID)
          .delete();
      widget.refreshData();
      Navigator.pop(context);
    } catch (error) {
      print("Error deleting appointment: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;
    String doctorSummary =
        "A psychiatrist is a medical doctor specializing in mental health, diagnosing, and treating mental illnesses.";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFE2E2),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "View Appointment",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Appointment Details',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/logos/doctor_avatar.png'),
            ),
            const SizedBox(height: 20),
            Text(
              widget.patientAppointment.doctorName,
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold), // Adjust text color
            ),
            const SizedBox(height: 10),
            Text(
              doctorSummary,
              style: const TextStyle(
                fontSize: 16,
              ), // Adjust text color
            ),
            const SizedBox(height: 10),
            Text(
              'Hospital: ${widget.patientAppointment.hospitalName}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
            ),
            const SizedBox(height: 10),
            Text(
              'Date: ${widget.patientAppointment.date}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
            ),
            const SizedBox(height: 10),
            Text(
              'Time: ${widget.patientAppointment.time}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
            ),
            const SizedBox(height: 10),
            const Text(
              'Previous Appointments: 5',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    deleteAppointment(context, user);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: const Color(0xffFFE2E2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Cancel Appointment',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
