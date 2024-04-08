// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medimind_app/models/patients/patient_upcoming_appointment_model.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/auth/auth_icon_button.dart';
import 'package:medimind_app/widgets/patient/p_upcoming_appt_formfield.dart';
import 'package:provider/provider.dart';

class PatientUpcomingAppointmentScreen extends StatefulWidget {
  final VoidCallback refreshData;

  const PatientUpcomingAppointmentScreen({
    super.key,
    required this.refreshData,
  });

  @override
  State<PatientUpcomingAppointmentScreen> createState() =>
      _PatientUpcomingAppointmentScreenState();
}

class _PatientUpcomingAppointmentScreenState
    extends State<PatientUpcomingAppointmentScreen> {
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  late final PatientAppointment patientAppointment = PatientAppointment(
    doctorName: "",
    hospitalName: "",
    date: "",
    time: "",
  );

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
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
          "Add Appointment",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PatientUpcomingApptFormWidget(
                  labelText: "Choose a doctor",
                  controller: doctorController,
                ),
                PatientUpcomingApptFormWidget(
                  labelText: "Choose a hospital",
                  controller: hospitalController,
                ),
                PatientUpcomingApptFormWidget(
                  labelText: "Choose a date",
                  controller: dateController,
                ),
                PatientUpcomingApptFormWidget(
                  labelText: "Choose a time",
                  controller: timeController,
                ),
                AuthIconButton(
                  labelText: "Book Appointment",
                  isSvg: false,
                  icon: Icons.add,
                  onPress: () async {
                    try {
                      patientAppointment.doctorName = doctorController.text;
                      patientAppointment.hospitalName = hospitalController.text;
                      patientAppointment.date = dateController.text;
                      patientAppointment.time = timeController.text;

                      CollectionReference appointments = FirebaseFirestore
                          .instance
                          .collection("patient_upcoming_appointments")
                          .doc(user.uid)
                          .collection("appointment");

                      await appointments.add({
                        'doctorName': patientAppointment.doctorName,
                        'hospitalName': patientAppointment.hospitalName,
                        'date': patientAppointment.date,
                        'time': patientAppointment.time,
                      });
                      widget.refreshData();
                      Navigator.of(context).pop();
                    } catch (e) {
                      print('Error uploading appointment: $e');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
