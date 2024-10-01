import 'package:flutter/material.dart';
import 'package:my_map/pages/constants/constants.dart';

class WelcomeButton extends StatelessWidget {
  const WelcomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    // Take the screen size
    final Size deviceSize = MediaQuery.of(context).size;
    final double widthScreen = deviceSize.width;
    final isMobile = widthScreen < 500; // Adjust for tablet or mobile

    return Column(
      mainAxisAlignment: isMobile
          ? MainAxisAlignment.spaceBetween
          : MainAxisAlignment.center, // if tablet center
      children: [
        Row(
          mainAxisAlignment:
              MainAxisAlignment.spaceBetween, // Add space between buttons
          children: [
            // Expanded to take equal space for both buttons
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/signIn');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 17.0),
                  backgroundColor: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  side: const BorderSide(
                    color: black54,
                    width: 2.0,
                  ),
                ),
                label: const Text(
                  'Driver',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: black54,
                    fontSize: 17.0,
                  ),
                ),
                icon: const Icon(
                  Icons.bus_alert,
                  color: black54,
                  size: 25.0,
                ),
              ),
            ),
            const SizedBox(width: 20), // Add space between the buttons
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushNamed(context, '/busDirection');
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 0.0, vertical: 17.0),
                  backgroundColor: whiteColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                  side: const BorderSide(
                    color: myMainColor,
                    width: 2.0,
                  ),
                ),
                label: const Text(
                  'Student',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: myMainColor,
                    fontSize: 17.0,
                  ),
                ),
                icon: const Icon(
                  Icons.person,
                  color: myMainColor,
                  size: 25.0,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
