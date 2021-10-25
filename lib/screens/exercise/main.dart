import 'package:flap/Requests/api_unit_requests.dart';
import 'package:flap/constante.dart';
import 'package:flap/screens/exercise/components/answer_choice.dart';
import 'package:flap/screens/main/body.dart';
import 'package:flutter/material.dart';

class ExerciseScreen extends StatefulWidget {
  final String title;
  final String unitId;
  const ExerciseScreen({Key? key, required this.title, required this.unitId})
      : super(key: key);

  @override
  _ExerciseScreenState createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  late Map<String, dynamic> answers = {};

  submitUserAnswers() {
    submitAnswers(answers, widget.unitId).then(
      (value) => showAlertDialog(
        context,
        "Correct answers is ${value['correct']}",
      ),
    );
  }

  showAlertDialog(BuildContext context, String msg) {
    // set up the buttons
    Widget okButton = TextButton(
      child: const Text("Finish"),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Results"),
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
      body: Container(
        decoration: BoxDecoration(color: pColor),
        child: ListOfItemsPlain(
          answersCallback: getUserAnswers,
          nextStepCallback: submitUserAnswers,
          nextStepText: "Submit",
          unitId: widget.unitId,
          getObjects: getUnitExercises,
          title: widget.title,
          itemBuilder: (context, index, items, size, builderAnswers) {
            var val = items[index];
            var idToValMap = {};

            builderAnswers.forEach((val) {
              idToValMap[val['exercise']] = val;
            });

            if (val['type'] == 'ANSWER_CHOICE') {
              return AnswerChoiceComponent(
                exerciseId: val['id'],
                content: val['content'],
                answers: val['answers'],
                source: val['image'],
                callback: (exerciseId, value) {
                  setState(
                    () {
                      answers[exerciseId.toString()] = value;
                    },
                  );

                  return 0;
                },
              );
            } else if (val['type'] == 'IN_TEXT_SELECT') {
              return InTextSelectComponent(
                content: val['content'],
                answers: val['answers'],
                exerciseId: val['id'],
                callback: (exerciseId, value) {
                  setState(
                    () {
                      answers[exerciseId.toString()] = value;
                    },
                  );
                  return 0;
                },
              );
            } else if (val['type'] == 'FREE_IN_TEXT_ANSWER') {
              return InTextWriteComponent(
                content: val['content'],
                exerciseId: val['id'],
                callback: (exerciseId, value) {
                  setState(
                    () {
                      answers[exerciseId.toString()] = value;
                    },
                  );
                  return 0;
                },
              );
            }
            return const Text("ACTUALLY NOTHING");
          },
        ),
      ),
    );
  }
}
