// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flap/Requests/api_profile_data_request.dart';
import 'package:flap/Requests/api_unit_requests.dart';
import 'package:flap/constante.dart';
import 'package:flap/screens/exercise/components/answer_choice.dart';
import 'package:flap/screens/exercise/main.dart';
import 'package:flap/screens/main/unit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const storage = FlutterSecureStorage();

class ListOfItems extends StatefulWidget {
  final Function itemBuilder;
  final String title;
  final Function getObjects;
  final String? topicId;

  const ListOfItems({
    Key? key,
    required this.itemBuilder,
    required this.title,
    required this.getObjects,
    this.topicId,
  }) : super(key: key);

  @override
  _ListOfItemsState createState() => _ListOfItemsState();
}

class _ListOfItemsState extends State<ListOfItems> {
  var user = {};
  var objects = [];

  @override
  void initState() {
    super.initState();

    if (widget.title == "Topics") {
      widget.getObjects().then((value) {
        setState(() {
          objects = value;
        });
      });
    } else {
      widget.getObjects(widget.topicId).then((value) {
        setState(() {
          objects = value;
        });
      });
    }
    getUserInfo().then((value) {
      var data = jsonDecode(value.body);
      setState(() {
        user = data;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#F1F1F1"),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: size.width * 0.17,
                  height: size.height * 0.038,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: TextButton.styleFrom(
                      alignment: Alignment.topLeft,
                      primary: Colors.black,
                    ),
                    child: const Center(
                      child: Text(
                        "Back",
                        style: TextStyle(fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Stack(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: size.height * 0.025,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.8,
                  child: ListView.separated(
                    itemCount: objects.length,
                    separatorBuilder: (context, index) {
                      return SizedBox(
                        height: size.height * 0.01,
                      );
                    },
                    itemBuilder: (context, index) =>
                        widget.itemBuilder(context, index, objects, size),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ListOfItemsPlain extends StatefulWidget {
  final Function itemBuilder;
  final String title;
  final Function getObjects;
  final String? topicId;
  final String? unitId;
  final String? nextStepText;
  final Function? nextStepCallback;
  final Function? answersCallback;

  const ListOfItemsPlain({
    Key? key,
    required this.itemBuilder,
    required this.title,
    required this.getObjects,
    this.answersCallback,
    this.topicId,
    this.unitId,
    this.nextStepText,
    this.nextStepCallback,
  }) : super(key: key);

  @override
  _ListOfItemsPlainState createState() => _ListOfItemsPlainState();
}

class _ListOfItemsPlainState extends State<ListOfItemsPlain> {
  var user = {};
  var objects = [];
  var answers = [];

  @override
  void initState() {
    super.initState();

    Function? answersCallback = widget.answersCallback;

    if (answersCallback != null) {
      answersCallback(widget.unitId).then((value) {
        setState(() {
          answers = value;
        });
      });
    }

    if (widget.title == "Topics") {
      widget.getObjects().then((value) {
        setState(() {
          objects = value;
        });
      });
    } else if (widget.topicId != null) {
      widget.getObjects(widget.topicId).then((value) {
        setState(() {
          objects = value;
        });
      });
    } else if (widget.unitId != null) {
      widget.getObjects(widget.unitId).then((value) => {
            setState(() {
              objects = value;
            })
          });
    }
    getUserInfo().then((value) {
      var data = jsonDecode(value.body);
      setState(() {
        user = data;
      });
    });
  }

  defaultNextOnPress() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return ExerciseScreen(
        title: widget.title,
        unitId: widget.unitId.toString(),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    String nextStepText = "Go to exercises";
    Function onPressed_ = defaultNextOnPress;

    if (widget.nextStepText != null) {
      nextStepText = widget.nextStepText!;
      if (widget.nextStepCallback != null) {
        onPressed_ = widget.nextStepCallback!;
      }
    }
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: HexColor.fromHex("#F1F1F1"),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: SizedBox(
                  width: size.width * 0.17 * 3,
                  height: size.height * 0.038,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: const Center(
                          child: Text(
                            "Back",
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                      const Text("|"),
                      TextButton(
                        onPressed: () => onPressed_(),
                        style: TextButton.styleFrom(
                          primary: Colors.black,
                        ),
                        child: Center(
                          child: Text(
                            nextStepText,
                            style: TextStyle(fontSize: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            Column(
              children: [
                Text(
                  widget.title.trim(),
                  style: TextStyle(
                    fontSize: size.height * 0.025,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.8,
                  child: ListView.separated(
                      itemCount: objects.length,
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: size.height * 0.02,
                        );
                      },
                      itemBuilder: (context, index) {
                        return widget.itemBuilder(
                          context,
                          index,
                          objects,
                          size,
                          answers,
                        );
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
