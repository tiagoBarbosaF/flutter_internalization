import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ErrorView extends StatelessWidget {
  final String _message;

  const ErrorView(this._message, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.close,
        //     color: Theme.of(context).colorScheme.primary,
        //     size: 40,
        //   ),
        //   onPressed: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '😩\n',
              style: TextStyle(fontSize: 64),
            ),
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  _message,
                  textStyle: const TextStyle(fontSize: 32),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              isRepeatingAnimation: false,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 120,
        child: IconButton(
          icon: Icon(
            Icons.close,
            color: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 60,
        ),
      ),
    );
  }
}
