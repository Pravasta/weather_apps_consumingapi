import 'package:flutter/material.dart';

class AppRoutes {
  static push(BuildContext context, routes) {
    return Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => routes,
      ),
    );
  }

  static pop(BuildContext context) {
    return Navigator.pop(context);
  }

  static pushRemove(BuildContext context, routes) {
    return Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => routes,
        ),
        (route) => false);
  }
}
