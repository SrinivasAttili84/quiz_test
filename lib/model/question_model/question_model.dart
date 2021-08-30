import 'package:quiz/Widgets/Model/options.dart';
import 'package:quiz/Widgets/Model/stimulus.dart';

class QuestionModel {
  var data;
  String instructions;
  String questionID;
  var solution;
  StimulusModel question;
  List<OptionsModel> options = [];

  QuestionModel({
    this.data,
    this.instructions,
    this.questionID,
    this.solution,
  });

  QuestionModel.toJson(List qList) {
    try {
      if (qList.length > 0) {
        var qMap = qList[0];
        this.data = qMap.keys.contains('data') ? qMap['data'] : [];
        this.instructions =
            qMap.keys.contains('instructions') ? qMap['instructions'] : '';
        this.questionID =
            qMap.keys.contains('questionID') ? qMap['questionID'] : '';
        this.solution = qMap.keys.contains('solution') ? qMap['solution'] : [];

        this.question = StimulusModel.toJson(this.data);

        List optns = this.data['options'];
        for (int i = 0; i < optns.length; i++) {
          OptionsModel opt = OptionsModel.toJson(optns[i]);
          options.add(opt);
        }
      }
    } catch (e) {
      print('QuestionModel' + e);
    }
  }
}
