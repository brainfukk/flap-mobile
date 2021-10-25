import 'dart:ui';

import 'package:flap/constante.dart';
import 'package:flap/screens/main/main.dart';
import 'package:flutter/material.dart';

class UnitBox extends StatefulWidget {
  final double width;
  final double height;
  final String unitTitle;
  final String progress;
  final String answeredQuestions;
  final String content;
  final void Function()? onPressed;
  final bool isDiabled;

  const UnitBox({
    Key? key,
    required this.width,
    required this.height,
    required this.unitTitle,
    required this.progress,
    required this.answeredQuestions,
    required this.onPressed,
    required this.content,
    required this.isDiabled,
  }) : super(key: key);

  @override
  _UnitBoxState createState() => _UnitBoxState();
}

class _UnitBoxState extends State<UnitBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: HexColor.fromHex("#F1F1F1"),
        borderRadius: BorderRadius.circular(18),
      ),
      child: TextButton(
        onPressed: widget.onPressed,
        child: SizedBox(
          width: widget.width,
          height: widget.height,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      widget.unitTitle,
                      style: TextStyle(
                        fontSize: widget.height * 0.15,
                        color: widget.isDiabled ? Colors.grey : Colors.black,
                      ),
                    ),
                    SizedBox(width: widget.width * 0.04),
                    Container(
                      decoration: BoxDecoration(
                        color: HexColor.fromHex("#C4C4C4"),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      child: SizedBox(
                        height: widget.height * 0.17,
                        width: widget.width * 0.12,
                        child: Center(
                          child: Text(
                            '${widget.progress}%',
                            style: TextStyle(
                              fontSize: widget.height * 0.11,
                              color:
                                  widget.isDiabled ? Colors.grey : Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: widget.width * 0.03),
                    Text(
                      widget.answeredQuestions,
                      style: TextStyle(
                        fontSize: widget.height * 0.11,
                        color: widget.isDiabled ? Colors.grey : Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: widget.height * 0.2,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.content,
                    style: TextStyle(
                      color: widget.isDiabled
                          ? Colors.grey
                          : HexColor.fromHex("#646464"),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HeadingComponent extends StatelessWidget {
  final double width;
  final double height;
  final String content;

  const HeadingComponent({
    Key? key,
    required this.width,
    required this.height,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      content,
      style: TextStyle(
        fontSize: height * 0.3,
        fontWeight: FontWeight.bold,
        decoration: TextDecoration.underline,
      ),
    );
  }
}

class TextComponent extends StatelessWidget {
  final double width;
  final double height;
  final String content;

  const TextComponent({
    Key? key,
    required this.width,
    required this.height,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(content);
  }
}

class ImageComponent extends StatelessWidget {
  final double width;
  final double height;
  final String source;

  const ImageComponent({
    Key? key,
    required this.width,
    required this.height,
    required this.source,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: Image.network(source),
      borderRadius: BorderRadius.circular(10),
    );
  }
}

class ListComponent extends StatelessWidget {
  final double width;
  final double height;
  final String content;

  const ListComponent({
    Key? key,
    required this.width,
    required this.height,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var contents = content.split(',');
    return SizedBox(
      height: size.height * 0.8,
      child: ListView.separated(
        itemCount: contents.length,
        separatorBuilder: (context, index) {
          return SizedBox(
            height: size.height * 0.01,
          );
        },
        itemBuilder: (context, index) {
          return DottedText(
            contents[index],
          );
        },
      ),
    );
  }
}
