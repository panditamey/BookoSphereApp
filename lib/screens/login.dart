import 'package:bookosphere/constants/colors.dart';
import 'package:bookosphere/functions.dart';
import 'package:bookosphere/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  ValueNotifier userCredential = ValueNotifier('');
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) {
        //       return Login();
        //     },
        //   ),
        // );
      } else {
        print('User is signed in!');
        print(user.email);
        print(user.photoURL);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomeScreen(photoURL: user.photoURL.toString());
            },
          ),
        );
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryPurple,
      body: ValueListenableBuilder(
        valueListenable: userCredential,
        builder: (context, value, child) {
          return (userCredential.value == '' || userCredential.value == null)
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 100, 20, 20),
                        child:
                            Lottie.asset('assets/lottie/loginAnimation.json'),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                          color: WHITE,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Login / Sign Up",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            IconButton(
                              onPressed: () async {
                                userCredential.value = await signInWithGoogle();
                                if (userCredential.value != null) {
                                  print(userCredential.value.user!.email);
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(userCredential.value.user!.email
                                          .split('@')[0])
                                      .set({
                                    'name': userCredential.value.user!.email,
                                    'photoURL':
                                        userCredential.value.user!.photoURL,
                                  });
                                  // ignore: use_build_context_synchronously
                                  // Navigator.pushReplacement(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //     builder: (context) => HomeScreen(
                                  //         photoURL: userCredential
                                  //             .value.user!.photoURL
                                  //             .toString()),
                                  //   ),
                                  // );
                                }
                              },
                              icon: Image.asset(
                                'assets/icons/google.png',
                                height: 50,
                                width: 50,
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              : Login();
        },
      ),
    );
  }
}
