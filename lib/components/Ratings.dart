import 'package:flutter/material.dart';
import 'package:rate_in_stars/rate_in_stars.dart';

class Rating extends StatelessWidget {
  Rating(num this.i, {super.key});
  final num i;
  @override
  Widget build(BuildContext context) {
    return RatingStars(
      editable: false,
      rating: i.toDouble(),
      color: Colors.amber,
      iconSize: 32,
    );
  }
}
