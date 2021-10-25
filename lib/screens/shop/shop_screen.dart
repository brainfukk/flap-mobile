import 'package:flutter/material.dart';
import 'package:flap/constante.dart';
import 'package:flap/screens/shop/components/body.dart';
import 'package:flap/models/shop/card.dart';
import 'package:flap/screens/shop/components/shop_page.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);
  static String routeName = '/shop';

  @override
  _ShopScreen createState() => _ShopScreen();
}

class _ShopScreen extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildAppBar(context),
      body: ShopPage(),
    );
  }
}

AppBar buildAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: HexColor.fromHex("#6F1BC3"),
    title: Column(
      children: [
        Text(
          "My shop",
          style: TextStyle(color: Colors.white),
        ),
        Text(
          "${demoCards.length} items",
          style: TextStyle(color: Colors.white, fontSize: 12),
        ),
      ],
    ),
  );
}
