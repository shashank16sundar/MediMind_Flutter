import 'package:flutter/material.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/auth_icon_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void onSignOut() {
    context.read<FirebaseAuthMethods>().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Hello"),
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
  }
}
