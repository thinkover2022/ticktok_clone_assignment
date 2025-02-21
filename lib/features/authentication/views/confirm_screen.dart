import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/constants/sizes.dart';
import 'package:ticktok_clone/features/authentication/views/pw_screen.dart';
import 'package:ticktok_clone/features/authentication/widgets/auth_button.dart';

class ConfirmScreen extends StatefulWidget {
  final String email;
  const ConfirmScreen({super.key, required this.email});

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  
  final List<TextEditingController> _pwControllers = [];
  final List<String> _pw = List.generate(6, (idx) {
    return '';
  });
  final List<FocusNode> _focusNodes = [];
  bool isInputFinished(){
    for(var pw in _pw){
      if(pw.isEmpty)return false;
    }
    return true;
  }
  @override
  void initState() {
    super.initState();
    for (int i = 0; i < 6; i++) {
      final controller = TextEditingController();
      final focusNode = FocusNode();
      controller.addListener(() {
        setState(() {
          _pw[i] = controller.text;
        });
        // 다음 TextField로 포커스 이동
        if (controller.text.isNotEmpty && i < 5) {
          _focusNodes[i + 1].requestFocus();
        }
      });
      _pwControllers.add(controller);
      _focusNodes.add(focusNode);
    }
  }

  @override
  void dispose() {
    for (var controller in _pwControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
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
                "We Sent you a code",
                style: TextStyle(
                  fontSize: Sizes.size32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              Text(
                "Enter it below to verify",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                widget.email,
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                children: [
                  for (int i = 0; i < 6; i++) ...[
                    Expanded(
                      child: TextField(
                        keyboardType: TextInputType.number,
                        controller: _pwControllers[i],
                        focusNode: _focusNodes[i],
                        maxLength: 1, // 한 자리 숫자만 입력 가능
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
                    Gaps.h16,
                  ]
                ],
              ),
              Gaps.v10,
              if (isInputFinished())
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                          child: Icon(
                            Icons.check,
                            color: Colors.white,
                          ),
                        ),
                      ),
              Spacer(),
              AuthButton(text: "Next", onPressed: () {
                Navigator.push(context,MaterialPageRoute(builder: (context){
                  return PwScreen();
                }));
              },isDisabled: !isInputFinished(),isInverted: true,),
            ],
          ),
        ),
      ),
    );
  }
}
