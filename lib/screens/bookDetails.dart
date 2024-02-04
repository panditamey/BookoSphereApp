import 'package:bookosphere/components/AudioPlayer.dart';
import 'package:bookosphere/components/IconButtonPurple.dart';
import 'package:bookosphere/components/IconButtonVisualize.dart';
import 'package:bookosphere/components/PdfViewer.dart';
import 'package:bookosphere/components/Ratings.dart';
import 'package:bookosphere/constants/colors.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookDetails extends StatelessWidget {
  const BookDetails({super.key, required this.bookDetails});
  final bookDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height / 3,
                    // decoration: const BoxDecoration(
                    //   borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(15),
                    //     bottomRight: Radius.circular(15),
                    //   ),
                    //   image: DecorationImage(
                    //     image: NetworkImage(
                    //       "https://fastly.picsum.photos/id/1072/200/300.jpg?hmac=uzq3N0ox40X06q0Ql4mCdgMwHc13gIa0QAuu_6Zp6lQ",
                    //     ),
                    //     fit: BoxFit.cover,
                    //   ),
                    // ),
                    child: CachedNetworkImage(
                      imageUrl: bookDetails["posterURL"],
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    color: Colors.black.withOpacity(0.2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: WHITE,
                          ),
                        ),
                        const Icon(
                          Icons.more_vert,
                          color: WHITE,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      bookDetails["name"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      bookDetails["author"].toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                    bookDetails["rating"] == null
                        ? const SizedBox(
                            height: 0,
                          )
                        : Rating(
                            bookDetails["rating"],
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: IconButtonPurple(
                            Icons.bookmark,
                            "Read",
                            PdfViewer(
                              bookURL: bookDetails["bookURL"].toString(),
                            ),
                          ),
                        ),
                        IconButtonPurple(
                          Icons.audio_file,
                          "Listen",
                          CustomAudioPlayer(
                            audioURL: bookDetails["audioURL"].toString(),
                            posterURL: bookDetails["posterURL"].toString(),
                            name: bookDetails["name"].toString(),
                            author: bookDetails["author"].toString(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    bookDetails["videoURL"] == null
                        ? Container()
                        : IconButtonVisualize(),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      bookDetails["description"],
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                      textAlign: TextAlign.justify,
                      softWrap: true,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
