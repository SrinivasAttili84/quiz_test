import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:quiz/User/quiz_user.dart';
import 'package:quiz/Widgets/Model/options.dart';
import 'package:flip_card/flip_card.dart';
import 'package:quiz/model/block/quiz_bloc.dart';

class OptionDetails extends StatefulWidget {
  static String pageRoute = "/OptionDetails";
  const OptionDetails({Key key, this.details}) : super(key: key);
  final Map details;

  @override
  _OptionDetailsState createState() => _OptionDetailsState();
}

class _OptionDetailsState extends State<OptionDetails> {
  OptionsModel selOption;
  String tag;
  int index;
  var width;
  bool _showFrontSide = true;
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    final Map arguments =
        widget.details; //ModalRoute.of(context).settings.arguments as Map;
    tag = arguments['tag'];
    selOption = arguments['selectedOption'];
    index = arguments['index'];
    width = arguments['width'];

    Timer(Duration(seconds: 1), () {
      cardKey.currentState.toggleCard();
      // setState(() => _showFrontSide = !_showFrontSide);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: Container(
        child: Center(child: _buildFlipAnimation()),
      ),
    );
  }

  Widget _buildFlipAnimation() {
    return FlipCard(
      flipOnTouch: false,
      key: cardKey,
      direction: FlipDirection.HORIZONTAL, // default
      front: _buildFront(),
      back: Container(
        child: _buildRear(),
      ),
    );
  }

  Widget _buildFront() {
    return GestureDetector(
        onTap: () {
          Navigator.pop(context);
          //gridOnClick(context, index, selQuestion.options[index]);
        },
        child: Hero(
          tag: tag,
          child: Container(
            width: width,
            height: 150,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            // color: Colors.white,
            child: Column(children: [
              SizedBox(
                height: 8,
              ),
              getOptionTitle(index),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      selOption.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          decoration: TextDecoration.none,
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }

  Widget _buildRear() {
    return GestureDetector(
      onTap: () {
        QuizUser user = QuizUser.getInstance();
        Navigator.pop(context);
        int nextQuestion = user.currentQuestion + 1;
        quizBlock.fetchQuestions(nextQuestion);

        //gridOnClick(context, index, selQuestion.options[index]);
      },
      child: Container(
        width: width,
        height: 150,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        // color: Colors.white,
        child: Column(children: [
          SizedBox(
            height: 8,
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  selOption.isCorrect == 0 ? 'Wrong' : 'Correct',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget getOptionTitle(int index) {
    String title = '';
    MaterialColor color = Colors.yellow;

    switch (index) {
      case 0:
        title = 'A';
        color = Colors.yellow;
        break;
      case 1:
        title = 'B';
        color = Colors.blue;
        break;
      case 2:
        title = 'C';
        color = Colors.green;
        break;
      case 3:
        title = 'D';
        color = Colors.red;
        break;
      default:
        break;
    }
    var wid = Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        color: color,
      ),
      child: Center(
          child: Text(
        title,
        style: TextStyle(
            decoration: TextDecoration.none,
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.bold),
      )),
    );
    return wid;
  }
}
