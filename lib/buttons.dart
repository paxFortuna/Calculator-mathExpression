import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final color;
  final textColor;
  final String buttonText;
  final buttonTepped;

  const MyButton({
    Key? key,
    this.color,
    this.textColor,
    required this.buttonText,
    this.buttonTepped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTepped,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: color,
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(color: textColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
