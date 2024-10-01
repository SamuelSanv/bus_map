import 'package:flutter/material.dart';
import 'package:my_map/pages/constants/constants.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Text(
          'WELCOME',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 40.0,
            letterSpacing: 3.0,
            color: userPageColor,
          ),
        ),
        //Add space Between Texts
        SizedBox(
          height: 2.0,
        ),
        Text(
          'Use this App for a great experience with Near East Bus services',
          textAlign: TextAlign.center,
          style: TextStyle(
            // fontWeight: FontWeight.bold,
            fontSize: 17.0,
            color: black54,
          ),
        ),
        //Add space between texts and the button
      ],
    );
  }
}
