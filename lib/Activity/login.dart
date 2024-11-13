import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kelompok/Activity/dashboard.dart';
import '../Provider/database_helper.dart';
import 'daftar.dart';
import 'resetpw.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    print("Login button pressed");

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      print("User signed in successfully");

      if (userCredential.user != null) {
        await DatabaseHelper.instance.storeUserUid(userCredential.user!.uid);
        print("UID stored in database: ${userCredential.user!.uid}");

        await FirebaseAnalytics.instance.logEvent(
          name: 'login',
          parameters: <String, Object>{
            'method': 'email',
          },
        );
        print("Login event sent to Firebase Analytics");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => myHome()),
        );
        print("Navigation to myHome triggered");
      }
    } on FirebaseAuthException catch (e) {
      print('Login Error: ${e.message}');
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message ?? 'Login Failed')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageWidth = screenWidth * 0.6;
    final double aspectRatio = 16 / 9;
    final double imageHeight = imageWidth / aspectRatio;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: 30),
            Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/logo.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Login",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w900,
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Sign in to continue",
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            _buildTextField('Email', _emailController, false),
            _buildTextField('Password', _passwordController, true),
            Row(
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(15.0),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text(
                              'Log in',
                              style: TextStyle(color: Colors.white),
                            ),
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => Resetpw()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Forgot password?',
                      style: TextStyle(
                        color: Color(0xFF107d72),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => DaftarPage()),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Register',
                      style: TextStyle(
                        color: Color(0xFF107d72),
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, bool obscure) {
    return Row(
      children: [
        Expanded(child: SizedBox()),
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: TextField(
              controller: controller,
              obscureText: obscure,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: label,
              ),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
