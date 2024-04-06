import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medimind_app/screens/doctor/doctor_profile/edit_doctor_profile_screen.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/auth/auth_icon_button.dart';
import 'package:provider/provider.dart';

class DoctorProfileScreen extends StatefulWidget {
  const DoctorProfileScreen({super.key});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  void onSignOut() {
    context.read<FirebaseAuthMethods>().signOut(context);
  }

  Map<String, dynamic> doctorData = {};

  Future<bool> doctorProfileCheck(User user) async {
    bool ans = await context.read<FirebaseAuthMethods>().checkDoctorProfile();

    if (ans) {
      await FirebaseFirestore.instance
          .collection('doctors')
          .doc(user.uid)
          .get()
          .then(
        (value) {
          doctorData = value.data()!;
        },
      );
    }
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return FutureBuilder<bool>(
      future: doctorProfileCheck(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == false) {
          return Center(
            child: AuthIconButton(
              labelText: 'Add Your Profile',
              isSvg: false,
              onPress: () async {
                final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditDoctorProfileScreen(
                      doctorData: {},
                    ),
                  ),
                );

                if (updatedData != null) {
                  setState(() {
                    doctorData = updatedData;
                  });
                }
              },
              icon: Icons.add,
            ),
          );
        }

        return Container(
          margin: const EdgeInsets.only(top: 20),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Your Profile",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () async {
                    final updatedData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditDoctorProfileScreen(
                          doctorData: {...doctorData},
                        ),
                      ),
                    );

                    if (updatedData != null) {
                      setState(() {
                        doctorData = updatedData;
                      });
                    }
                  },
                  child: Container(
                    width: 75,
                    height: 75,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                    child: const Icon(
                      Icons.edit,
                      size: 30,
                    ),
                  ),
                ),
                const SizedBox(height: 50),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Name"),
                        Text(
                          doctorData['name'] ?? 'Name not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Speciality"),
                        Text(
                          doctorData['speciality'] ?? 'Age not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Experience"),
                        Text(
                          doctorData['experience'] ??
                              'Experience not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Email"),
                        Text(
                          doctorData['email_id'] ?? 'Email not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Degrees"),
                        Text(
                          doctorData['degrees'] ?? 'Degrees not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Hospital"),
                        Text(
                          doctorData['doctor_hospital'] ??
                              'Hospital not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                AuthIconButton(
                  labelText: 'Sign Out',
                  isSvg: false,
                  onPress: onSignOut,
                  icon: Icons.sign_language,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
