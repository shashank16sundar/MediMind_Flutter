import 'package:flutter/material.dart';
import 'package:medimind_app/widgets/patient/cancel_appointment.dart';

class PatientUpcomingAppointmentWidget extends StatelessWidget {
  const PatientUpcomingAppointmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CancelAppointment(
              doctorName: 'Dr. DoLittle', // Provide the doctor's name here
              hospitalName:
                  'Fortis Hospital', // Provide the hospital's name here
              appointmentDate:
                  '2024-04-07', // Provide the appointment date here
              appointmentTime: '14:00', // Provide the appointment time here
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        width: 300,
        decoration: BoxDecoration(
          color: const Color(0xffAEDEFC),
          borderRadius: BorderRadius.circular(20),
        ),
        child: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/logos/doctor_avatar.png',
                    ),
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dr. DoLittle',
                        style: TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      Text(
                        'Psychiatrist',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.pin_drop_rounded,
                        color: Colors.black,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Fortis Hospital',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.black,
                      ),
                      SizedBox(width: 20),
                      Text(
                        'Today',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.more_time,
                        color: Colors.black,
                      ),
                      SizedBox(width: 20),
                      Text(
                        '14:00',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
