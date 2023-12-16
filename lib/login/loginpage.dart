import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:room_chha/components/Textfield.dart';
import 'package:room_chha/components/button.dart';
import 'package:room_chha/homepage/HomeScree.dart';
import 'package:room_chha/signup/signup.dart';

class LoginScreem extends StatefulWidget {
  const LoginScreem({super.key});

  @override
  State<LoginScreem> createState() => _LoginScreemState();
}

class _LoginScreemState extends State<LoginScreem> {
  final TextEditingController _emailcontroller =
      TextEditingController(text: '');

  final TextEditingController _passwordcontroller =
      TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kotha Chha'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 200),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MainTextField(
                hinttext: 'email ',
                iconn: Icons.email,
                textEditingController: _emailcontroller),
            const SizedBox(
              height: 20,
            ),
            MainTextField(
                hinttext: 'enter the password',
                iconn: Icons.password,
                textEditingController: _passwordcontroller),
            const SizedBox(
              height: 20,
            ),
            ButtonB(
              nameofbutton: 'Login',
              ontap: () async {
                var LoginEmail =
                    _emailcontroller.text.toString().toLowerCase().trim();
                var LoginPassword =
                    _passwordcontroller.text.trim().toString().toLowerCase();
                try {
                  final Set<User?> firebaseUser = {
                    (await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: LoginEmail, password: LoginPassword))
                        .user,
                  };
                  // ignore: unnecessary_null_comparison
                  if (firebaseUser != null) {
                    // ignore: use_build_context_synchronously
                    (Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => const HomeScreen()))));
                  } else {
                    print('check your email and password');
                  }
                } on FirebaseAuthException catch (e) {
                  print("error on $e");
                }
              },
              colorofbutton: Colors.blueAccent,
              heightofbutton: 40,
              widthofbutton: 100,
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: const Text("doesn't have account ? signup"),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignupScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
