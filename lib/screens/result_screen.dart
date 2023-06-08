import 'package:enlab_quiz/constants/app_assets.dart';
import 'package:enlab_quiz/constants/app_colors.dart';
import 'package:enlab_quiz/screens/all_quiz_done.dart';
import 'package:enlab_quiz/screens/quiz_screen.dart';
import 'package:enlab_quiz/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class ResultScreen extends StatelessWidget {
  final int totalScore;
  final int totalQuestions;
  final String hours;
  final String minutes;
  final String seconds;

  const ResultScreen(
      {Key? key,
      required this.totalScore,
      required this.totalQuestions,
      required this.hours,
      required this.minutes,
      required this.seconds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vlBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 45,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 149.33,
                  height: 149.33,
                  child: CircularPercentIndicator(
                    backgroundColor: AppColors.vlSliverColor,
                    animation: true,
                    radius: 70,
                    lineWidth: 13.0,
                    percent: totalScore / totalQuestions,
                    animationDuration: 1000,
                    reverse: true,
                    circularStrokeCap: CircularStrokeCap.round,
                    center: Text(
                      "$totalScore/$totalQuestions \n $hours:$minutes:$seconds",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.vlWhiteColor,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                        fontSize: 15,
                      ),
                    ),
                    progressColor: totalScore > 15
                        ? AppColors.vlGreenColor
                        : AppColors.vlOrangeColor,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    totalScore < 15
                        ? Container(
                            width: 150,
                            height: 40,
                            margin: const EdgeInsets.only(top: 18),
                            decoration: BoxDecoration(
                              color: AppColors.vlOrangeColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                              child: Text(
                                'Ooops...!',
                                style: TextStyle(
                                  color: AppColors.vlWhiteColor,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.3,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                        : Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.vlGreenColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Center(
                                child: Text(
                              'Awesome!',
                              style: TextStyle(
                                color: AppColors.vlWhiteColor,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.3,
                                fontSize: 15,
                              ),
                            )),
                          ),
                  ],
                ),
                totalScore < 15
                    ? Image.asset(
                        AppAssets.imgCompleted,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fitWidth,
                      )
                    : Image.asset(
                        AppAssets.imgCongratulations,
                        width: 200,
                        height: 200,
                        fit: BoxFit.fitWidth,
                      ),
                totalScore < 15
                    ? Padding(
                        padding: const EdgeInsets.only(
                          top: 23,
                        ),
                        child: Container(
                          width: 250,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: AppColors.vlGreenColor,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                          child: const Center(
                            child: Text(
                              'Completed\n Good luck and try your best next time!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.vlWhiteColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(
                          top: 23,
                        ),
                        child: Container(
                          width: 160,
                          height: 60,
                          decoration: const BoxDecoration(
                              color: AppColors.vlGreenColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0))),
                          child: const Center(
                            child: Text(
                              'Congratulations\n You Passed the exam',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.vlWhiteColor,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -0.3,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                Container(
                  width: 160,
                  height: 45,
                  margin: const EdgeInsets.only(top: 18),
                  decoration: const BoxDecoration(
                      color: AppColors.vlRedColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: ButtonWidget(
                    textLabelButton: const Text("Try Again!"),
                    colorTextLabelButton: AppColors.vlWhiteColor,
                    colorButton: AppColors.vlRedColor,
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const QuizScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Container(
                  width: 160,
                  height: 45,
                  margin: const EdgeInsets.only(top: 18),
                  decoration: const BoxDecoration(
                      color: AppColors.vlRedColor,
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  child: ButtonWidget(
                    textLabelButton: const Text("View all this exam"),
                    colorTextLabelButton: AppColors.vlWhiteColor,
                    colorButton: AppColors.vlRedColor,
                    onPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AllQuizDoneScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
