import 'dart:convert';

import 'package:flap/Requests/api_profile_data_request.dart';
import 'package:flutter/material.dart';
import 'package:flap/constante.dart';
import 'package:percent_indicator/percent_indicator.dart';

class UnitsProgress extends StatefulWidget {
  @override
  State<UnitsProgress> createState() => _UnitsProgressState();
}

class _UnitsProgressState extends State<UnitsProgress> {
  var unit_progess = [];

  @override
  void initState() {
    super.initState();

    getUnitProgess().then((value) {
      var data = jsonDecode(value.body);
      setState(() {
        unit_progess = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (unit_progess.length > 0) {
      print(unit_progess);
    }
    ;

    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Padding(
                padding: EdgeInsets.only(top: 30),
                child: Column(children: [
                  for (var data in unit_progess)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        CircularPercentIndicator(
                          radius: 170.0,
                          lineWidth: 9.0,
                          percent: data["progress"] * 0.01,
                          header: Text(data["topic_name"],
                              style: TextStyle(fontSize: 16)),
                          animation: true,
                          circularStrokeCap: CircularStrokeCap.round,
                          center: Padding(
                            padding: EdgeInsets.only(top: 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(data["unit"].toString(),
                                    style: TextStyle(fontSize: 90)),
                                Text("unit", style: TextStyle(fontSize: 16)),
                              ],
                            ),
                          ),
                          footer: Text(data["progress"].toString() + "%"),
                          progressColor: HexColor.fromHex("#6F1BC4"),
                        ),
                        SizedBox(
                          height: 50,
                        )
                        // Container(
                        //     width: width * 0.2,
                        //     height: height * 0.03,
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(20.0),
                        //       color: HexColor.fromHex("#F7EFFF"),
                        //     ),
                        //     child: Padding(
                        //         padding: EdgeInsets.only(top: 0),
                        //         child: Row(
                        //           crossAxisAlignment: CrossAxisAlignment.center,
                        //           mainAxisAlignment: MainAxisAlignment.center,
                        //           children: [Text("Перейти")],
                        //         )))
                      ],
                    ),
                ]))));
  }
}
