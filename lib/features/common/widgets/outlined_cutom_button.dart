import 'package:flutter/material.dart';

class CustomOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isOutlined;
  final Color backgroundColor;
  final Color textColor;
  final Color borderColor;

  const CustomOutlinedButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.backgroundColor = Colors.blueAccent,
    this.textColor = Colors.white,
    this.borderColor = Colors.blueAccent,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: borderColor),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  color: textColor,
                ),
              ),
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                padding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  color: textColor,
                ),
              ),
            ),
    );
  }
}
