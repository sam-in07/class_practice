import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    //info about screen...
    var size = MediaQuery.of(context).size;

    //info about appbar...
    var appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          setState(() {
            isClicked = !isClicked;
          });
        },
        child: Icon(CupertinoIcons.sparkles, color: Colors.red,),
      ),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        surfaceTintColor: Colors.white,
        toolbarHeight: appBarHeight * 1.5,
        title: Text(
          "Stack & Animations",
          style: GoogleFonts.poppins(
            fontSize: size.width * 0.041,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
            height: 0,
          ),
        ),
      ),

      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Stack(
          children: [


            //black container....
            AnimatedPositioned(
              duration: const Duration(milliseconds: 577),
              curve: Curves.linearToEaseOut,
              left: 21,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 577),
                curve: Curves.linearToEaseOut,
                height: size.height * .39,
                width: isClicked ? size.width - 21 - 21 : size.width * .35,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(isClicked ? 41 : 1000),
                ),
              ),
            ),

            //grey container...
            AnimatedPositioned(
              duration: const Duration(milliseconds: 577),
              curve: Curves.linearToEaseOut,
              left: isClicked ? 21 + 11 : size.width * .35 + 21 + 11,
              top: isClicked ? appBarHeight * .85 : 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 577),
                curve: Curves.linearToEaseOut,
                width: isClicked
                    ? size.width - 21 - 21 - 11 - 11
                    : size.width * .65 - 21 - 11 - 21,
                height: isClicked
                    ? size.height * .39 - appBarHeight * .85 - 11
                    : size.height * .20,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(isClicked ? 41 : 1000),
                ),
              ),
            ),

            //red container...
            AnimatedPositioned(
              duration: const Duration(milliseconds: 577),
              curve: Curves.linearToEaseOut,
              top: isClicked ? 7 : size.height * .20 + 11,
              left: isClicked
                  ? size.width * .5 - size.width * .23 * .5
                  : size.width * .35 + 21 + 11,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 577),
                curve: Curves.linearToEaseOut,
                width: isClicked
                    ? size.width * .23
                    : size.width * .65 - 21 - 11 - 21,
                height: isClicked
                    ? appBarHeight * .85 - 7 - 7
                    : size.height * .39 - size.height * .20 - 11,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(1000),
                ),
                child: isClicked
                    ? Center(
                  child: Text(
                    "cancel",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: size.width * .039,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      height: 0,
                    ),
                  ),
                )
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}





/*

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Reactive variable for GetX
    RxBool isClicked = false.obs;

    var size = MediaQuery.of(context).size;
    var appBarHeight = AppBar().preferredSize.height;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          isClicked.value = !isClicked.value;
        },
        backgroundColor: Colors.purple,
        child: const Icon(
          CupertinoIcons.sparkles,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white, // Changed to white to see the black containers better
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        toolbarHeight: appBarHeight * 1.5,
        centerTitle: true,
        title: Text(
          "Stack and Animation",
          style: GoogleFonts.poppins(
            fontSize: size.width * (3.9 / 100),
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Obx(() => Stack(
              children: [
                // 1. BLACK CONTAINER
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  left: 21,
                  top: 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: isClicked.value ? size.width - 42 : size.width * 0.35,
                    height: size.height * 0.39,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(isClicked.value ? 31 : 1000),
                    ),
                  ),
                ),

                // 2. BLUE CONTAINER (Added isClicked logic here)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  // Moves left when clicked
                  left: isClicked.value ? 32 : size.width * 0.35 + 32,
                  // Moves down when clicked
                  top: isClicked.value ? appBarHeight * 0.8 : 0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: isClicked.value
                        ? size.width - 64
                        : size.width * 0.5,
                    height: isClicked.value ? 100 : size.height * 0.21,
                    decoration: BoxDecoration(
                      color: Colors.blueAccent,
                      borderRadius: BorderRadius.circular(isClicked.value ? 20 : 1000),
                    ),
                  ),
                ),

                // 3. RED CONTAINER (Added isClicked logic here)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  // Moves to center-top when clicked
                  left: isClicked.value ? size.width * 0.35 : size.width * 0.35 + 32,
                  top: isClicked.value ? 10 : size.height * 0.21 + 11,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    width: isClicked.value ? size.width * 0.3 : size.width * 0.5,
                    height: isClicked.value ? 40 : size.height * (0.39 - 0.21) - 11,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(1000),
                    ),
                    child: isClicked.value
                      ? const Center(child: Text("Close", style: TextStyle(color: Colors.white)))
                      : null,
                  ),
                )
              ],
            )),
      ),
    );
  }
}


 */