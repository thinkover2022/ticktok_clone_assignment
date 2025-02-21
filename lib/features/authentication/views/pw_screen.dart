import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/constants/sizes.dart';
import 'package:ticktok_clone/features/authentication/views/interest_screen.dart';
import 'package:ticktok_clone/features/authentication/widgets/auth_button.dart';

class PwScreen extends StatefulWidget {
  const PwScreen({super.key});

  @override
  State<PwScreen> createState() => _PwScreenState();
}

class _PwScreenState extends State<PwScreen> {
  bool isPasswordVisible = false;
  final TextEditingController _pwController = TextEditingController();
  String _pw = "";

  bool isInputFinished() {
    if (_pw.length < 8) return false;
    return true;
  }

  @override
  void initState() {
    super.initState();
    _pwController.addListener(() {
      setState(() {
        _pw = _pwController.text;
      });
    });
  }

  @override
  void dispose() {
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SvgPicture.asset('assets/images/twitter-logo.svg'),
                  ),
                ],
              ),
              Gaps.v40,
              Text(
                "You'll need a password",
                style: TextStyle(
                  fontSize: Sizes.size32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                "Make sure it's 8 characters or more",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Row(children: [
                Expanded(
                  child: TextField(
                    obscureText: !isPasswordVisible,
                    controller: _pwController,
                    maxLength: 8, // 8 자리 숫자만 입력 가능
                    decoration: InputDecoration(
                      counterText: "", // 남은 글자 수 표시 제거
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.shade400,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isPasswordVisible = !isPasswordVisible;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isPasswordVisible ? Colors.green : Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: isPasswordVisible ? Colors.white : Colors.grey,
                    ),
                  ),
                ),
                if (isInputFinished()) ...[
                  Gaps.h16,
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ),
                ]
              ]),
              Spacer(),
              AuthButton(
                text: "Next",
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InterestScreen();
                  }));
                },
                isDisabled: !isInputFinished(),
                isInverted: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
