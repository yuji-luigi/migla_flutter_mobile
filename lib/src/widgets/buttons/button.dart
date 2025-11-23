import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

/// button used in auth forms
class Button extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final bool isLoading;
  const Button({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: 12,
          ),
          backgroundColor: actionPrimaryColor.withAlpha(isLoading ? 120 : 255),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: isLoading
            ? CircularProgressIndicator()
            : Text(text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                )),
      ),
    );
  }
}
