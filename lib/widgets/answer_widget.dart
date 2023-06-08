import 'package:enlab_quiz/constants/app_colors.dart';
import 'package:enlab_quiz/constants/app_parser.dart';
import 'package:flutter/material.dart';

class AnswerWidget extends StatelessWidget {
  final String answer;
  final VoidCallback onTap;
  final Color cardColor;
  const AnswerWidget({Key? key, required this.answer, required this.onTap, required this.cardColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: ListTile(
        onTap: onTap,
        title: Text(
          AppParser.parseHtmlString(answer),
          style: const TextStyle(
            color: AppColors.vlBlackColor,
          ),
        ),
      ),
    );
  }
}
