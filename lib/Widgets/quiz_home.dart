import 'dart:async';

import 'package:flutter/material.dart';
import 'package:quiz/User/quiz_user.dart';
import 'package:quiz/Widgets/Model/options.dart';
import 'package:quiz/Widgets/option_detail.dart';
import 'package:quiz/Widgets/timer_screen.dart';
import 'package:quiz/model/block/quiz_bloc.dart';
import 'package:quiz/model/question_model/question_model.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool qTimeEnd = false;
  Map _selDetails;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizBlock.fetchQuestions(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[400],
      body: SafeArea(
        child: Container(
          child: Center(
            child: Column(children: [
              Text(
                'Oh my Quiz',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              SizedBox(
                height: 30,
              ),
              getQuestion(context),
            ]),
          ),
        ),
      ),
    );
  }

  Widget getQuestion(BuildContext context) {
    QuizUser user = QuizUser.getInstance();

    var wid = StreamBuilder(
      initialData: 0,
      stream: quizBlock.questionNumberStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          int qNumber = snapshot.data;

          if (user.questions != null && qNumber < user.questions.length) {
            QuestionModel selQuestion = user.questions[qNumber];
            var wid = Container(
                child: Column(
              children: [
                Text(
                  selQuestion.question.question,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Expanded(
                    child: CountDownTimer(
                  onStart: () {
                    qTimeEnd = false;
                  },
                  onEnd: () {
                    qTimeEnd = true;
                  },
                )),
                getOptions(selQuestion, context),
              ],
            ));
            Timer(Duration(seconds: 1), () {
              user.restartTimer();
            });
            return wid;
          }
        }
        return Container(
          child: Text(''),
        );
      },
    );
    return Expanded(
        child: Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: wid,
    ));
  }

  Widget getOptions(QuestionModel selQuestion, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double _crossAxisSpacing = 16, _mainAxisSpacing = 16;
    int _crossAxisCount = 2;
    var width = (screenWidth - ((_crossAxisCount - 1) * _crossAxisSpacing)) /
        _crossAxisCount;
    double cellHt = 150;
    double _aspectRatio = width / cellHt;

    var gridVw = selQuestion.options.length > 0
        ? MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: _crossAxisCount,
                  crossAxisSpacing: _crossAxisSpacing,
                  mainAxisSpacing: _mainAxisSpacing,
                  childAspectRatio: _aspectRatio,
                ),
                itemCount: selQuestion.options.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                      onTap: () {
                        gridOnClick(
                            context, index, selQuestion.options[index], width);
                      },
                      child: Hero(
                        tag: "DemoTag" + '$index',
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(8))),
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
                                    selQuestion.options[index].label,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ));
                }),
          )
        : Center();
    return Expanded(child: gridVw);
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Time Up'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Do you wnat to continue'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                qTimeEnd = false;
                Navigator.of(context).pop();
                Navigator.of(context).push(_createRoute(_selDetails));
              },
            ),
          ],
        );
      },
    );
  }

  gridOnClick(context, index, OptionsModel selOption, width) {
    _selDetails = {
      'tag': "DemoTag" + '$index',
      'selectedOption': selOption,
      'index': index,
      'width': width
    };
    if (qTimeEnd) {
      _showMyDialog();
      return;
    }
    // QuizUser user = QuizUser.getInstance();
    // user.restartTimer();
    Navigator.of(context).push(_createRoute(_selDetails));
  }

  Route _createRoute(Map _details) {
    return PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 1000),
      pageBuilder: (context, animation, secondaryAnimation) => OptionDetails(
        details: _details,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return child;
      },
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
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      )),
    );
    return wid;
  }
}
