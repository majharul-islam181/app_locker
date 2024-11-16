// import 'package:flutter/material.dart';
// import 'dart:async';

// class AppLocker {
//   final DateTime lockTime;

//   AppLocker({required this.lockTime});

//   Widget checkLock(Widget app) {
//     // Check if the current date and time is after the specified lock time
//     if (DateTime.now().isAfter(lockTime)) {
//       // Schedule the app to close shortly after launch if it's past lockTime
//       Timer(Duration(seconds: 2), () {
//         throw Exception("App has been disabled.");
//       });

//       // Display an error message briefly before the app crashes
//       return MaterialApp(
//         home: Scaffold(
//           body: Center(
//             child: Text(
//               "This app is no longer available.",
//               style: TextStyle(fontSize: 20, color: Colors.red),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ),
//       );
//     }

//     // Return the actual app if before lockTime
//     return app;
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';

class AppLocker {
  final DateTime lockTime;
  Timer? _timer;

  AppLocker({required this.lockTime});

  Widget checkLock(Widget app) {
    // Check if the app should be locked
    if (DateTime.now().isAfter(lockTime)) {
      return _buildLockedScreen();
    }

    // Start a timer to monitor the lock time during app usage
    _startMonitoring();

    return app;
  }

  void _startMonitoring() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (DateTime.now().isAfter(lockTime)) {
        // Lock the app if the lock time is reached
        _timer?.cancel();
        _showLockScreen();
      }
    });
  }

  void _showLockScreen() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Replace the current screen with the lock screen
      Navigator.of(navigatorKey.currentContext!).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => _buildLockedScreen()),
        (route) => false,
      );
    });
  }

  Widget _buildLockedScreen() {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(
            "App Locked",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// A global navigator key to access the current context
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
