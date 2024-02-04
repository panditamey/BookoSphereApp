import 'package:bookosphere/screens/bookDetails.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  BookItem(String this.name, String this.author, num this.ratings,
      String this.poster,
      {super.key, required this.bookDetails});
  final String name;
  final String author;
  final String poster;
  final num ratings;
  final bookDetails;
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
        margin: const EdgeInsets.all(5),
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
            Container(
              width: MediaQuery.of(context).size.width - 120,
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name.toString(),
                    textAlign: TextAlign.justify,
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
          ],
        ),
      ),
    );
  }
}

class BookList extends StatefulWidget {
  BookList(String this.s,
      {super.key, required Map<String, dynamic> this.books});
  final String s;
  final Map<String, dynamic> books;

  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.s.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("see more");
                },
                child: const Text(
                  "see more",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
        // BookItem(
        //   "The Alchemist",
        //   "Paulo Coelho",
        //   4,
        // ),
        Builder(builder: (BuildContext context) {
          List<Widget> list = [];
          widget.books.forEach((key, value) {
            list.add(
              BookItem(
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
        // BookItem(
        //   "The Alchemist",
        //   "Paulo Coelho",
        //   4,
        // ),
        // BookItem(
        //   "The Alchemist",
        //   "Paulo Coelho",
        //   4,
        // ),
        // BookItem(
        //   "The Alchemist",
        //   "Paulo Coelho",
        //   4,
        // ),
      ],
    );
  }
}
