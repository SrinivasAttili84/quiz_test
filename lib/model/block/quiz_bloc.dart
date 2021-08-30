import 'package:quiz/User/quiz_user.dart';
import 'package:quiz/model/WebServices/http_server/network_repo.dart';
import 'package:quiz/model/question_model/question_model.dart';
import 'package:rxdart/subjects.dart';

class QuizBlock {
  final networkRepo = Network_Repo();
  QuizUser user = QuizUser.getInstance();

  // final _questionFetcher = PublishSubject<List<QuestionModel>>();
  // Stream<List<QuestionModel>> get questionsStream => _questionFetcher.stream;

  final _questionNumberFetcher = PublishSubject<int>();
  Stream<int> get questionNumberStream => _questionNumberFetcher.stream;

  fetchQuestions(qNumber) async {
    if (user.questions != null && user.questions.length == 0) {
      List<QuestionModel> data = await networkRepo.getQuestionsFromJsons();
      user.questions = data;
    }
    user.currentQuestion = qNumber;
    // _questionFetcher.add(data);
    if (qNumber < user.questions.length) {
      updateQuestionNumber(qNumber);
    }
  }

  updateQuestionNumber(qNumber) async {
    _questionNumberFetcher.add(qNumber);
  }

  dispose() {
    // _questionFetcher.close();
    _questionNumberFetcher.close();
  }
}

final quizBlock = QuizBlock();
