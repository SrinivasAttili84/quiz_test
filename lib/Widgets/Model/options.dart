class OptionsModel {
  List feedback;
  int score;
  String label;
  int isCorrect;

  OptionsModel({
    this.feedback,
    this.score,
    this.label,
  });

  OptionsModel.toJson(Map dataMap) {
    try {
      if (dataMap.length > 0) {
        this.feedback =
            dataMap.keys.contains('feedback') ? dataMap['feedback'] : [];
        this.score = dataMap.keys.contains('score') ? dataMap['score'] : 0;
        this.label = dataMap.keys.contains('label') ? dataMap['label'] : '';
        this.isCorrect =
            dataMap.keys.contains('isCorrect') ? dataMap['isCorrect'] : 0;

        if (this.label.contains('<p>')) {
          this.label = this.label.replaceAll('<p>', '');
        }
        if (this.label.contains('</p>')) {
          this.label = this.label.replaceAll('</p>', '');
        }
      }
    } catch (e) {
      print('OptionsModel' + e);
    }
  }
}
