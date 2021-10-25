import 'package:flap/screens/loader/loader.dart';
import 'package:flap/screens/main/body.dart';
import 'package:flap/screens/main/main.dart';
import 'package:flap/screens/main/unit.dart';
import 'package:flap/screens/profile/profile_screen.dart';
import 'package:flap/screens/welcome/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Requests/api_unit_requests.dart';
import 'constante.dart';

import 'package:flap/routes.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isAuth = true;

  @override
  initState() {
    super.initState();
    const storage = FlutterSecureStorage();
    storage.read(key: "access_token").then((value) {
      if (value == null) {
        setState(() {
          isAuth = true;
        });
      }
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FIURead',
      theme: ThemeData(
        scaffoldBackgroundColor: pColor,
        primaryColor: pColor,
        textTheme: GoogleFonts.montserratTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      initialRoute: isAuth ? WelcomeScreen.routeName : ProfileScreen.routeName,
      routes: routes,
    );
  }
}
