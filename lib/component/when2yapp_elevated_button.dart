import 'package:flutter/material.dart';

class When2YappElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String labelText;

  When2YappElevatedButton({
    required this.onPressed,
    required this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
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
