import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Text textLabelButton;
  final Color colorTextLabelButton;
  final Color colorButton;
  final VoidCallback onPress;

  const ButtonWidget({
    super.key,
    required this.textLabelButton,
    required this.colorTextLabelButton,
    required this.colorButton,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPress,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(colorButton),
          padding: MaterialStateProperty.all(
            const EdgeInsets.only(
              top: 15,
              bottom: 15,
            ),
          ),
          textStyle: MaterialStateProperty.all(
            TextStyle(
              color: colorTextLabelButton,
              fontWeight: FontWeight.bold,
            ),
          ),
          shape: MaterialStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
          ),
        ),
        child: textLabelButton,
      ),
    );
  }
}
