import 'dart:async';
import 'dart:convert';

import 'package:enlab_quiz/constants/app_colors.dart';
import 'package:enlab_quiz/constants/app_parser.dart';
import 'package:enlab_quiz/constants/app_tmp.dart';
import 'package:enlab_quiz/models/quiz_done.dart';
import 'package:enlab_quiz/screens/result_screen.dart';
import 'package:enlab_quiz/services/api.dart';
import 'package:enlab_quiz/widgets/answer_widget.dart';
import 'package:enlab_quiz/widgets/button_widget.dart';
import 'package:enlab_quiz/widgets/question_widget.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var indexQuestion = 0;
  late Future getQuizFuture;
  var score = 0;
  var isClicked = false;
  var isLoaded = false;
  var listQuestions = [];
  var listOptions = [];
  
  late Timer timeProcess;
  Duration durationTimer = const Duration(days: 1);

  String strDigits(int n) => n.toString().padLeft(2, '0');

  var optionColors = [
    AppColors.vlWhiteColor,
    AppColors.vlWhiteColor,
    AppColors.vlWhiteColor,
    AppColors.vlWhiteColor,
    AppColors.vlWhiteColor,
  ];

  startTimer() {
    timeProcess = Timer.periodic(const Duration(seconds: 1), (timer) {
     setIncreaseTimer();
    });
  }

  void setIncreaseTimer() {
    const reduceSecondsBy = 1;
    setState(() {
      final seconds = durationTimer.inSeconds + reduceSecondsBy;
      durationTimer = Duration(seconds: seconds);
    });
  }

  void pauseTimer() {
    setState(() => timeProcess.cancel());
  }

  @override
  void initState() {
    getQuizFuture = getQuiz();
    super.initState();
  }

  resetColors() {
    optionColors = [
      AppColors.vlWhiteColor,
      AppColors.vlWhiteColor,
      AppColors.vlWhiteColor,
      AppColors.vlWhiteColor,
      AppColors.vlWhiteColor,
    ];
  }

  Padding errorData(AsyncSnapshot snapshot) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Error: ${snapshot.error}',
            style: const TextStyle(color: AppColors.vlWhiteColor),
          ),
          const SizedBox(
            height: 20.0,
          ),
          ButtonWidget(
            textLabelButton: const Text(
              "Try Again",
              style: TextStyle(color: AppColors.vlWhiteColor),
            ),
            colorTextLabelButton: AppColors.vlWhiteColor,
            colorButton: AppColors.vlRedColor,
            onPress: () {
              getQuizFuture = getQuiz();
              setState(() {});
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vlBackgroundColor,
      body: SafeArea(
        child: FutureBuilder(
            future: getQuizFuture,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text('Press button to start.');
                case ConnectionState.active:
                case ConnectionState.waiting:
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError) return errorData(snapshot);
                  listQuestions = snapshot.data["results"];
                  if (isLoaded == false) {
                    listOptions = listQuestions[indexQuestion]["incorrect_answers"];
                    listOptions.add(listQuestions[indexQuestion]["correct_answer"]);
                    listOptions.shuffle();
                    isLoaded = true;
                    startTimer();
                    //Test get result
                    debugPrint(listQuestions[indexQuestion]["correct_answer"]);
                  }
                  return quizWidget();
              }
            }),
      ),
    );
  }

  Widget quizWidget() {
    final hours = strDigits(durationTimer.inHours.remainder(24));
    final minutes = strDigits(durationTimer.inMinutes.remainder(60));
    final seconds = strDigits(durationTimer.inSeconds.remainder(60));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$hours:$minutes:$seconds",
                style: const TextStyle(color: AppColors.vlWhiteColor),
              ),
              Text(
                "Correct answer: $score",
                style: const TextStyle(color: AppColors.vlWhiteColor),
              ),
            ],
          ),
        ),

        QuestionWidget(
          indexQuestion: indexQuestion,
          totalQuestions: listQuestions.length,
          question: AppParser.parseHtmlString(
            listQuestions[indexQuestion]["question"],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(
          color: AppColors.vlWhiteColor,
        ),
        const SizedBox(
          height: 32,
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: listOptions.length,
          itemBuilder: (context, index) {
            var result = listQuestions[indexQuestion]["correct_answer"];
            return AnswerWidget(
              answer: listOptions[index],
              cardColor: optionColors[index],
              onTap: () {
                setState(() {
                  if(isClicked) {
                    return;
                  } else {
                    pauseTimer();
                    if(listOptions[index] == result) {
                      optionColors[index] = AppColors.vlGreenColor;
                      score++;
                    } else {
                      optionColors[index] = AppColors.vlRedColor;
                    }
                    isClicked = true;
                    //set color for result answer.
                    var indexResult = listOptions.indexOf(result);
                    optionColors[indexResult] = AppColors.vlGreenColor;
                    //add this quiz to tmpQuizDone
                    Map<String, int> tmpMapOptions = {};
                    listOptions.map((e) =>
                        tmpMapOptions[e] = 2 // get all options
                    ).toList();
                    tmpMapOptions.update(listOptions[index], (value) => 0); // get your pick option
                    tmpMapOptions.update(result, (value) => 1); // answer this question
                    List<Option> tmpOptions = tmpMapOptions.entries.map( (entry) => Option(option: entry.key, value: entry.value)).toList(); // convert map to List
                    QuizDone quizDone = QuizDone(question: listQuestions[indexQuestion]["question"], options: tmpOptions);
                    tmpQuizDone.add(quizDone);
                  }
                });
              },
            );
          },
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonWidget(
                textLabelButton: const Text("Next"),
                colorTextLabelButton: AppColors.vlWhiteColor,
                colorButton: AppColors.vlRedColor,
                onPress: () {
                  setState(() {
                    if (indexQuestion == listQuestions.length - 1) {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ResultScreen(totalScore: score, totalQuestions: listQuestions.length, hours: hours, minutes: minutes, seconds: seconds,),),);
                    } else {
                      indexQuestion++;
                      isClicked = false;
                      isLoaded = false;
                      resetColors();
                    }
                  });

                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}


