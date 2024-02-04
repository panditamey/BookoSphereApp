import 'package:bookosphere/components/book.dart';
import 'package:bookosphere/components/carousel.dart';
import 'package:bookosphere/components/kidsSplash.dart';
import 'package:bookosphere/constants/colors.dart';
import 'package:bookosphere/functions.dart';
import 'package:bookosphere/screens/generateScreen.dart';
import 'package:bookosphere/screens/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  Home({super.key, required String this.s});
  final String s;
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  get s => null;

  Map<String, dynamic> books = {};
  Map<String, dynamic> generatedBooks = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(s.toString());
    fetchRecords("books", books);
    fetchRecords("generatedbooks", generatedBooks);
  }

  fetchRecords(s, Map<String, dynamic> books) async {
    var result = await FirebaseFirestore.instance
        .collection(s)
        .where("public", isEqualTo: true);

    result.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        if (mounted)
          setState(() {
            books[change.doc.id] = change.doc.data();
          });
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(widget.s.toString(), scale: 0.5),
              radius: 20,
            ),
          ),
          onTap: () async {
            print('Profile');
            await signOutFromGoogle().then((value) => Navigator.pop(context));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return Login();
                },
              ),
            );
          },
        ),
        title: Image.asset(
          "assets/icons/appbar.png",
          width: MediaQuery.of(context).size.width / 2,
        ),
        backgroundColor: WHITE,
        centerTitle: true,
        foregroundColor: primaryPurple,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              child: Icon(Icons.search),
              onTap: () {
                print('Search');
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              CarousalComponent(),
              const SizedBox(
                height: 10,
              ),
              BookList("POPULAR", books: books),
              BookList("AI GENERATED", books: generatedBooks),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key, required String this.photoURL});
  final String photoURL;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  _changeTab(int index) {
    if (mounted)
      setState(() {
        _selectedTab = index;
      });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.photoURL);
  }

  Widget build(BuildContext context) {
    List _pages = [
      Home(s: widget.photoURL.toString()),
      // Center(
      //   child: Text("Generate"),
      // ),
      GenerateScreen(),

      SingleChildScrollView(
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height - 50,
            decoration: BoxDecoration(
              color: Colors.grey[200],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset('assets/lottie/launchKidsAnimation.json'),
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return KidsSplashScreen();
                        },
                      ),
                    );
                  },
                  child: Text("Launch Kids Section"),
                ),
              ],
            ),
          ),
        ),
      ),
    ];
    return Scaffold(
      body: _pages[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (index) => _changeTab(index),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/home.png",
                height: 30,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/generate.png",
                height: 30,
              ),
              label: "Generate"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/icons/ar.png",
                height: 30,
              ),
              label: "AR"),
        ],
      ),
    );
  }
}
