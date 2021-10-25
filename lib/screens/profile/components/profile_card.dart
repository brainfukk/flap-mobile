import 'dart:convert';

import 'package:flap/Requests/api_profile_data_request.dart';
import 'package:flutter/material.dart';
import 'package:flap/constante.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flap/enums.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  var user = {};

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Coming soon..."),
      content: Text("Disabled. Technical update"),
      actions: [
        okButton,
      ],
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
  void initState() {
    super.initState();

    getUserInfo().then((value) {
      var data = jsonDecode(value.body);
      print(data);
      setState(() {
        user = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var username = "...";
    var points = 0;
    String avatar = "";

    if (user.containsKey("avatar")) {
      username = user['username'];
      points = user['points'];
      avatar = "${dotenv.env['API_HOST']}${user['avatar']['source']}";
    }

    final Color inActiveIconColor = const Color(0xFF292D32).withOpacity(0.5);
    final Color kPrimaryColor = HexColor.fromHex("#A07EC0");
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      primary: Colors.black87,
      minimumSize: Size(220, 36),
      padding: EdgeInsets.only(left: 20, right: 1),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    );

    return Container(
      height: height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: HexColor.fromHex("#4A0094"),
      ),
      child: LayoutBuilder(builder: (context, constaints) {
        double innerHeight = constaints.maxHeight;
        double innerWidth = constaints.maxWidth;

        return Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: innerHeight * 0.2,
                  decoration: BoxDecoration(
                      color: HexColor.fromHex("#6F1BC3"),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    style: flatButtonStyle,
                    // onPressed: () => Navigator.pushNamed(context, '/shop'),
                    onPressed: () {
                      showAlertDialog(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Shop',
                          style: TextStyle(color: Colors.white),
                        ),
                        SvgPicture.asset(
                          "assets/icons/profile_image.svg",
                          height: 100,
                          width: 100,
                          fit: BoxFit.scaleDown,
                          color: Colors.white,
                        )
                      ],
                    ),
                    // icon:
                  ),

                  // Text(
                  //   "Shop",
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  // IconButton(
                  //     icon: SvgPicture.asset("assets/icons/Vector.svg",
                  //         height: 150,
                  //         width: 150,
                  //         color: MenuState.shop == selectedMenu
                  //             ? kPrimaryColor
                  //             : inActiveIconColor),
                  //     onPressed: () =>
                  //         Navigator.pushNamed(context, '/shop'))
                )),
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8, top: 15),
                      child: CircleAvatar(
                        backgroundColor: HexColor.fromHex("#4A0094"),
                        radius: 52,
                        backgroundImage:
                            avatar.length > 0 ? NetworkImage(avatar) : null,
                      ),
                    ),
                    // child: Image.asset(
                    //   'assets/midoriya.gif',
                    //   width: 100,
                    //   height: 100,
                    // )),
                    Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(username,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20)),
                            Text(
                              "Level",
                              style: TextStyle(
                                  color: HexColor.fromHex("#DBDBDB"),
                                  fontSize: 11),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 5, right: 10),
                              child: LinearPercentIndicator(
                                width: innerWidth * 0.6,
                                lineHeight: 6.0,
                                percent: 0.5,
                                backgroundColor: HexColor.fromHex("#DBDBDB"),
                                progressColor: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Row(
                                children: [
                                  Image(
                                      image:
                                          AssetImage('assets/icons/coin.png')),
                                  Text(points.toString(),
                                      style: TextStyle(color: Colors.white))
                                ],
                              ),
                            )
                          ],
                        ))
                  ],
                )
              ],
            )),
          ],
        );
      }),
    );
  }
}
