import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String buttonText;
  final Color color;
  final Function() onPressed;

  const CalculatorButton({
    super.key,
    required this.buttonText,
    this.color = Colors.grey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(double.infinity, 60.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),
      child: Text(
        buttonText,
        style: const TextStyle(fontSize: 24.0),
      ),
    );
  }
}
