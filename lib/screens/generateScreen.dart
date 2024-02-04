import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:bookosphere/components/userGeneratedBook.dart';
import 'package:bookosphere/constants/colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:confetti/confetti.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:lottie/lottie.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  TextEditingController promptController = TextEditingController();
  TextEditingController chapterController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  ConfettiController _controllerCenter =
      ConfettiController(duration: const Duration(seconds: 1));
  Map<String, dynamic> generatedBooks = {};
  bool isGenerated = false;

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    fetchRecords("generatedbooks", generatedBooks);
  }

  @override
  void dispose() {
    _controllerCenter.dispose();
    super.dispose();
  }

  fetchRecordss(s) async {
    var result = await FirebaseFirestore.instance.collection(s);
    // .where("author",
    //     isEqualTo: FirebaseAuth.instance.currentUser!.email?.split('@')[0]);

    result.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        if (mounted)
          setState(() {
            generatedBooks[change.doc.id] = change.doc.data();
          });
      });
    });
    // print(generatedBooks);
  }

  fetchRecords(s, Map<String, dynamic> books) async {
    var result = await FirebaseFirestore.instance.collection(s).where("author",
        isEqualTo: FirebaseAuth.instance.currentUser!.email?.split('@')[0]);

    await result.get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        if (mounted)
          setState(() {
            books[doc.id] = doc.data();
            books[doc.id]['id'] = doc.id;
          });
      });

      // Listen for changes
      result.snapshots().listen((querySnapshot) {
        querySnapshot.docChanges.forEach((change) {
          if (mounted)
            setState(() {
              books[change.doc.id] = change.doc.data();
              books[change.doc.id]['id'] = change.doc.id;
            });
        });
      });
      //listen for delete doc
      result.snapshots().listen((event) {
        event.docChanges.forEach((element) {
          if (element.type == DocumentChangeType.removed) {
            if (mounted)
              setState(() {
                books.remove(element.doc.id);
              });
          }
        });
      });
    });
  }

  Widget build(BuildContext context) {
    return isGenerated == true
        ? Padding(
            padding: const EdgeInsets.all(50),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset('assets/lottie/generateAnimation.json'),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Generating your book",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      AnimatedTextKit(
                        animatedTexts: [
                          TypewriterAnimatedText(
                            '......',
                            textStyle: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
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
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Please wait while we generate your book.",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            ),
          )
        : ConfettiWidget(
            confettiController: _controllerCenter,
            blastDirectionality: BlastDirectionality.explosive,
            particleDrag: 0.05,
            emissionFrequency: 0.5,
            numberOfParticles: 20,
            gravity: 0.05,
            shouldLoop: false,
            colors: const [
              Colors.green,
              Colors.blue,
              Colors.pink,
              Colors.orange,
              Colors.purple
            ],
            child: Scaffold(
                backgroundColor: primaryPurple.withOpacity(0.3),
                appBar: AppBar(
                  title: const Text('Generate Your Book'),
                  centerTitle: true,
                  backgroundColor: Colors.black.withOpacity(0.2),
                  foregroundColor: WHITE,
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                controller: promptController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelText:
                                        'Type Prompt Here (e.g. "A book about a dog")',
                                    alignLabelWithHint: true,
                                    hintText:
                                        "Enter the text you want to generate your book."),
                                maxLines: 3,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextField(
                                    controller: chapterController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: 'Number of Chapters',
                                      alignLabelWithHint: true,
                                      hintStyle: TextStyle(fontSize: 10),
                                      hintText: "Enter number of chapters.",
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: TextField(
                                    controller: lengthController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      labelText: 'Chapter Length',
                                      alignLabelWithHint: true,
                                      hintStyle: TextStyle(fontSize: 10),
                                      hintText: "Enter the length of chapter.",
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextField(
                                controller: genreController,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  labelText: 'Genre',
                                  alignLabelWithHint: true,
                                  hintStyle: TextStyle(
                                    fontSize: 18,
                                  ),
                                  hintText: "Enter the genre of your choice.",
                                ),
                                maxLines: 1,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (promptController.text.isEmpty ||
                                    chapterController.text.isEmpty ||
                                    lengthController.text.isEmpty ||
                                    genreController.text.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Please fill all the fields.'),
                                    ),
                                  );
                                  return;
                                }
                                // print({
                                //   "prompt": promptController.text,
                                //   "chapters": chapterController.text,
                                //   "length": lengthController.text,
                                //   "genre": genreController.text,
                                //   "author": FirebaseAuth.instance.currentUser!.email
                                //       ?.split('@')[0],
                                // });

                                setState(() {
                                  isGenerated = true;
                                });
                                String prompt = "Write a book on " +
                                    promptController.text +
                                    " with " +
                                    chapterController.text +
                                    " chapters each of length " +
                                    lengthController.text +
                                    "  with  " +
                                    genreController.text +
                                    " genre.";
                                print(prompt);

                                //post http://localhost:3000/api/generate

                                http
                                    .post(
                                      Uri.parse(
                                          'https://bookosphereapi.ameyp.tech/generatebook'),
                                      // Uri.parse('http://127.0.0.1:8000/generatebook'),
                                      headers: <String, String>{
                                        'Content-Type':
                                            'application/json; charset=UTF-8',
                                      },
                                      body: jsonEncode(<String, String>{
                                        'prompt': prompt,
                                        'user': FirebaseAuth
                                                .instance.currentUser!.email
                                                ?.split('@')[0]
                                                .toString() ??
                                            "UNKNOWN",
                                      }),
                                    )
                                    .then((value) => {
                                          if (value.statusCode == 200)
                                            {
                                              setState(() {
                                                isGenerated = false;
                                              }),
                                              _controllerCenter.play(),
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Your book has been generated.'),
                                                ),
                                              ),
                                            }
                                          else
                                            {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                      'Error generating your book. Please try again.'),
                                                ),
                                              ),
                                              setState(() {
                                                isGenerated = false;
                                              }),
                                            }
                                        });
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   const SnackBar(
                                //     content: Text('Generating your book...'),
                                //   ),
                                // );

                                promptController.clear();
                                chapterController.clear();
                                lengthController.clear();
                                genreController.clear();
                              },
                              child: const Text('Generate'),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const Text(
                              "Books Generated by you:",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            GeneratedBookList(books: generatedBooks),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
          );
  }
}
