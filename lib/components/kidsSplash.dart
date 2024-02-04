import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bookosphere/screens/kidsSection.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:page_transition/page_transition.dart';

class KidsSplashScreen extends StatelessWidget {
  const KidsSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Lottie.asset(
              'assets/lottie/doraemonAnimation.json',
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "doracake dora doraa...",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    '......',
                    textStyle: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                displayFullTextOnTap: false,
                stopPauseOnTap: false,
                repeatForever: true,
              )
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "loading",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
      nextScreen: const KidsScreen(),
      backgroundColor: Colors.lightBlue.shade100,
      splashIconSize: 500,
      duration: 1000,
      centered: true,
      splashTransition: SplashTransition.fadeTransition,
      pageTransitionType: PageTransitionType.rightToLeft,
      // animationDuration: const Duration(seconds: 2),
    );
  }
}
