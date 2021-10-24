import 'dart:convert';

import 'package:dots_indicator/dots_indicator.dart';
import 'package:flap/Requests/api_register_requests.dart';
import 'package:flap/constante.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'body_third.dart';

class RegisterScreenBodySecond extends StatefulWidget {
  final String username;
  final String email;

  const RegisterScreenBodySecond({
    Key? key,
    required this.username,
    required this.email,
  }) : super(key: key);

  @override
  _RegisterScreenBodySecondState createState() =>
      _RegisterScreenBodySecondState();
}

class _RegisterScreenBodySecondState extends State<RegisterScreenBodySecond> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

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
      title: const Text("Alert"),
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
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Positioned(
              top: size.height * 0.35,
              left: size.width * 0.05,
              width: size.width * 0.8,
              child: const Text(
                "Enter your password",
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
                          controller: passwordController,
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
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
                        width: size.width * 0.8,
                        top: size.height * 0.17,
                        child: TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: passwordConfirmController,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 0.0),
                            ),
                            border: OutlineInputBorder(),
                            labelText: "Password confirmation",
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
                                    if (passwordController.text !=
                                        passwordConfirmController.text) {
                                      showAlertDialog(
                                          context, "Passwords doesn't match");
                                      return null;
                                    }
                                    Future<http.Response> registerStatus =
                                        registerUser(
                                      widget.username,
                                      widget.email,
                                      passwordConfirmController.text,
                                    ).then((value) {
                                      if (value.statusCode == 200) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return RegisterScreenBodyThird(
                                                username: widget.username,
                                                email: widget.email,
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        var responseData =
                                            jsonDecode(value.body);
                                        showAlertDialog(
                                            context, responseData["detail"]);
                                      }
                                      return value;
                                    });
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: size.height * 0.02,
                                        child: const Text(
                                          "Submit",
                                          style: TextStyle(color: Colors.white),
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
            Positioned(
              top: size.height * 0.57,
              left: size.width * 0.34,
              child: DotsIndicator(
                dotsCount: 4,
                position: 1,
                decorator: DotsDecorator(
                  color: pColor,
                  activeColor: pColor,
                  size: const Size.square(9.0),
                  activeSize: const Size(40.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
