import 'dart:convert';

import 'package:flap/Requests/api_profile_data_request.dart';
import 'package:flap/Requests/api_unit_requests.dart';
import 'package:flap/constante.dart';
import 'package:flap/screens/main/body.dart';
import 'package:flap/screens/main/unit.dart';
import 'package:flutter/material.dart';
import 'package:flap/navigation_bar.dart';
import 'package:flap/enums.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: ListOfItems(
          getObjects: getTopics,
          title: "Topics",
          itemBuilder: (context, index, items, size) {
            var val = items[index];
            return UnitBox(
              isDiabled: false,
              content: val['description'],
              width: size.width * 0.92,
              height: size.height * 0.11,
              unitTitle: val['name'],
              progress: val['progress'].toString(),
              answeredQuestions: '--',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UnitsScreen(
                        topicId: val['id'].toString(),
                        topicName: val['name'],
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: NavigationBar(selectedMenu: MenuState.menu));
  }
}

class UnitsScreen extends StatefulWidget {
  final String topicId;
  final String topicName;
  const UnitsScreen({
    Key? key,
    required this.topicId,
    required this.topicName,
  }) : super(key: key);

  @override
  State<UnitsScreen> createState() => _UnitsScreenState();
}

class _UnitsScreenState extends State<UnitsScreen> {
  var user = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserInfo().then((value) {
      var data = jsonDecode(value.body);
      setState(() {
        user = data;
      });
    });
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Alert"),
      content: Text(msg),
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
    return Scaffold(
      backgroundColor: pColor,
      body: ListOfItems(
        topicId: widget.topicId,
        getObjects: getUnits,
        title: '${widget.topicName}/Units',
        itemBuilder: (context, index, items, size) {
          var val = items[index];

          var isDisabled = false;

          print(user);
          if (user.containsKey("plan")) {
            if (val['access_plan'] == 'PREMIUM_PLAN' &&
                user['plan'] == 'FREE_PLAN') {
              isDisabled = true;
            }
          }
          return UnitBox(
            isDiabled: isDisabled,
            content: val['short_content'],
            width: size.width * 0.92,
            height: size.height * 0.11,
            unitTitle: val['name'],
            progress: val['progress'].toString(),
            answeredQuestions: '--',
            onPressed: () {
              if (!isDisabled) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return UnitTheoryScreen(
                        unitId: val['id'].toString(),
                        unitName: val['name'],
                      );
                    },
                  ),
                );
              } else {
                showAlertDialog(
                  context,
                  "У вас нет прав просматривать данный юнит, пожалуйста обновте свою подписку до премиума, чтобы просмотреть данный юнит.",
                );
              }
            },
          );
        },
      ),
    );
  }
}

class UnitTheoryScreen extends StatelessWidget {
  final String unitId;
  final String unitName;
  const UnitTheoryScreen({
    Key? key,
    required this.unitId,
    required this.unitName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      body: Container(
        child: ListOfItemsPlain(
          unitId: unitId,
          getObjects: getUnitElements,
          title: unitName,
          itemBuilder: (context, index, items, size, answers) {
            var val = items[index];
            if (val['type'] == 'PLAIN_TEXT_VIEW') {
              return TextComponent(
                content: val['content'],
                width: size.width * 0.92,
                height: size.height * 0.11,
              );
            } else if (val['type'] == 'HEADING') {
              return HeadingComponent(
                content: val['content'],
                width: size.width * 0.92,
                height: size.height * 0.11,
              );
            } else if (val['type'] == 'IMAGE_VIEW') {
              return ImageComponent(
                source: val['image'],
                width: size.width * 0.92,
                height: size.height * 0.11,
              );
            } else if (val['type'] == 'LIST_VIEW') {
              return ListComponent(
                content: val['content'],
                width: size.width * 0.92,
                height: size.height * 0.11,
              );
            }
          },
        ),
      ),
    );
  }
}

class UnitExerciesScreen extends StatelessWidget {
  final String unitId;
  final String unitName;

  const UnitExerciesScreen({
    Key? key,
    required this.unitId,
    required this.unitName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      body: ListOfItemsPlain(
        unitId: unitId,
        getObjects: getUnitElements,
        title: unitName,
        itemBuilder: (context, index, items, size, builderAnswers) {
          var val = items[index];
          if (val['type'] == 'PLAIN_TEXT_VIEW') {
            return TextComponent(
              content: val['content'],
              width: size.width * 0.92,
              height: size.height * 0.11,
            );
          } else if (val['type'] == 'HEADING') {
            return HeadingComponent(
              content: val['content'],
              width: size.width * 0.92,
              height: size.height * 0.11,
            );
          } else if (val['type'] == 'IMAGE_VIEW') {
            return ImageComponent(
              source: val['image'],
              width: size.width * 0.92,
              height: size.height * 0.11,
            );
          } else if (val['type'] == 'LIST_VIEW') {
            return ListComponent(
              content: val['content'],
              width: size.width * 0.92,
              height: size.height * 0.11,
            );
          }
        },
      ),
    );
  }
}

class DottedText extends Text {
  const DottedText(
    String data, {
    Key? key,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    double? textScaleFactor,
    int? maxLines,
    String? semanticsLabel,
  }) : super(
          '\u2022 $data',
          key: key,
          style: style,
          textAlign: textAlign,
          textDirection: textDirection,
          locale: locale,
          softWrap: softWrap,
          overflow: overflow,
          textScaleFactor: textScaleFactor,
          maxLines: maxLines,
          semanticsLabel: semanticsLabel,
        );
}
