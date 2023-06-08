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
          child: Image.asset(AppAssets.imgQuizUrl, width: 150, height: 150,),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 45, right: 45,),
        child: ButtonWidget(
          textLabelButton: const Text("START QUIZ"),
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
