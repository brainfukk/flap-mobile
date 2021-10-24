import 'package:flap/enums.dart';
import 'package:flap/screens/main/body.dart';
import 'package:flap/screens/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flap/constante.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationBar extends StatelessWidget {
  const NavigationBar({
    Key? key,
    required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = const Color(0xFF292D32).withOpacity(0.5);
    final Color kPrimaryColor = HexColor.fromHex("#A07EC0");
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14),
      decoration: BoxDecoration(
          color: Colors.white70,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          boxShadow: [
            BoxShadow(
                offset: const Offset(0, -15),
                blurRadius: 20,
                color: const Color(0xFFDADADA).withOpacity(0.45)),
          ]),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
                icon: SvgPicture.asset("assets/icons/home-2.svg",
                    height: 120,
                    width: 120,
                    color: MenuState.home == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor),
                onPressed: () => Navigator.pushNamed(context, '/home')),
            IconButton(
                icon: SvgPicture.asset("assets/icons/menu.svg",
                    height: 120,
                    width: 120,
                    fit: BoxFit.scaleDown,
                    color: MenuState.menu == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor),
                onPressed: () =>
                    Navigator.pushNamed(context, MainScreen.routeName)),
            IconButton(
                icon: SvgPicture.asset("assets/icons/profile.svg",
                    height: 120,
                    width: 120,
                    fit: BoxFit.scaleDown,
                    color: MenuState.profile == selectedMenu
                        ? kPrimaryColor
                        : inActiveIconColor),
                onPressed: () =>
                    Navigator.pushNamed(context, ProfileScreen.routeName))
          ],
        ),
      ),
    );
  }
}
