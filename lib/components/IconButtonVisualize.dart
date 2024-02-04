import 'package:bookosphere/components/VideoPlayer.dart';
import 'package:bookosphere/constants/colors.dart';
import 'package:flutter/material.dart';

class IconButtonVisualize extends StatelessWidget {
  const IconButtonVisualize({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CustomVideoPlayer()),
          );
        },
        style: TextButton.styleFrom(
          foregroundColor: WHITE,
          backgroundColor: primaryPurple,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 8.0,
            right: 8.0,
            top: 5.0,
            bottom: 5.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.remove_red_eye,
                color: WHITE,
              ),
              Text("  Storyteller β"),
            ],
          ),
        ),
      ),
    );
  }
}
