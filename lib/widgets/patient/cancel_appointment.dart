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
    "A psychiatrist is a medical doctor specializing in mental health, diagnosing, and treating mental illnesses through therapy, medication, and other interventions, aiming to improve patients' mental well-being and overall quality of life.";

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Text(
              "MediMind",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        ],
      ), // Set background color to black
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
             'Appointment Details',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,), // Adjust text color
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            const CircleAvatar(
              radius: 80,
              backgroundImage: AssetImage('assets/logos/doctor_avatar.png'),
            ),
            SizedBox(height: 20),
            Text(
              '$doctorName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold), // Adjust text color
            ),
            SizedBox(height: 10),
            Text(
              doctorSummary,
              style: TextStyle(fontSize: 16,), // Adjust text color
            ),
            SizedBox(height: 10),
            Text(
              'Hospital: $hospitalName',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), // Adjust text color
            ),
            SizedBox(height: 10),
            Text(
              'Date: $appointmentDate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), // Adjust text color
            ),
            SizedBox(height: 10),
            Text(
              'Time: $appointmentTime',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), // Adjust text color
            ),
            SizedBox(height: 10),
            Text(
              'Previous Appointments: 5',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,), // Adjust text color
            ),
            Spacer(),
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
                    primary: Colors.black, // Set button color to black
                    onPrimary: Colors.white, // Set text color to white
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8), // Adjust button shape
                    ),
                  ),
                  child: const Padding(
                    padding:EdgeInsets.all(12.0),
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
