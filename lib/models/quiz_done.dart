class QuizDone {
  String question;
  List<Option> options;

  QuizDone({
    required this.question,
    required this.options,
  });
}

class Option {
  String option;
  int value;

  Option({
    required this.option,
    required this.value,
  });

}