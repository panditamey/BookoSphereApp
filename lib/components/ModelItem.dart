import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ModelItem extends StatefulWidget {
  ModelItem(
      {super.key,
      required String this.model,
      required String this.video_id,
      required String this.poster});

  final String model;
  final String video_id;
  final String poster;
  @override
  State<ModelItem> createState() => _ModelItemState();
}

class _ModelItemState extends State<ModelItem> {
  // final controller = WebViewController()
  //   ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //   ..loadRequest(
  //       Uri.parse("https://bookosphereapi.ameyp.tech/model/shinchan"));

  void launchURL(String url) async {
    launchUrl(
      Uri.parse(url),
    );
  }

  late final PodPlayerController videocontroller;
  bool isLoading = true;
  @override
  void initState() {
    loadVideo();
    super.initState();
  }

  void loadVideo() async {
    final urls = await PodPlayerController.getYoutubeUrls(
      'https://youtu.be/N2ZhrJp5tko',
    );
    setState(() => isLoading = false);
    videocontroller = PodPlayerController(
      playVideoFrom: PlayVideoFrom.networkQualityUrls(videoUrls: urls!),
      podPlayerConfig: const PodPlayerConfig(
        videoQualityPriority: [360],
      ),
    )..initialise();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              child: WebViewWidget(
                controller: WebViewController()
                  ..setJavaScriptMode(JavaScriptMode.unrestricted)
                  ..loadRequest(Uri.parse(
                      "https://bookosphereapi.ameyp.tech/model/" +
                          widget.model)),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.open_in_browser),
              onPressed: () {
                launchURL(
                    'https://bookosphereapi.ameyp.tech/model/' + widget.model);
              },
              label: Text('See Magic'),
            ),
            Container(
              margin: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Center(child: PodVideoPlayer(controller: videocontroller)),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                launchURL('https://youtu.be/N2ZhrJp5tko');
              },
              child: Text('Open Video Source'),
            ),
          ],
        ),
      ),
    );
  }
}
