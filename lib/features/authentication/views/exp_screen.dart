import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/constants/sizes.dart';

class ExpScreen extends StatefulWidget {
  const ExpScreen({super.key});

  @override
  State<ExpScreen> createState() => _ExpScreenState();
}

class _ExpScreenState extends State<ExpScreen> {
  bool _isToggled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: Sizes.size36,
            ),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          if (_isToggled) {
                            Navigator.pop(context, 'signup');
                          } else {
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child:
                            SvgPicture.asset('assets/images/twitter-logo.svg')),
                  ],
                ),
                Gaps.v40,
                Text(
                  "Customize your experience",
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                Text(
                  "Track where you see Twitter content across the web",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Text(
                          "Twitter uses this data to personalize your experience. This web browsing history will never be stored with your name, email, or phone number.",
                          style: TextStyle(
                            fontSize: Sizes.size18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                    Switch(
                      value: _isToggled,
                      onChanged: (value) {
                        _isToggled = value;
                        setState(() {});
                      },
                      activeColor: Colors.green,
                      activeTrackColor: Colors.green.shade300,
                      inactiveThumbColor: Colors.white,
                      inactiveTrackColor: Colors.grey,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
