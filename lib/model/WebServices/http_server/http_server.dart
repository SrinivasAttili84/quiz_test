import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz/model/question_model/question_model.dart';

class HttpServer {
  Future<List<QuestionModel>> getQuestionsFromJsons() async {
    try {
      final question1 = await rootBundle.loadString('assets/question1.json');

      final question2 = await rootBundle.loadString('assets/question2.json');

      var qList = [];
      qList.add(jsonDecode(question1));
      qList.add(jsonDecode(question2));
      return (qList).map((e) => QuestionModel.toJson(e)).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
