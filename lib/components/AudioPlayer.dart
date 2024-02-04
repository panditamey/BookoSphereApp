import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class CustomAudioPlayer extends StatefulWidget {
  const CustomAudioPlayer(
      {super.key,
      required String this.audioURL,
      required String this.posterURL,
      required String this.name,
      required String this.author});
  final String audioURL;
  final String posterURL;
  final String name;
  final String author;
  @override
  State<CustomAudioPlayer> createState() => _CustomAudioPlayerState();
}

class _CustomAudioPlayerState extends State<CustomAudioPlayer> {
  bool isPlaying = false;
  late final AudioPlayer player;
  late final AssetSource path;

  Duration _duration = const Duration();
  Duration _position = const Duration();

  @override
  void initState() {
    initPlayer();
    super.initState();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future initPlayer() async {
    player = AudioPlayer();
    // path = UrlSource('audios/ukulele.mp3');

    // set a callback for changing duration
    player.onDurationChanged.listen((Duration d) {
      setState(() => _duration = d);
    });

    // set a callback for position change
    player.onPositionChanged.listen((Duration p) {
      setState(() => _position = p);
    });

    // set a callback for when audio ends
    player.onPlayerComplete.listen((_) {
      setState(() => _position = _duration);
    });
  }

  void playPause() async {
    if (isPlaying) {
      player.pause();
      isPlaying = false;
    } else {
      player.play(UrlSource(
        widget.audioURL,
      ));
      isPlaying = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Image.network(
                  widget.posterURL,
                  width: MediaQuery.of(context).size.width / 3,
                ),
                const SizedBox(height: 30),
                Text(
                  widget.name,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                Text(
                  widget.author,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
            Slider(
              value: _position.inSeconds.toDouble(),
              onChanged: (value) async {
                await player.seek(Duration(seconds: value.toInt()));
                setState(() {});
              },
              min: 0,
              max: _duration.inSeconds.toDouble(),
              inactiveColor: Colors.grey,
              activeColor: Colors.red,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(_position.toString().split('.').first),
                Text(_duration.toString().split('.').first),
              ],
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    player.seek(Duration(seconds: _position.inSeconds - 10));
                    setState(() {});
                  },
                  child: Image.asset(
                    'assets/icons/10back.png',
                    width: 50,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: playPause,
                  child: Icon(
                    isPlaying ? Icons.pause_circle : Icons.play_circle,
                    color: Colors.red,
                    size: 100,
                  ),
                ),
                const SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    player.seek(Duration(seconds: _position.inSeconds + 10));
                    setState(() {});
                  },
                  child: Image.asset(
                    'assets/icons/10forward.png',
                    width: 50,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
