import 'package:flap/constante.dart';
import 'package:flutter/material.dart';
import 'package:flap/models/shop/card.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  State<ShopPage> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<ShopPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            SizedBox(height: 15),
            Container(
                padding: EdgeInsets.only(right: 1),
                width: MediaQuery.of(context).size.width - 20,
                height: MediaQuery.of(context).size.height - 30,
                child: GridView.count(
                    crossAxisCount: 1,
                    primary: false,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 15,
                    childAspectRatio: 1.1,
                    children: [
                      for (var card in demoCards)
                        _buildCard(
                            card.id,
                            card.name,
                            card.imageRoute,
                            card.coinCost,
                            card.levelIndicator,
                            card.isBought,
                            card.buymethod,
                            context)
                    ]))
          ],
        ));
  }

  Widget _buildCard(int id, String name, String imageRoute, int coinCost,
      int levelIndicator, bool isBought, BuyMethod buymethod, context) {
    return Padding(
        padding: EdgeInsets.only(top: 10, bottom: 5, left: 5, right: 5),
        child: InkWell(
            onTap: () {},
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3,
                          blurRadius: 5)
                    ],
                    color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Hero(
                            tag: imageRoute,
                            child: Container(
                                height: 150.0,
                                width: 150.0,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(imageRoute),
                                        fit: BoxFit.contain)))),
                        Text(name,
                            style: TextStyle(
                                color: Color(0xFF575E67), fontSize: 18.0)),
                        Padding(
                            padding: EdgeInsets.only(right: 22),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image(
                                      image:
                                          AssetImage('assets/icons/coin.png')),
                                  Text(buymethod.coinCost.toString(),
                                      style: TextStyle(
                                          color: Color(0xFFCC8053),
                                          fontSize: 14.0)),
                                ])),
                      ],
                    ),

                    // Padding(
                    //     padding: EdgeInsets.all(8.0),
                    //     child:
                    //         Container(color: Color(0xFFEBEBEB), height: 1.0)),
                    ExpansionPanelList(
                        animationDuration: Duration(milliseconds: 400),
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            print(buymethod.isExpanded);
                            buymethod.isExpanded = !isExpanded;
                          });
                        },
                        children: [
                          ExpansionPanel(
                              backgroundColor: HexColor.fromHex("#6F1BC3"),
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: Text("Buy",
                                      style: TextStyle(color: Colors.white)),
                                );
                              },
                              body: Column(children: [
                                ListTile(
                                  title: Text(
                                      "Монеты - " +
                                          buymethod.coinCost.toString(),
                                      style: TextStyle(color: Colors.white)),
                                  // subtitle: const Text(
                                  //     'To delete this panel, tap the trash can icon'),
                                  trailing: const Icon(Icons.money),
                                  onTap: () {
                                    setState(() {
                                      print("Tapped#$id");
                                      const snackBar = SnackBar(
                                          content: Text(
                                              "You don't have enough money!"));

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                      // _data.removeWhere(
                                      //     (Item currentItem) => data == currentItem);
                                    });
                                  },
                                  dense: true,
                                ),
                                ListTile(
                                    title: Text(
                                        "Уровень - " +
                                            buymethod.levelCost.toString(),
                                        style: TextStyle(color: Colors.white)),
                                    // subtitle: const Text(
                                    //     'To delete this panel, tap the trash can icon'),
                                    trailing: const Icon(Icons.money),
                                    onTap: () {
                                      //   setState(() {
                                      //     _data.removeWhere(
                                      //         (Item currentItem) => data == currentItem);
                                      //   });
                                    },
                                    dense: true),
                              ]),
                              isExpanded: buymethod.isExpanded),
                        ])
                  ],
                ))));
  }
} 


// class BuyMethodPanel extends StatefulWidget {
//     final buymethod = new BuyMethod(isCoinAvailable: isCoinAvailable, coinCost: coinCost, isLevelAvailable: isLevelAvailable, levelCost: levelCost); 

//     const BuyMethodPanel({Key? key, required this.buymethod}) : super(key: key); 

//     @override
//     State<BuyMethodPanel> createState() => _MyStatefulWidgetState(buymethod);  
     
//   }


// class _MyStatefulWidgetState extends State<BuyMethodPanel> { 

//   final List<BuyMethod> buymethod = buymethod; 

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Container(
//         child: _buildPanel(),
//       ),
//     );
//   }

//   Widget _buildPanel() {
//     return ExpansionPanelList(
//       expansionCallback: (int index, bool isExpanded) {
//         setState(() {
//           buymethod.isExpanded = !isExpanded;
//         });
//       },
//       children: _notification.map<ExpansionPanel>((Notification notif) {
//         return ExpansionPanel(
//           headerBuilder: (BuildContext context, bool isExpanded) {
//             return ListTile(
//               title: Text(notif.headerValue),
//             );
//           },
//           body: Column(children: [
//             for (var data in _data)
//               ListTile(
//                   title: Text(data.expandedValue),
//                   subtitle: const Text(
//                       'To delete this panel, tap the trash can icon'),
//                   trailing: const Icon(Icons.delete),
//                   onTap: () {
//                     setState(() {
//                       _data.removeWhere(
//                           (Item currentItem) => data == currentItem);
//                     });
//                   }),
//           ]),
//           isExpanded: notif.isExpanded,
//         );
//       }).toList(),
//     );
//   }


// }