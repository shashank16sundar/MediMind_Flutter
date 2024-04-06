import 'package:flutter/material.dart';

class DoctorPastAppointments extends StatefulWidget {
  const DoctorPastAppointments({super.key});

  @override
  State<DoctorPastAppointments> createState() => _DoctorPastAppointmentsState();
}

class _DoctorPastAppointmentsState extends State<DoctorPastAppointments> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.only(bottom: 20),
      height: 120,
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
    );
  }
}
