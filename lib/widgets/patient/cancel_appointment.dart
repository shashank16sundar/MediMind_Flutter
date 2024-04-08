import 'package:flutter/material.dart';

class CancelAppointment extends StatelessWidget {
  final String doctorName;
  final String hospitalName;
  final String appointmentDate;
  final String appointmentTime;

  const CancelAppointment({
    Key? key,
    required this.doctorName,
    required this.hospitalName,
    required this.appointmentDate,
    required this.appointmentTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Placeholder for doctor's summary
    String doctorSummary =
        "A psychiatrist is a medical doctor specializing in mental health, diagnosing, and treating mental illnesses.";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFFE2E2),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: Text(
              "MediMind",
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Appointment Details',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/logos/doctor_avatar.png'),
            ),
            const SizedBox(height: 20),
            Text(
              '$doctorName',
              style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold), // Adjust text color
            ),
            const SizedBox(height: 10),
            Text(
              doctorSummary,
              style: const TextStyle(
                fontSize: 16,
              ), // Adjust text color
            ),
            const SizedBox(height: 10),
            Text(
              'Hospital: $hospitalName',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
            ),
            const SizedBox(height: 10),
            Text(
              'Date: $appointmentDate',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
            ),
            const SizedBox(height: 10),
            Text(
              'Time: $appointmentTime',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
            ),
            const SizedBox(height: 10),
            const Text(
              'Previous Appointments: 5',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ), // Adjust text color
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Implement cancel appointment functionality here
                    // For now, let's just navigate back
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary:
                        const Color(0xffFFE2E2), // Set button color to black
                    onPrimary: Colors.black, // Set text color to white
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Adjust button shape
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Cancel Appointment',
                      style: TextStyle(fontSize: 16), // Adjust button text size
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
