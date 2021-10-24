import 'package:flap/constante.dart';
import 'package:flap/screens/Register/main.dart';
import 'package:flap/screens/login/body.dart';
import 'package:flap/screens/login/main.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: size.height * 0.35,
            left: size.width * 0.05,
            child: const Text(
              "Welcome!",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.41,
            left: size.width * 0.05,
            width: size.width * 0.6,
            child: const Text(
              "Log in to your account or create new to start using the app.",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.7,
            left: size.width * 0.05,
            width: size.width * 0.9,
            height: size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogInScreenWidget(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: size.height * 0.02,
                    child: const Text(
                      "LOG IN",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.width * 0.75,
                    bottom: size.height * 0.016,
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: HexColor.fromHex("#3F3F3F"),
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.78589,
            left: size.width * 0.05,
            width: size.width * 0.9,
            height: size.height * 0.06,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const RegisterScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: HexColor.fromHex("#4A0094"),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    bottom: size.height * 0.02,
                    child: const Text(
                      "REGISTER",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Positioned(
                    left: size.width * 0.75,
                    bottom: size.height * 0.016,
                    child: const Icon(
                      Icons.group_add_outlined,
                      color: Colors.white,
                      size: 24.0,
                      semanticLabel: 'Text to announce in accessibility modes',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
