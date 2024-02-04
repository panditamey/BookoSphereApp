import 'package:bookosphere/constants/colors.dart';
import 'package:flutter/material.dart';

class IconButtonPurple extends StatelessWidget {
  IconButtonPurple(
      IconData this.bookmark, String this.s, Widget this.nextScreen,
      {super.key});

  final IconData bookmark;
  final String s;
  final Widget nextScreen;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => nextScreen),
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
          children: [
            Icon(
              bookmark,
              color: WHITE,
            ),
            Text("  " + s.toString()),
          ],
        ),
      ),
    );
  }
}
