import 'package:dots_indicator/dots_indicator.dart';
import 'package:flap/constante.dart';
import 'package:flutter/material.dart';

import 'body_second.dart';

class RegisterScreenBody extends StatefulWidget {
  const RegisterScreenBody({Key? key}) : super(key: key);

  @override
  _RegisterScreenBodyState createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text("Ok"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Fields has been field incorrectly!"),
      content: const Text("Email or Name fields can't be empty"),
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
            top: size.height * 0.35,
            left: size.width * 0.05,
            width: size.width * 0.8,
            child: const Text(
              "Enter your name and e-mail",
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
                          labelText: "Name",
                        ),
                      ),
                    ),
                    Positioned(
                      left: size.width * 0.085,
                      width: size.width * 0.8,
                      top: size.height * 0.17,
                      child: TextFormField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          border: OutlineInputBorder(),
                          labelText: "E-mail",
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
                                  if (userNameController.text.length == 0 ||
                                      emailController.text.length == 0) {
                                    showAlertDialog(context);
                                    return null;
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return RegisterScreenBodySecond(
                                        username: userNameController.text,
                                        email: emailController.text,
                                      );
                                    }),
                                  );
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
          Positioned(
            top: size.height * 0.57,
            left: size.width * 0.34,
            child: DotsIndicator(
              dotsCount: 4,
              position: 0,
              decorator: DotsDecorator(
                color: pColor,
                activeColor: pColor,
                size: Size.square(9.0),
                activeSize: Size(40.0, 9.0),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
