import 'package:flutter/material.dart';
import 'package:mybank/components/progress/progress.dart';

class ProgressView extends StatelessWidget {
  final String message;
  final String subtitle;

  const ProgressView({
    Key? key,
    this.message = '',
    this.subtitle = 'Loading...',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Progress(
        message: message,
        subtitle: subtitle,
      ),
    );
  }
}