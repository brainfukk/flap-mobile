import 'package:flap/screens/main/unit.dart';
import 'package:flutter/material.dart';

enum SingingCharacter {
  first,
  second,
  third,
  fourth,
  fifth,
}
const SC_LIST = [
  SingingCharacter.first,
  SingingCharacter.second,
  SingingCharacter.third,
  SingingCharacter.fourth,
  SingingCharacter.fifth,
];

/// This is the stateful widget that the main application instantiates.
class RadioComponent extends StatefulWidget {
  final List<Widget> items;
  const RadioComponent({Key? key, required this.items}) : super(key: key);

  @override
  State<RadioComponent> createState() => _RadioComponentState();
}

/// This is the private State class that goes with RadioComponent.
class _RadioComponentState extends State<RadioComponent> {
  SingingCharacter? _character = SingingCharacter.first;

  @override
  Widget build(BuildContext context) {
    return Column(children: widget.items);
  }
}

class AnswerChoiceComponent extends StatefulWidget {
  final int exerciseId;
  final String content;
  final String? source;
  final List<dynamic> answers;
  final Function callback;
  final String? userAnswerId;

  const AnswerChoiceComponent({
    Key? key,
    required this.content,
    required this.answers,
    required this.exerciseId,
    required this.callback,
    this.source,
    this.userAnswerId,
  }) : super(key: key);

  @override
  _AnswerChoiceComponentState createState() => _AnswerChoiceComponentState();
}

class _AnswerChoiceComponentState extends State<AnswerChoiceComponent> {
  List<Widget> itemsData = [];
  Object? _character = "0";
  final Map<SingingCharacter, int> value = {};

  constructListTiles() {
    itemsData = [];
    for (var i = 0; i < widget.answers.length; i++) {
      var val = widget.answers[i];

      itemsData.add(
        ListTile(
          title: Text(val['data']['variant'].trim()),
          leading: Radio(
            value: val['id'].toString(),
            groupValue: _character,
            onChanged: (value) {
              setState(() {
                _character = value;
                widget.callback(widget.exerciseId, _character);
              });
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget imgComponent = Container();

    if (widget.source != null) {
      String imgSource = widget.source ?? "";
      imgComponent = ImageComponent(
        source: imgSource,
        width: size.width * 0.92,
        height: size.height * 0.11,
      );
    }
    constructListTiles();

    return Align(
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.content,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: size.height * 0.03,
              ),
            ),
          ),
          imgComponent,
          SizedBox(
            height: size.height * 0.01,
            width: size.width,
          ),
          RadioComponent(items: itemsData),
        ],
      ),
    );
  }
}

class InTextSelectComponent extends StatefulWidget {
  final int exerciseId;
  final String content;
  final String? source;
  final Function callback;
  final answers;

  const InTextSelectComponent({
    Key? key,
    required this.content,
    required this.exerciseId,
    required this.answers,
    required this.callback,
    this.source,
  }) : super(key: key);

  @override
  _InTextSelectComponentState createState() => _InTextSelectComponentState();
}

class _InTextSelectComponentState extends State<InTextSelectComponent> {
  late Map<String, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var regs = RegExp(r'(%\d+%)', multiLine: true);
    var allMatches =
        regs.allMatches(widget.content).map((m) => m.group(0).toString());
    List<Widget> items = [];

    widget.content.split(" ").forEach((val) {
      if (allMatches.contains(val)) {
        var inTextId = val.split("%")[1].toString();
        items.add(FittedBox(
          child: SelectComponent(
            callback: (inTextId, val) {
              setState(() {
                userAnswers[inTextId] = val;
                widget.callback(
                  widget.exerciseId,
                  userAnswers,
                );
              });
              return 0;
            },
            answers: widget.answers,
            inTextId: inTextId,
          ),
        ));
      } else {
        items.add(FittedBox(
          child: Text(
            val + " ",
            style: const TextStyle(
              fontSize: 16,
              height: 1,
            ),
          ),
        ));
      }
    });

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: items,
      spacing: 2,
    );
  }
}

class SelectComponent extends StatefulWidget {
  final Function callback;
  final List answers;
  final String inTextId;

  const SelectComponent({
    Key? key,
    required this.callback,
    required this.answers,
    required this.inTextId,
  }) : super(key: key);

  @override
  _SelectComponentState createState() => _SelectComponentState();
}

class _SelectComponentState extends State<SelectComponent> {
  String? valueChoose;
  late Map<String, String>? userAnswers;
  var dropItems;

  @override
  void initState() {
    super.initState();
    var localAnswers = widget.answers[0]['data']['variants'] ?? {};
    List<DropdownMenuItem<String>> items = [];

    localAnswers.keys.forEach((key) {
      var val = localAnswers[key];
      items.add(DropdownMenuItem(
        child: Text(val),
        value: key,
      ));
    });

    setState(() {
      dropItems = items;
    });
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.userAnswer != null) {
    //   valueChoose = widget.userAnswer;
    // }

    return SizedBox(
      height: 40,
      width: 200,
      child: DropdownButton<String>(
        hint: const Text("Выберите ответ"),
        underline: Container(
          height: 2,
          color: Colors.deepPurpleAccent,
        ),
        value: valueChoose,
        items: dropItems,
        iconSize: 24,
        itemHeight: 50,
        elevation: 16,
        isExpanded: true,
        icon: const Icon(Icons.arrow_downward),
        onChanged: (String? val) {
          setState(() {
            valueChoose = val;
            widget.callback(widget.inTextId, val);
          });
        },
      ),
    );
  }
}

class InTextWriteComponent extends StatefulWidget {
  final int exerciseId;
  final String content;
  final String? source;
  final Function callback;

  const InTextWriteComponent({
    Key? key,
    required this.content,
    required this.exerciseId,
    required this.callback,
    this.source,
  }) : super(key: key);

  @override
  _InTextWriteComponentState createState() => _InTextWriteComponentState();
}

class _InTextWriteComponentState extends State<InTextWriteComponent> {
  late Map<String, String> userAnswers = {};

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var regs = RegExp(r'(%\d+%)', multiLine: true);
    var allMatches =
        regs.allMatches(widget.content).map((m) => m.group(0).toString());
    List<Widget> items = [];

    widget.content.split(" ").forEach((val) {
      if (allMatches.contains(val)) {
        var inTextId = val.split("%")[1].toString();
        items.add(FittedBox(
          child: WirteInput(
            inTextId: inTextId,
            callback: (inTextId, val) {
              setState(() {
                userAnswers[inTextId] = val;
                widget.callback(
                  widget.exerciseId,
                  userAnswers,
                );
              });
              return 0;
            },
          ),
        ));
      } else {
        items.add(FittedBox(
          child: Text(
            val + " ",
            style: const TextStyle(
              fontSize: 16,
              // height: 1,
            ),
          ),
        ));
      }
    });

    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: items,
      spacing: 2,
      runSpacing: 20.0,
    );
  }
}

class WirteInput extends StatefulWidget {
  final Function callback;
  final String inTextId;

  const WirteInput({
    Key? key,
    required this.callback,
    required this.inTextId,
  }) : super(key: key);

  @override
  _WirteInputState createState() => _WirteInputState();
}

class _WirteInputState extends State<WirteInput> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 20,
      width: 200,
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        textAlign: TextAlign.center,
        onChanged: (String? val) {
          setState(() {
            widget.callback(widget.inTextId, val);
          });
        },
      ),
    );
  }
}
