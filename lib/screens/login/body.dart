import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flap/Requests/api_login_requests.dart';
import 'package:flap/Requests/api_unit_requests.dart';
import 'package:flap/constante.dart';
import 'package:flap/screens/main/body.dart';
import 'package:flap/screens/main/main.dart';
import 'package:flap/screens/main/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  showAlertDialog(BuildContext context, String msg) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Error"),
      content: Text(msg),
      actions: [okButton],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Stack(
        children: [
          Positioned(
            top: size.height * 0.30,
            left: size.width * 0.05,
            width: size.width * 0.8,
            child: const Text(
              "Enter your username and password",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.55,
            width: size.width,
            height: size.height,
            child: SizedBox(
              height: size.height * 0.3,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: size.width * 0.085,
                      width: size.width * 0.8,
                      top: size.height * 0.07,
                      child: TextFormField(
                        controller: userNameController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Username",
                        ),
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.085,
                      width: size.width * 0.8,
                      top: size.height * 0.17,
                      child: TextFormField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: passwordController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "Password",
                        ),
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.085,
                      width: size.width * 0.85,
                      top: size.height * 0.27,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: HexColor.fromHex("#EFEFEF"),
                            ),
                            child: SizedBox(
                              height: size.height * 0.06,
                              width: size.width * 0.14,
                              child: Center(
                                child: IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: const Icon(
                                    Icons.arrow_back_outlined,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            left: size.width * 0.17,
                            width: size.width * 0.635,
                            height: size.height * 0.06,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: HexColor.fromHex("#EFEFEF"),
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  if (userNameController.text.isEmpty ||
                                      passwordController.text.isEmpty) {
                                    showAlertDialog(context,
                                        "Username or password can't be empty");
                                    return null;
                                  }
                                  loginUser(
                                    userNameController.text,
                                    passwordController.text,
                                  ).then((value) async {
                                    var data = jsonDecode(value.body);
                                    if (value.statusCode == 200) {
                                      await storage.write(
                                          key: "access_token",
                                          value: data["access"]);
                                      await storage.write(
                                          key: "refresh_token",
                                          value: data["refresh"]);
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) {
                                          return const TopicsScreen();
                                        }),
                                      );
                                    } else {
                                      showAlertDialog(context, data["detail"]);
                                    }
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: size.height * 0.02,
                                      child: const Text(
                                        "Continue",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      top: size.height * 0.015,
                                      child: const Icon(
                                        Icons.arrow_forward_outlined,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: pColor,
                                  elevation: 0.0,
                                  shadowColor: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
