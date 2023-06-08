import 'package:enlab_quiz/constants/app_colors.dart';
import 'package:enlab_quiz/constants/app_parser.dart';
import 'package:enlab_quiz/constants/app_tmp.dart';
import 'package:flutter/material.dart';

class AllQuizDoneScreen extends StatefulWidget {
  const AllQuizDoneScreen({Key? key}) : super(key: key);

  @override
  State<AllQuizDoneScreen> createState() => _AllQuizDoneScreenState();
}

class _AllQuizDoneScreenState extends State<AllQuizDoneScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.vlWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.vlWhiteColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: AppColors.vlBackgroundColor,
            child: IconButton(
                onPressed: () => Navigator.maybePop(context),
                icon: const Icon(
                  Icons.arrow_back,
                  color: AppColors.vlWhiteColor,
                )),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: tmpQuizDone.length,
          itemBuilder: (context, index) {
            return Card(
              color: AppColors.vlBackgroundColor,
              child: Container(
                margin: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Text(
                      "${index + 1}. ${AppParser.parseHtmlString(tmpQuizDone[index].question)}",
                      style: const TextStyle(
                        color: AppColors.vlWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: tmpQuizDone[index]
                            .options
                            .map(
                              (e) => Text(
                                e.option,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: e.value == 2
                                      ? AppColors.vlWhiteColor //option not picked
                                      : e.value == 1
                                          ? AppColors.vlGreenColor //option result
                                          : AppColors.vlWrongColor, //your option pick (if wrong)
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
