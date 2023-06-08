import 'package:enlab_quiz/constants/app_colors.dart';
import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  final int indexQuestion;
  final int totalQuestions;
  final String question;

  const QuestionWidget({
    Key? key,
    required this.indexQuestion,
    required this.totalQuestions,
    required this.question,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            top: 16,
          ),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "Question ${indexQuestion + 1}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.vlWhiteColor,
                  ),
                ),
                TextSpan(
                  text: "/$totalQuestions",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.vlSliverColor,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Text(
              question,
              style: const TextStyle(
                color: AppColors.vlWhiteColor,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
        ),
      ],
    );
  }
}
