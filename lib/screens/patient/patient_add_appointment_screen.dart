// ignore_for_file: avoid_print, use_build_context_synchronously

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medimind_app/models/patients/patient_upcoming_appointment_model.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/auth/auth_icon_button.dart';
import 'package:medimind_app/widgets/patient/p_upcoming_appt_formfield.dart';
import 'package:provider/provider.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';

class DoctorData {
  final String name;
  final String hospital;

  DoctorData({
    required this.name,
    required this.hospital,
  });
}

class PatientAddAppointmentScreen extends StatefulWidget {
  final VoidCallback refreshData;

  const PatientAddAppointmentScreen({
    super.key,
    required this.refreshData,
  });

  @override
  State<PatientAddAppointmentScreen> createState() =>
      _PatientAddAppointmentScreenState();
}

class _PatientAddAppointmentScreenState
    extends State<PatientAddAppointmentScreen> {
  final TextEditingController doctorController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  late Future<List<DoctorData>> doctorData;

  Future<List<DoctorData>> getDoctorsData() async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await FirebaseFirestore.instance.collection("doctors").get();

    return data.docs.map((item) {
      return DoctorData(
        name: item.data()["name"] as String,
        hospital: item.data()["doctor_hospital"] as String,
      );
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    doctorData = getDoctorsData();
  }

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
          child: FutureBuilder(
            future: doctorData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<DoctorData> doctorDataResult = snapshot.data!;
                return Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Choose a doctor"),
                      const SizedBox(height: 20),
                      CustomDropdown(
                        decoration: const CustomDropdownDecoration(
                          closedFillColor: Color.fromARGB(255, 255, 242, 242),
                        ),
                        items: doctorDataResult
                            .map((doctor) =>
                                '${doctor.name} - ${doctor.hospital}')
                            .toList(),
                        onChanged: (value) {
                          // final selectedDoctor = value as DoctorData;
                          // final doctorName = selectedDoctor.name;
                          // final hospitalName = selectedDoctor.hospital;
                          List<String> parts = value.split(' - ');
                          String doctorName = parts[0];
                          String hospitalName = parts[1];

                          print(doctorName);
                          print(hospitalName);

                          setState(() {
                            doctorController.text = doctorName;
                            hospitalController.text = hospitalName;
                          });
                        },
                        initialItem:
                            '${doctorDataResult[0].name} - ${doctorDataResult[0].hospital}',
                      ),
                      const SizedBox(height: 20),
                      PatientUpcomingApptFormWidget(
                        labelText: "Choose a date",
                        controller: dateController,
                        fieldType: 1,
                      ),
                      PatientUpcomingApptFormWidget(
                        labelText: "Choose a time",
                        controller: timeController,
                        fieldType: 2,
                      ),
                      AuthIconButton(
                        labelText: "Book Appointment",
                        isSvg: false,
                        icon: Icons.add,
                        onPress: () async {
                          try {
                            patientAppointment.doctorName =
                                doctorController.text;
                            patientAppointment.hospitalName =
                                hospitalController.text;
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
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
