import 'package:flutter/material.dart';

class AudioInfo extends StatelessWidget {
  const AudioInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          'https://picsum.photos/200/300',
          width: MediaQuery.of(context).size.width / 3,
        ),
        const SizedBox(height: 30),
        const Text(
          'Ukulele',
          style: TextStyle(fontSize: 30),
        ),
        const SizedBox(height: 20),
        const Text(
          'Benjamin Tissot',
          style: TextStyle(
            fontSize: 16,
            color: Colors.red,
          ),
        ),
      ],
    );
  }
}
