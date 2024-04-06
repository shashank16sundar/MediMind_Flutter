import 'package:flutter/material.dart';
import 'package:medimind_app/screens/profile/profile_screen.dart';
import 'package:medimind_app/widgets/patient/patient_past_appointments.dart';
import 'package:medimind_app/widgets/patient/patient_upcoming_widget.dart';

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

  @override
  Widget build(BuildContext context) {
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
        actions: const [
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 20, 0),
            child: Text(
              "MediMind",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
        centerTitle: true,
      ),
      body: _getPage(_selectedIndex),
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

Widget _getPage(int index) {
  switch (index) {
    case 0:
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Text(
                "Hey Shashank,",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                "Upcoming Appointments",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 400,
                height: 210,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      const PatientUpcomingAppointmentWidget(),
                  itemCount: 4,
                ),
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
                  PatientPastAppointmentsWidget(),
                  PatientPastAppointmentsWidget(),
                  PatientPastAppointmentsWidget(),
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
