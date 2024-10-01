import 'package:flutter/material.dart';
import 'package:my_map/pages/constants/constants.dart';
import 'package:my_map/pages/userPages/welcome/welcome_button.dart';
import 'package:my_map/pages/userPages/welcome/welcome_text.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    // Take the screen size
    final Size deviceSize = MediaQuery.of(context).size;
    final double widthScreen = deviceSize.width;
    final double heightScreen = deviceSize.height;

    // Variable for small device detection
    final isSmallDevice = heightScreen < 400;

    return Scaffold(
      backgroundColor: whiteColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            // First section with a background image
            Expanded(
              flex: isSmallDevice ? 1 : 5,
              child: Container(
                // Adding background image only for this part
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bus.png'),
                    // fit: BoxFit.cover,
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: widthScreen / 10),
                  child: const WelcomeText(),
                ),
              ),
            ),

            // Sign up button section without background image
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: widthScreen / 14),
                child: const WelcomeButton(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
