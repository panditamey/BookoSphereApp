import 'package:bookosphere/constants/colors.dart';
import 'package:bookosphere/screens/bookDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GeneratedBookItem extends StatelessWidget {
  GeneratedBookItem(String this.name, String this.author, num this.ratings,
      String this.poster,
      {super.key, required this.bookDetails});
  final String name;
  final String author;
  final String poster;
  final num ratings;
  final bookDetails;

  updateRecord() {
    FirebaseFirestore.instance
        .collection('generatedbooks')
        .doc(bookDetails["id"])
        .update({
      'public': !bookDetails['public'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BookDetails(
                      bookDetails: bookDetails,
                    )));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        // margin: const EdgeInsets.all(5),
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              blurRadius: 5.0,
              color: Colors.black12,
              spreadRadius: 1.0,
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 90,
              // decoration: BoxDecoration(
              //   borderRadius: BorderRadius.circular(10),
              //   image: const DecorationImage(
              //     image: NetworkImage(
              //         'https://bafkreiafbdyyt3v3hhy44k5h6zxm3slpdbsypadfn4rtan5yxejnms7mzu.ipfs.w3s.link'),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: CachedNetworkImage(
                imageUrl: poster,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                placeholder: (context, url) =>
                    Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Container(
                // width: MediaQuery.of(context).size.width - 120,
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.toString(),
                      textAlign: TextAlign.justify,
                      maxLines: 1,
                      softWrap: true,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      author.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                    ratings == 0
                        ? Container()
                        : Row(
                            children: [
                              const Icon(
                                Icons.star_rate,
                                color: Colors.orange,
                              ),
                              Text(
                                ratings.toString(),
                                style: const TextStyle(color: Colors.orange),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // bookDetails['status'] == "completed"
                  //     ? const Icon(
                  //         Icons.circle,
                  //         color: Colors.green,
                  //       )
                  //     : const Icon(
                  //         Icons.circle,
                  //         color: Colors.orange,
                  //       ),
                  IconButton(
                    onPressed: () {
                      // print(bookDetails['id']);

                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: bookDetails['public'] == true
                                  ? Text(
                                      'Are you sure you want to make this book private?',
                                    )
                                  : Text(
                                      "Are you sure you want to make this book public?",
                                    ),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      try {
                                        Navigator.pop(context);
                                        // await FirebaseFirestore.instance
                                        //     .collection('generatedbooks')
                                        //     .doc(bookDetails["id"])
                                        //     .update({
                                        //   'public': !bookDetails['public'],
                                        // },
                                        // );

                                        updateRecord();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                bookDetails['public'] == true
                                                    ? const Text(
                                                        'Book made private ✅',
                                                      )
                                                    : const Text(
                                                        'Book made public ✅',
                                                      ),
                                          ),
                                        );
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: Text('Yes')),
                                TextButton(
                                    onPressed: () async {
                                      try {
                                        Navigator.pop(context);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: Text('No')),
                              ],
                            );
                          });
                      // AlertDialog(
                      //   title: Text(
                      //       'Welcome'), // To display the title it is optional
                      //   content: Text(
                      //       'GeeksforGeeks'), // Message which will be pop up on the screen
                      //   // Action widget which will provide the user to acknowledge the choice
                      //   actions: [
                      //     TextButton(
                      //       // FlatButton widget is used to make a text to work like a button
                      //       onPressed:
                      //           () {}, // function used to perform after pressing the button
                      //       child: Text('CANCEL'),
                      //     ),
                      //     TextButton(
                      //       onPressed: () {},
                      //       child: Text('ACCEPT'),
                      //     ),
                      //   ],
                      // );
                    },
                    icon: bookDetails['public'] == true
                        ? const Icon(
                            Icons.lock_open_outlined,
                            color: primaryPurple,
                          )
                        : const Icon(
                            Icons.lock_outline,
                            color: primaryPurple,
                          ),
                    color: primaryPurple,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                  'Are you sure you want to delete this book?'),
                              actions: [
                                TextButton(
                                    onPressed: () async {
                                      try {
                                        Navigator.pop(context);
                                        await FirebaseFirestore.instance
                                            .collection('generatedbooks')
                                            .doc(bookDetails["id"])
                                            .delete();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(
                                                'Book deleted successfully ✅'),
                                          ),
                                        );
                                        //refresh screen
                                        Navigator.pop(context);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: const Text('Yes')),
                                TextButton(
                                    onPressed: () async {
                                      try {
                                        Navigator.pop(context);
                                      } catch (e) {
                                        print(e);
                                      }
                                    },
                                    child: const Text('No')),
                              ],
                            );
                          });
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class GeneratedBookList extends StatefulWidget {
  GeneratedBookList({super.key, required Map<String, dynamic> this.books});
  final Map<String, dynamic> books;

  @override
  State<GeneratedBookList> createState() => _GeneratedBookListState();
}

class _GeneratedBookListState extends State<GeneratedBookList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),

        // GeneratedBookItem(
        //   "The Alchemist",
        //   "Paulo Coelho",
        //   4,
        // ),
        Builder(builder: (BuildContext context) {
          List<Widget> list = [];
          widget.books.forEach((key, value) {
            list.add(
              GeneratedBookItem(
                value['name'],
                value['author'],
                value['rating'] ?? 0,
                value['posterURL'],
                bookDetails: value,
              ),
            );
          });
          return Column(
            children: list,
          );
        }),
        // GeneratedBookItem(
        //   "The Alchemist",
        //   "Paulo Coelho",
        //   4,
        // ),
        // GeneratedBookItem(
        //   "The Alchemist",
        //   "Paulo Coelho",
        //   4,
        // ),
        // GeneratedBookItem(
        //   "The Alchemist",
        //   "Paulo Coelho",
        //   4,
        // ),
      ],
    );
  }
}
