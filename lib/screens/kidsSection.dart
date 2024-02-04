import 'package:bookosphere/components/ModelItem.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class KidsScreen extends StatefulWidget {
  const KidsScreen({super.key});

  @override
  State<KidsScreen> createState() => _KidsScreenState();
}

class _KidsScreenState extends State<KidsScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade100,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        foregroundColor: Colors.white,
        title: const Text("Kids"),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            KidsCardItem(
              text: "Mars Rover",
              model: "rover_mars",
              video_id: "",
              poster:
                  "https://mars.nasa.gov/system/feature_items/images/6037_msl_banner.jpg",
            ),
            KidsCardItem(
              text: "Shinchan",
              model: "shinchan",
              video_id: "",
              poster:
                  "https://miro.medium.com/v2/resize:fit:1400/format:webp/1*jUNUAsBJXvXz0twWslbyTQ.jpeg",
            ),
            KidsCardItem(
              text: "Aladdin",
              model: "aladdin",
              video_id: "",
              poster: "https://i.insider.com/5a188d6e7101ad6cfe1d9d2b",
            ),
            KidsCardItem(
              text: "Frozen",
              model: "frozen",
              video_id: "",
              poster:
                  "https://lumiere-a.akamaihd.net/v1/images/pp_frozen_herobanner_mobile_20501_ae840c59.jpeg",
            ),
            KidsCardItem(
              text: "Maharaj",
              model: "shivaji_maharaj",
              video_id: "",
              poster:
                  "https://cdn.dribbble.com/users/2468353/screenshots/4933123/rajmudra---dribble.gif",
            ),
          ],
        ),
      ),
    );
  }
}

class KidsCardItem extends StatefulWidget {
  const KidsCardItem(
      {super.key,
      required String this.model,
      required String this.video_id,
      required String this.poster,
      required String this.text});
  final String model;
  final String video_id;
  final String poster;
  final String text;

  @override
  State<KidsCardItem> createState() => _KidsCardItemState();
}

class _KidsCardItemState extends State<KidsCardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return ModelItem(
              model: widget.model,
              video_id: "",
              poster: widget.poster,
            );
          },
        ));
      },
      child: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(50)),
          color: Colors.black,
          image: DecorationImage(
            image: NetworkImage(widget.poster),
            fit: BoxFit.cover,
            opacity: 0.5,
          ),
        ),
        child: Center(
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
