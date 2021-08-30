import 'dart:async';

import 'package:quiz/model/question_model/question_model.dart';

class QuizUser {
  static QuizUser _instance;

  QuizUser._internal();
  List<QuestionModel> questions = [];
  int currentQuestion = 0;
  StreamController<bool> timerController;

  static QuizUser getInstance() {
    if (_instance == null) {
      _instance = QuizUser._internal();
      _instance.setDefaults();
    }
    return _instance;
  }

  setDefaults() {
    timerController = StreamController<bool>.broadcast(); //St
  }

  restartTimer() {
    if (timerController != null) timerController.add(true);
  }
}
