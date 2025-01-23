import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Provider/database_helper.dart';
import 'login.dart';

class DaftarPage extends StatefulWidget {
  const DaftarPage({super.key});

  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isLoading = false;

  Future<void> _register() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (userCredential.user != null) {
        await DatabaseHelper.instance.storeUserUid(userCredential.user!.uid);

        await FirebaseAnalytics.instance.logEvent(
          name: 'sign_up',
          parameters: <String, Object>{
            'method': 'email',
          },
        );
        print("Sign-up event sent to Firebase Analytics");

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => LoginPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      print('Error: ${e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration Failed')),
      );
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
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(5.0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    'https://firebasestorage.googleapis.com/v0/b/kesayangancoffe.firebasestorage.app/o/logo.png?alt=media&token=25652bcb-ad63-44aa-8380-07a363ebcdbb',
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Create new Account",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            _buildTextField('Email', _emailController, false),
            _buildTextField('Password', _passwordController, true),
            _buildTextField(
                'Retype Password', _confirmPasswordController, true),
            Row(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _register,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        padding: EdgeInsets.all(15.0),
                      ),
                      child: _isLoading
                          ? CircularProgressIndicator(color: Colors.white)
                          : Text('Register',
                              style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
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
                  label: Text(label)),
            ),
          ),
        ),
        Expanded(child: SizedBox()),
      ],
    );
  }
}
