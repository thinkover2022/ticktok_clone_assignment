import 'package:flutter/material.dart';
import 'package:ticktok_clone/constants/sizes.dart';

class AuthButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool isInverted;
  final Color bgColor;
  final Color fgColor;
  final bool isDisabled;
  const AuthButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isInverted=false, this.bgColor=Colors.white,  this.fgColor=Colors.black,
    this.isDisabled=false,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: GestureDetector(
        onTap: isDisabled? null :onPressed,
        child: Container(
          height: 60,
          padding: EdgeInsets.all(Sizes.size14),
          decoration: BoxDecoration(
            color: isDisabled?Colors.grey:(isInverted == true? fgColor : bgColor),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300, width: Sizes.size2),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: icon ?? SizedBox.shrink(),
              ),
              Text(
                textAlign: TextAlign.center,
                text,
                style: TextStyle(
                  color:isDisabled? Colors.grey.shade200: (isInverted == true
                      ? bgColor
                      : fgColor),
                  fontSize: Sizes.size18,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
