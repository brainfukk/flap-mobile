import 'package:dots_indicator/dots_indicator.dart';
import 'package:flap/constante.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

class RegisterScreenBodyFourth extends StatelessWidget {
  const RegisterScreenBodyFourth({Key? key}) : super(key: key);

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
              width: size.width * 0.91,
              child: const Text(
                "Congratulations \nwith your new account!",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.45,
              left: size.width * 0.05,
              width: size.width * 0.8,
              child: const Text(
                "We are glad to see you on our platform ❤️️",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              top: size.height * 0.75,
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
                        width: size.width * 0.85,
                        top: size.height * 0.10,
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
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.arrow_back_outlined,
                                      color: Colors.grey,
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => MyApp(),
                                      ),
                                    );
                                  },
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        left: 0,
                                        top: size.height * 0.02,
                                        child: const Text(
                                          "Finish",
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
              top: size.height * 0.767,
              left: size.width * 0.34,
              child: DotsIndicator(
                dotsCount: 4,
                position: 3,
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
