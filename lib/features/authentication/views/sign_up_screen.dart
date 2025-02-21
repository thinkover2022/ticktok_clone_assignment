import 'package:flutter/material.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/constants/sizes.dart';
import 'package:ticktok_clone/features/authentication/views/login_form_screen.dart';
import 'package:ticktok_clone/features/authentication/views/username_screen.dart';
import 'package:ticktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/images/twitter-logo.svg'),
                  ],
                ),
                Gaps.v80,
                Text(
                  "See what's happening in the world right now",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
                ),
                Gaps.v80,

                AuthButton(
                  icon: SvgPicture.asset(
                    'assets/images/google-logo.svg',
                    width: 30,
                  ),
                  text: 'Continue with Google',
                  onPressed: () {},
                ),
                Gaps.v10,
                AuthButton(
                  icon: SvgPicture.asset(
                    'assets/images/apple-logo.svg',
                    width: 30,
                  ),
                  text: 'Continue with Apple',
                  onPressed: () {},
                ),
                Gaps.v10,
                //------------ or ------------
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                        endIndent: 8,
                      ),
                    ),
                    Text(
                      'or',
                      style: TextStyle(
                          fontSize: Sizes.size14, color: Colors.grey.shade600),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: Colors.grey.shade300,
                        indent: 8,
                      ),
                    ),
                  ],
                ),
                AuthButton(
                  isInverted: true,
                  text: 'Create account',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                        return UsernameScreen();
                      },
                    ));
                  },
                ),
                Gaps.v10,
                Row(
                  children: [
                    Text(
                      "By signing up, you agree to our",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Terms",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue.shade300),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Privacy Policy",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade300,
                      ),
                    ),
                    Text(
                      ", and ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Cookie Use",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue.shade300,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          top: Sizes.size32,
          bottom: Sizes.size64,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Have an account already?',
              style: TextStyle(
                fontSize: Sizes.size16,
              ),
            ),
            Gaps.h5,
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return LoginFormScreen();
                }));
              },
              child: Text(
                'Log in',
                style: TextStyle(
                  fontSize: Sizes.size16,
                  color: Colors.blue.shade300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
