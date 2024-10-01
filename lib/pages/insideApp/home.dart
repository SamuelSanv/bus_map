import 'package:flutter/material.dart';
import 'package:my_map/pages/constants/constants.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        backgroundColor: whiteColor,
        body: SafeArea(
          child: Center(
            child: Text(
              'Welcome to the Home Page',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: myMainColor,
              ),
            ),
          ),
        ));
  }
}
