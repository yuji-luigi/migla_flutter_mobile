import 'package:flutter/material.dart';

extension Snackbar on BuildContext {
  void showSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(content: Text(message)));
  }

  void showErrorSnackbar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        action: SnackBarAction(label: 'OK', onPressed: () {})));
  }
}
