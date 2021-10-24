import 'package:flap/Requests/api_unit_requests.dart';
import 'package:flap/constante.dart';
import 'package:flap/screens/main/body.dart';
import 'package:flap/screens/main/unit.dart';
import 'package:flutter/material.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      body: ListOfItems(
        getObjects: getTopics,
        title: "Topics",
        itemBuilder: (context, index, items, size) {
          var val = items[index];
          return UnitBox(
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
    );
  }
}

class UnitsScreen extends StatelessWidget {
  final String topicId;
  final String topicName;
  const UnitsScreen({
    Key? key,
    required this.topicId,
    required this.topicName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pColor,
      body: ListOfItems(
        topicId: topicId,
        getObjects: getUnits,
        title: '$topicName/Units',
        itemBuilder: (context, index, items, size) {
          var val = items[index];
          return UnitBox(
            content: val['short_content'],
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
                    return UnitTheoryScreen(
                      unitId: val['id'].toString(),
                      unitName: val['name'],
                    );
                  },
                ),
              );
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
