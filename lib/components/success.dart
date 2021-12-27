import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class SuccessView extends StatelessWidget {
  final String _message;


  const SuccessView(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.green,
      Colors.teal,
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '✌😉\n',
              style: TextStyle(fontSize: 64),
            ),
            AnimatedTextKit(
              animatedTexts: [
                ColorizeAnimatedText(
                  _message,
                  textStyle: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  colors: colorizeColors,
                  speed: const Duration(milliseconds: 1000),
                  // duration: const Duration(milliseconds: 100),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ],
        ),
      ),
    );
  }
}
