import 'package:flutter/material.dart';
import 'package:medimind_app/screens/doctor/doctor_profile/doctor_profile_screen.dart';
import 'package:medimind_app/widgets/doctor/doctor_past_appointments.dart';
import 'package:medimind_app/widgets/doctor/doctor_upcoming_widgets.dart';

class DoctorHomeScreen extends StatefulWidget {
  const DoctorHomeScreen({super.key});

  @override
  State<DoctorHomeScreen> createState() => _DoctorHomeScreenState();
}

class _DoctorHomeScreenState extends State<DoctorHomeScreen> {
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
                "Hello Dr. Doof,",
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
                      const DoctorUpcomingWidgets(),
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
                  DoctorPastAppointments(
                    appointmentID: 1,
                  ),
                  DoctorPastAppointments(
                    appointmentID: 2,
                  ),
                  DoctorPastAppointments(
                    appointmentID: 3,
                  ),
                  DoctorPastAppointments(
                    appointmentID: 4,
                  ),
                ],
              )
            ],
          ),
        ),
      );
    case 1:
      return const DoctorProfileScreen();
    default:
      return Container();
  }
}
