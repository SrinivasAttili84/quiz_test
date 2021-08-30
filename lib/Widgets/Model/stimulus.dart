class StimulusModel {
  String question;

  StimulusModel({
    this.question,
  });

  StimulusModel.toJson(Map dataMap) {
    try {
      if (dataMap.length > 0) {
        this.question =
            dataMap.keys.contains('stimulus') ? dataMap['stimulus'] : '';

        if (this.question.contains('<p>')) {
          this.question = this.question.replaceAll('<p>', '');
        }
        if (this.question.contains('</p>')) {
          this.question = this.question.replaceAll('</p>', '');
        }
      }
    } catch (e) {
      print('StimulusModel' + e);
    }
  }
}
