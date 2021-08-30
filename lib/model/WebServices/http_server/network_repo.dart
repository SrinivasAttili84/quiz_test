import 'package:flutter/material.dart';
import 'package:quiz/model/WebServices/http_server/http_server.dart';
import 'package:quiz/model/question_model/question_model.dart';

class Network_Repo {
  HttpServer webServer = HttpServer();

  Future<List<QuestionModel>> getQuestionsFromJsons() =>
      webServer.getQuestionsFromJsons();
}
