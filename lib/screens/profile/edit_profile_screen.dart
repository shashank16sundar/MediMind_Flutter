import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/auth/auth_icon_button.dart';
import 'package:medimind_app/widgets/auth/auth_textfield.dart';

class EditProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const EditProfileScreen({
    super.key,
    required this.userData,
  });

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  Map<String, dynamic> userData = {};

  @override
  void initState() {
    super.initState();
    userData = widget.userData;
  }

  Future<bool> getUserProfileDataFromFirebase(User user) async {
    final ans = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get()
        .then((value) {
      if (value.exists) {
        userData = value.data()!;
        return true;
      } else {
        return false;
      }
    });
    return ans;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController aadhaarController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController bloodController = TextEditingController();
  final TextEditingController genderController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return FutureBuilder(
      future: getUserProfileDataFromFirebase(user),
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

        nameController.text = userData['name'] ?? '';
        ageController.text = userData['age'] ?? '';
        heightController.text = userData['height'] ?? '';
        weightController.text = userData['weight'] ?? '';
        addressController.text = userData['address'] ?? '';
        aadhaarController.text = userData['aadhaar_id'] ?? '';
        genderController.text = userData['gender'] ?? '';
        bloodController.text = userData['blood_type'] ?? '';
        phoneController.text = userData['phone'] ?? '';

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
                      controller: ageController,
                      hintText: 'Enter Your Age',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: heightController,
                      hintText: 'Enter your height',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: weightController,
                      hintText: 'Enter your weight',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: aadhaarController,
                      hintText: 'Enter your aadhaar',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: addressController,
                      hintText: 'Enter your address',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: bloodController,
                      hintText: 'Enter your blood type',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: genderController,
                      hintText: 'Enter your gender',
                    ),
                    const SizedBox(height: 30),
                    AuthTextField(
                      controller: phoneController,
                      hintText: 'Enter your phone',
                    ),
                    const SizedBox(height: 30),
                    AuthIconButton(
                      labelText: 'Save',
                      isSvg: false,
                      icon: Icons.save,
                      onPress: () async {
                        final userID = user.uid;

                        final name = nameController.text;
                        final age = ageController.text;
                        final height = heightController.text;
                        final weight = weightController.text;
                        final aadhaar = aadhaarController.text;
                        final address = addressController.text;
                        final bloodType = bloodController.text;
                        final gender = genderController.text;
                        final phone = phoneController.text;

                        final userData = {
                          'name': name,
                          'age': age,
                          'height': height,
                          'weight': weight,
                          'aadhaar_id': aadhaar,
                          'address': address,
                          'blood_type': bloodType,
                          'gender': gender,
                          'phone': phone,
                        };

                        try {
                          await FirebaseFirestore.instance
                              .collection('users')
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
