import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RootScreen extends StatelessWidget {
  const RootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Use a FutureBuilder to check auth state
    return FutureBuilder(
      future: Future.delayed(
        Duration(milliseconds: 1000),
      ), // Optional: for splash effect
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            backgroundColor: Color(0xffedf2f4),
            appBar: AppBar(backgroundColor: Color(0xffedf2f4)),
            body: Center(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    "Loading....",
                    style: TextStyle(
                      fontSize: 20,
                      color: Color(0xff545454),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 20),
                  CircularProgressIndicator(color: Color(0xff545454)),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        }
        final user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          // User is logged in
          Future.microtask(() => Get.offAllNamed('/home'));
        } else {
          // User is not logged in
          Future.microtask(() => Get.offAllNamed('/welcome'));
        }
        // Return an empty container while navigation happens
        return Scaffold(
          backgroundColor: Color(0xffedf2f4),
          appBar: AppBar(backgroundColor: Color(0xffedf2f4)),
          body: Center(
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "Loading....",
                  style: TextStyle(
                    fontSize: 20,
                    color: Color(0xff545454),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 20),
                CircularProgressIndicator(color: Color(0xff545454)),
                SizedBox(height: 20),
              ],
            ),
          ),
        );
      },
    );
  }
}
