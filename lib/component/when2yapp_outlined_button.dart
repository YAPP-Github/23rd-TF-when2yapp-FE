import 'package:flutter/material.dart';

class When2YappOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String labelText;

  When2YappOutlinedButton({
    required this.onPressed,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(labelText),
            ],
          ),
        ),
      ),
    );
  }
}
