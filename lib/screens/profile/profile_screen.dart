import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:medimind_app/screens/profile/edit_profile_screen.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/auth/auth_icon_button.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void onSignOut() {
    context.read<FirebaseAuthMethods>().signOut(context);
  }

  Map<String, dynamic> userData = {};

  Future<bool> profileCheck(User user) async {
    bool ans = await context.read<FirebaseAuthMethods>().checkProfile();

    if (ans) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get()
          .then(
        (value) {
          userData = value.data()!;
        },
      );
    }
    return ans;
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<FirebaseAuthMethods>().user;

    return FutureBuilder<bool>(
      future: profileCheck(user),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == false) {
          return Center(
            child: AuthIconButton(
              labelText: 'Add Profile',
              isSvg: false,
              onPress: () async {
                final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfileScreen(
                      userData: {},
                    ),
                  ),
                );

                if (updatedData != null) {
                  setState(() {
                    userData = updatedData;
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
                GestureDetector(
                  onTap: () async {
                    final updatedData = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileScreen(
                          userData: {...userData},
                        ),
                      ),
                    );

                    if (updatedData != null) {
                      setState(() {
                        userData = updatedData;
                      });
                    }
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.yellow,
                    ),
                    child: const Icon(Icons.edit),
                  ),
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Name"),
                        Text(
                          userData['name'] ?? 'Name not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Age"),
                        Text(
                          userData['age'] ?? 'Age not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Height"),
                        Text(
                          userData['height'] ?? 'Height not available',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
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
