import 'package:flutter/material.dart';

class NavTab extends StatelessWidget {
  const NavTab(
      {super.key,
      required this.text,
      required this.isSelected,
      required this.icon,
      required this.onTap});
  final String text;
  final bool isSelected;
  final IconData icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: AnimatedOpacity(
        opacity: isSelected ? 1 : 0.3,
        duration: Duration(milliseconds: 300),
        child: IgnorePointer(
          ignoring: false,
          child: Tooltip(
            message: text,
            waitDuration: Duration(milliseconds: 500),
            showDuration: Duration(seconds: 2),
            textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor),
            child: Icon(
              icon,
            ),
          ),
        ),
      ),
    );
  }
}
