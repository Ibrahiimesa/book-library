import 'dart:async';

import 'package:book_library/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatefulWidget {
  static const routeName = '/splash_screen';

  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isNotChangedPage = true;

  @override
  initState() {
    super.initState();
    Timer.periodic(const Duration(seconds: 5), (t) {
      isNotChangedPage
          ? Navigator.pushNamedAndRemoveUntil(
          context, MainScreen.routeName, (route) => false)
          : null;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
              image: AssetImage("assets/bg_library.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Book Library",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.titilliumWeb(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 300,
                ),
                Text(
                  "Ready to explore?",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.titilliumWeb(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "Books Library is an application that displays books. This application provides information about various books.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.robotoSlab(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    isNotChangedPage = false;
                    Navigator.pushNamedAndRemoveUntil(
                        context, MainScreen.routeName, (route) => false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    fixedSize: const Size(250, 60),
                    padding: const EdgeInsets.only(left: 20, right: 7),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 10),
                      Text(
                        "Get Started",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoSlab(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: Colors.black
                        ),
                      ),
                      const FloatingActionButton(
                        backgroundColor: Colors.white,
                        onPressed: null,
                        mini: true,
                        child: Icon(Icons.navigate_next_rounded),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}