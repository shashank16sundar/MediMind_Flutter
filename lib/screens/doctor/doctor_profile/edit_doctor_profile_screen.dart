import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/auth/auth_icon_button.dart';
import 'package:medimind_app/widgets/auth/auth_textfield.dart';
import 'package:provider/provider.dart';

class EditDoctorProfileScreen extends StatefulWidget {
  final Map<String, dynamic> doctorData;

  const EditDoctorProfileScreen({
    super.key,
    required this.doctorData,
  });

  @override
  State<EditDoctorProfileScreen> createState() =>
      _EditDoctorProfileScreenState();
}

class _EditDoctorProfileScreenState extends State<EditDoctorProfileScreen> {
  Map<String, dynamic> doctorData = {};

  @override
  void initState() {
    super.initState();
    doctorData = widget.doctorData;
  }

  Future<bool> getDoctorProfileDataFromFirebase(User user) async {
    final ans = await FirebaseFirestore.instance
        .collection('doctors')
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        doctorData = value.data()!;
        return true;
      } else {
        return false;
      }
    });
    return ans;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController degreesController = TextEditingController();
  final TextEditingController hospitalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return FutureBuilder(
      future: getDoctorProfileDataFromFirebase(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        nameController.text = doctorData['name'] ?? '';
        specialityController.text = doctorData['speciality'] ?? '';
        experienceController.text = doctorData['experience'] ?? '';
        emailController.text = doctorData['email_id'] ?? '';
        degreesController.text = doctorData['degrees'] ?? '';
        hospitalController.text = doctorData['doctor_hospital'] ?? '';

        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 80),
                child: Column(
                  children: [
                    const Text(
                      "Edit Your Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: nameController,
                      hintText: 'Enter Your Name',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: specialityController,
                      hintText: 'Enter Your Speciality',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: experienceController,
                      hintText: 'Enter your experience',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: emailController,
                      hintText: 'Enter your email',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: degreesController,
                      hintText: 'Enter your degrees',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: hospitalController,
                      hintText: 'Enter your hospital',
                    ),
                    const SizedBox(height: 30),
                    AuthIconButton(
                      labelText: 'Save',
                      isSvg: false,
                      icon: Icons.save,
                      onPress: () async {
                        final userID = user.uid;

                        final name = nameController.text;
                        final speciality = specialityController.text;
                        final experience = experienceController.text;
                        final email = emailController.text;
                        final degrees = degreesController.text;
                        final hospital = hospitalController.text;

                        final userData = {
                          'name': name,
                          'speciality': speciality,
                          'experience': experience,
                          'email_id': email,
                          'degrees': degrees,
                          'doctor_hospital': hospital,
                        };

                        try {
                          await FirebaseFirestore.instance
                              .collection('doctors')
                              .doc(userID)
                              .set(userData);

                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, userData);
                        } catch (e) {}
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
