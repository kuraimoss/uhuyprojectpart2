import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'daftar.dart';
import 'login.dart';

class Myhome extends StatelessWidget {
  const Myhome({super.key});
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double imageWidth = screenWidth * 0.9;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(
              width: imageWidth,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage('https://firebasestorage.googleapis.com/v0/b/kesayangancoffe.firebasestorage.app/o/logo.png?alt=media&token=25652bcb-ad63-44aa-8380-07a363ebcdbb'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: Text(
                  "Selamat datang!!",
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
                  ),
                  textAlign: TextAlign.center,
                ))
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Sudah punya akun'),
                  ),
                ),
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Belum punya akun'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginPage()),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                      ),
                      child:
                          Text('Login', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ),
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => DaftarPage()),
                        );
                      },
                      style: ButtonStyle(
                        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0))),
                      ),
                      child: Text(
                        'Daftar',
                        style: TextStyle(color: Colors.white),
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
}
