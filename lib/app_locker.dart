import 'package:flutter/material.dart';
import 'dart:async';

class AppLocker {
  final DateTime lockTime;

  AppLocker({required this.lockTime});

  Widget checkLock(Widget app) {
    // Check if the current date and time is after the specified lock time
    if (DateTime.now().isAfter(lockTime)) {
      // Schedule the app to close shortly after launch if it's past lockTime
      Timer(Duration(seconds: 2), () {
        throw Exception("App has been disabled.");
      });

      // Display an error message briefly before the app crashes
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text(
              "This app is no longer available.",
              style: TextStyle(fontSize: 20, color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      );
    }

    // Return the actual app if before lockTime
    return app;
  }
}

