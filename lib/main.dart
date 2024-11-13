import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:kelompok/Activity/dashboard.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'Activity/daftar.dart';
import 'Activity/home.dart';
import 'Activity/login.dart';
import 'Provider/provider.dart';
import 'Provider/database_helper.dart';
import 'firebase_options.dart';
import 'dart:io' show Platform;

final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  bool isLoggedIn = await DatabaseHelper.instance.isUserLoggedIn();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => myProv()),
      ],
      child: MainApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MainApp extends StatelessWidget {
  final bool isLoggedIn;
  const MainApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [
        FirebaseAnalyticsObserver(analytics: analytics),
      ],
      theme: ThemeData.light().copyWith(
        useMaterial3: false,
        colorScheme: ColorScheme.light(
          primary: Color(0xFF107d72),
          secondary: Color(0xFF69C5B3),
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        useMaterial3: false,
        colorScheme: ColorScheme.dark(
          primary: Color(0xFF107d72),
          secondary: Color(0xFF69C5B3),
        ),
      ),
      themeMode: Provider.of<myProv>(context).isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: isLoggedIn ? '/myHome' : '/',
      routes: {
        '/': (context) => Myhome(),
        '/login': (context) => LoginPage(),
        '/daftar': (context) => DaftarPage(),
        '/myHome': (context) => myHome(),
      },
    );
  }
}
