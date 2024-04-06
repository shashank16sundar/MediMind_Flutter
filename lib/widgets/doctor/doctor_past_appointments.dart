import 'package:flutter/material.dart';
import 'package:medimind_app/screens/doctor/past_appointments/past_appointment_home_screen.dart';

class DoctorPastAppointments extends StatefulWidget {
  final int appointmentID;
  const DoctorPastAppointments({
    super.key,
    required this.appointmentID,
  });

  @override
  State<DoctorPastAppointments> createState() => _DoctorPastAppointmentsState();
}

class _DoctorPastAppointmentsState extends State<DoctorPastAppointments> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return PastAppointmentHomeScreen(
                appointmentID: widget.appointmentID,
              );
            },
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: const Color(0xffAEDEFC),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    "Shashank",
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                children: [
                  Text("Last Appointment Date : "),
                  Text("01/04/2024"),
                ],
              ),
              Text(
                "Apollo Hospitals, Magadi Road",
                style: TextStyle(
                  color: Color.fromARGB(255, 49, 49, 49),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
