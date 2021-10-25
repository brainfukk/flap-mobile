import 'package:flap/enums.dart';
import 'package:flutter/material.dart';
import 'package:flap/constante.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flap/screens/profile/components/profile_card.dart';
import 'package:flap/screens/profile/components/notification.dart';
import 'package:flap/screens/profile/components/units_progress.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flap/navigation_bar.dart';
import 'package:flap/enums.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static String routeName = '/profile';

  @override
  _ProfileScreen createState() => _ProfileScreen();
}

class _ProfileScreen extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 39),
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    ProfileCard(selectedMenu: MenuState.shop),
                    const SizedBox(height: 20),
                    // NotificationCard(
                    //     icon: 'assets/icons/arrow-circle-right.png',
                    //     text: 'Notifications',
                    //     press: () {}),
                    NotificationBeta(),
                    UnitsProgress(),
                  ],
                ))),
        bottomNavigationBar: NavigationBar(selectedMenu: MenuState.profile));
  }
}
