import 'dart:convert';

import 'package:flap/Requests/api_profile_data_request.dart';
import 'package:flutter/material.dart';
import 'package:flap/constante.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/percent_indicator.dart';

class Item {
  Item({
    required this.index,
    this.expandedValue = "",
    this.headerValue = "",
    this.isExpanded = false,
  });

  int index;
  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems(numberOfItems) {
  return List<Item>.generate(numberOfItems, (int index) {
    return Item(
      index: index,
      expandedValue: 'This is item number $index',
    );
  });
}

class Notification {
  Notification({
    required this.headerValue,
    required this.datas,
    this.isExpanded = false,
  });

  String headerValue;
  List<Item> datas;
  bool isExpanded;
}

List<Notification> generateNotification(int numberOfItems) {
  return List<Notification>.generate(numberOfItems, (int index) {
    return Notification(headerValue: 'Notification', datas: generateItems(3));
  });
}

class NotificationBeta extends StatefulWidget {
  const NotificationBeta({Key? key}) : super(key: key);

  @override
  State<NotificationBeta> createState() => _MyStatefulWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _MyStatefulWidgetState extends State<NotificationBeta> {
  var notification = [];

  @override
  void initState() {
    super.initState();

    getUserNotification().then((value) {
      var data = jsonDecode(value.body);
      print(data);
      setState(() {
        notification = data;
      });
    });
  }

  // final List<Item> _data = generateItems(3);
  final List<Notification> _notification = generateNotification(1);
  final List<Item> _data = [];

  @override
  Widget build(BuildContext context) {
    var notif = [];

    if (notification.length > 0) {
      print(utf8.decode(notification[0]['message'].runes.toList()));
    }
    ;

    return SingleChildScrollView(
      child: Container(
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _notification[index].isExpanded = !isExpanded;
        });
      },
      children: _notification.map<ExpansionPanel>((Notification notif) {
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(notif.headerValue),
            );
          },
          body: Column(children: [
            for (var data in notification)
              if (data['is_hidden'] == false)
                ListTile(
                    title: Text(utf8.decode(data['message'].runes.toList())),
                    subtitle: Text(data["created_at"]),
                    trailing: const Icon(Icons.delete),
                    onTap: () {
                      setState(() {
                        notification
                            .removeWhere((currentItem) => data == currentItem);
                      });
                      putUserNotification(data['id']);
                    }),
          ]),
          isExpanded: notif.isExpanded,
        );
      }).toList(),
    );
  }
}
