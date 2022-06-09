import 'package:flutter/material.dart';

class LoginTitleWidget extends StatefulWidget {
  const LoginTitleWidget({Key? key}) : super(key: key);

  @override
  State<LoginTitleWidget> createState() => _LoginTitleWidgetState();
}

class _LoginTitleWidgetState extends State<LoginTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/login_icons/dollar-symbol.png',
            scale: 6,
          ),
        ),
        const Text(
          'Organizze',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
