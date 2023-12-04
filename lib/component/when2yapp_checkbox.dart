import 'package:flutter/material.dart';

class When2YappCheckBox extends StatefulWidget {
  final Color textColor = const Color(0xFFA09DA5);
  final Color selectedTextColor = Colors.black;
  final String textLabel;
  final ValueChanged<bool?> onChanged;

  const When2YappCheckBox({
    super.key,
    required this.textLabel,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() {
    return When2YappCheckBoxState();
  }
}

class When2YappCheckBoxState extends State<When2YappCheckBox> {
  late bool _isSelected;

  @override
  void initState() {
    _isSelected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapUp: (_) {
        setState(() {
          _isSelected = !_isSelected;
          widget.onChanged(_isSelected);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 18,
            right: 22,
            top: 15,
            bottom: 14,
          ),
          child: Row(
            children: [
              Text(
                widget.textLabel,
                style: TextStyle(
                  color:
                      _isSelected ? widget.selectedTextColor : widget.textColor,
                ),
              ),
              const Spacer(),
              Checkbox(
                value: _isSelected,
                onChanged: null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
