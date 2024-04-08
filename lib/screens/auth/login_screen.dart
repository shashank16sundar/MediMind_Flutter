import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medimind_app/widgets/auth/auth_icon_button.dart';
import 'package:provider/provider.dart';
import 'package:medimind_app/screens/auth/login_email_screen.dart';
import 'package:medimind_app/screens/auth/signup_email_screen.dart';
import 'package:medimind_app/services/firebase_auth_methods.dart';
import 'package:medimind_app/widgets/misc/or_divider_widget.dart';
import 'package:flutter/gestures.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void onGoogleSignIn() async {
    context.read<FirebaseAuthMethods>().signInWithGoogle(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8DC),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logos/MediMind_transparent.png',
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 30),
                AuthIconButton(
                  labelText: 'Sign in with Google',
                  isSvg: true,
                  icon: SvgPicture.asset(
                    'assets/svgs/google_svg.svg',
                    height: 40,
                  ),
                  onPress: onGoogleSignIn,
                ),
                const SizedBox(height: 15),
                AuthIconButton(
                  labelText: 'Sign in with Phone',
                  isSvg: false,
                  icon: Icons.phone,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const EmailPasswordLogin();
                      },
                    ));
                  },
                ),
                const OrDivider(),
                AuthIconButton(
                  labelText: 'Sign in with Email',
                  isSvg: false,
                  icon: Icons.email,
                  onPress: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) {
                        return const EmailPasswordLogin();
                      },
                    ));
                  },
                ),
                const SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "Don't have an account? ",
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                      color: Colors.black,
                    ),
                    children: [
                      TextSpan(
                        text: "Sign up now",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 33, 10, 164),
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const EmailPasswordSignup();
                                },
                              ),
                            );
                          },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
