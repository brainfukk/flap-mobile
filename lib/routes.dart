import 'package:flap/screens/profile/profile_screen.dart';
import 'package:flap/screens/main/main.dart';
import 'package:flap/screens/search/main.dart';
import 'package:flap/screens/welcome/body.dart';
import 'package:flutter/material.dart';
import 'package:flap/screens/shop/shop_screen.dart';

final Map<String, WidgetBuilder> routes = {
  WelcomeScreen.routeName: (context) => const Scaffold(
        body: const WelcomeScreen(),
      ),
  TopicsScreen.routeName: (context) => const TopicsScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  ShopScreen.routeName: (context) => const ShopScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
};

final Map<String, WidgetBuilder> api = {
  WelcomeScreen.routeName: (context) => const Scaffold(
        body: const WelcomeScreen(),
      ),
  TopicsScreen.routeName: (context) => const TopicsScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  ShopScreen.routeName: (context) => const ShopScreen(),
};
