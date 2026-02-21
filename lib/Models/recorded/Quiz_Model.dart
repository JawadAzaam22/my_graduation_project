class Question {
  int? id;
  String? questionText;
  List<Answers>? answers;

  Question({this.id, this.questionText, this.answers});

  Question.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionText = json['question_text'];
    if (json['answers'] != null) {
      answers = <Answers>[];
      json['answers'].forEach((v) {
        answers!.add(Answers.fromJson(v));
      });
    }
  }
}

class Answers {
  int? id;
  String? answerText;
  bool? isCorrect;
  bool isSelected;

  Answers({
    this.id,
    this.answerText,
    this.isCorrect,
    this.isSelected = false,
  });

  Answers.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        answerText = json['answer_text'],
        isSelected = false {

    final isCorrectValue = json['is_correct'];
    if (isCorrectValue is int) {
      isCorrect = isCorrectValue == 1;
    } else if (isCorrectValue is bool) {
      isCorrect = isCorrectValue;
    } else {
      isCorrect = false;
    }
  }
}

