import 'package:flutter/material.dart';

import 'package:medimind_app/models/patients/patient_upcoming_appointment_model.dart';
import 'package:medimind_app/widgets/patient/cancel_appointment.dart';

class PatientUpcomingAppointmentWidget extends StatefulWidget {
  final PatientAppointment patientAppointment;
  final String appointmentID;
  final VoidCallback refreshData;

  const PatientUpcomingAppointmentWidget({
    Key? key,
    required this.patientAppointment,
    required this.appointmentID,
    required this.refreshData,
  }) : super(key: key);

  @override
  State<PatientUpcomingAppointmentWidget> createState() =>
      _PatientUpcomingAppointmentWidgetState();
}

class _PatientUpcomingAppointmentWidgetState
    extends State<PatientUpcomingAppointmentWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CancelAppointment(
              patientAppointment: widget.patientAppointment,
              appointmentID: widget.appointmentID,
              refreshData: widget.refreshData,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          child: Column(
            children: [
              Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(
                      'assets/logos/doctor_avatar.png',
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.patientAppointment.doctorName,
                        style:
                            const TextStyle(color: Colors.black, fontSize: 22),
                      ),
                      const Text(
                        'Psychiatrist',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.pin_drop_rounded,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.patientAppointment.hospitalName,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.calendar_month_sharp,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.patientAppointment.date,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.more_time,
                        color: Colors.black,
                      ),
                      const SizedBox(width: 20),
                      Text(
                        widget.patientAppointment.time,
                        style: const TextStyle(
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
