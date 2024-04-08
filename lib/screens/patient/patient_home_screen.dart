import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medimind_app/models/patients/patient_upcoming_appointment_model.dart';
import 'package:medimind_app/screens/patient/patient_add_appointment_screen.dart';
import 'package:medimind_app/screens/profile/profile_screen.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/patient/patient_past_appointments.dart';
import 'package:medimind_app/widgets/patient/patient_upcoming_widget.dart';
import 'package:provider/provider.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void refreshData() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: const Color(0xffFFE2E2),
        leading: Image.asset(
          'assets/logos/brain.png',
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Text(
              "Hello, ${user.displayName ?? "user"}",
              style: const TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: _getPage(_selectedIndex, user, context, refreshData),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xffFFE2E2),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

Widget _getPage(
  int index,
  User user,
  BuildContext context,
  VoidCallback refreshData,
) {
  switch (index) {
    case 0:
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Upcoming Appointments",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(
                    width: 40,
                    height: 40,
                    child: FloatingActionButton(
                      elevation: 0,
                      backgroundColor: const Color(0xffFFE2E2),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return PatientAddAppointmentScreen(
                                refreshData: refreshData,
                              );
                            },
                          ),
                        );
                      },
                      child: const Icon(
                        Icons.add,
                        size: 35,
                        color: Color(0xff264653),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              FutureBuilder<QuerySnapshot>(
                future: FirebaseFirestore.instance
                    .collection("patient_upcoming_appointments")
                    .doc(user.uid)
                    .collection("appointment")
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text("Error - ${snapshot.error}");
                  } else {
                    final appointments = snapshot.data!.docs;
                    if (appointments.isEmpty) {
                      return Container(
                        decoration: BoxDecoration(
                          color: const Color(0xffFFE2E2),
                          borderRadius: BorderRadius.circular(25),
                        ),
                        width: 400,
                        height: 100,
                        child: const Center(
                          child: Text(
                            "No upcoming appointments! Yay!",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return SizedBox(
                        width: 400,
                        height: 210,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final appointmentData = appointments[index].data()
                                as Map<String, dynamic>;
                            final doctorName =
                                appointmentData['doctorName'] ?? '';
                            final hospitalName =
                                appointmentData['hospitalName'] ?? '';
                            final date = appointmentData['date'] ?? '';
                            final time = appointmentData['time'] ?? '';
                            final appointmentID = appointments[index].id;

                            PatientAppointment patientAppointment =
                                PatientAppointment(
                              doctorName: doctorName,
                              hospitalName: hospitalName,
                              date: date,
                              time: time,
                            );
                            return PatientUpcomingAppointmentWidget(
                              patientAppointment: patientAppointment,
                              appointmentID: appointmentID,
                              refreshData: refreshData,
                            );
                          },
                          itemCount: appointments.length,
                        ),
                      );
                    }
                  }
                },
              ),
              const SizedBox(height: 20),
              const Text(
                "Past Appointments",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              const Column(
                children: [
                  PatientPastAppointmentsWidget(
                    appointmentID: 1,
                  ),
                  PatientPastAppointmentsWidget(
                    appointmentID: 2,
                  ),
                  PatientPastAppointmentsWidget(
                    appointmentID: 3,
                  ),
                  PatientPastAppointmentsWidget(
                    appointmentID: 4,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    case 1:
      return const ProfileScreen();
    default:
      return Container();
  }
}
