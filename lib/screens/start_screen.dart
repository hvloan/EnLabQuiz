import 'package:enlab_quiz/constants/app_assets.dart';
import 'package:enlab_quiz/constants/app_colors.dart';
import 'package:enlab_quiz/screens/quiz_screen.dart';
import 'package:enlab_quiz/widgets/button_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vlBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppAssets.imgQuizUrl),
                ButtonWidget(
                  textLabelButton: const Text("Start Quiz"),
                  colorTextLabelButton: AppColors.vlWhiteColor,
                  colorButton: AppColors.vlRedColor,
                  onPress: () async {
                    if (context.mounted) {
                      Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
