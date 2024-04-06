import 'package:flutter/material.dart';
import 'package:medimind_app/widgets/patient/patient_upcoming_widget.dart';

class PatientHomePage extends StatefulWidget {
  const PatientHomePage({super.key});

  @override
  State<PatientHomePage> createState() => _PatientHomePageState();
}

class _PatientHomePageState extends State<PatientHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: Colors.black,
        leading: Image.asset(
          'assets/logos/brain.png',
          fit: BoxFit.cover,
          width: 100,
          height: 100,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Text(
              "MediMind",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Upcoming Appointments",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 210,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    PatientUpcomingAppointmentWidget(),
                    PatientUpcomingAppointmentWidget(),
                    PatientUpcomingAppointmentWidget(),
                    PatientUpcomingAppointmentWidget(),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
