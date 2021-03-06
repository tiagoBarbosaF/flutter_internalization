import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class Progress extends StatelessWidget {
  final String message;
  final String subtitle;

  const Progress({
    Key? key,
    this.message = '',
    this.subtitle = 'Loading',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            message,
            style: const TextStyle(fontSize: 64.0),
          ),
          AnimatedTextKit(
            animatedTexts: [
              WavyAnimatedText(
                subtitle,
                textStyle: const TextStyle(fontSize: 40),
                speed: const Duration(milliseconds: 300),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
