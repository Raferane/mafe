import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Check firebase auth authentication
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      return null;
    }

    // If user is not authenticated, redirect to welcome screen
    return const RouteSettings(name: '/welcome');
  }
}
