import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/constants/sizes.dart';
import 'package:ticktok_clone/features/authentication/views/confirm_screen.dart';
import 'package:ticktok_clone/features/authentication/views/exp_screen.dart';
import 'package:ticktok_clone/features/authentication/widgets/auth_button.dart';
import 'package:ticktok_clone/features/authentication/widgets/form_button.dart';

class UsernameScreen extends StatefulWidget {
  const UsernameScreen({super.key});

  @override
  State<UsernameScreen> createState() => _UsernameScreenState();
}

class _UsernameScreenState extends State<UsernameScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _numOrEmailController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  String _username = "";
  String _numOrEmail = "";
  String _dateOfBirth = "";
  String _receivedData = "";

  bool _enableDateOfBirth = false;
  late FocusNode _dateOfBirthFocusNode;

  DateTime initialDate = DateTime.now();
  bool isUserNameValid() {
    return _username.isNotEmpty;
  }

  bool isNumOfEmailValid() {
    if (_numOrEmail.isEmpty) return false;
    final regExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!regExp.hasMatch(_numOrEmail)) {
      return false;
    }
    return true;
  }

  bool isDateOfBirthValid() {
    return _dateOfBirth.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() {
      setState(() {
        _username = _usernameController.text;
      });
    });
    _numOrEmailController.addListener(() {
      setState(() {
        _numOrEmail = _numOrEmailController.text;
      });
    });
    _dateOfBirthController.addListener(() {
      setState(() {
        _dateOfBirth = _dateOfBirthController.text;
      });
    });
    _dateOfBirthFocusNode = FocusNode();
    _dateOfBirthFocusNode.addListener(() {
      if (_dateOfBirthFocusNode.hasFocus) {
        _enableDateOfBirth = true;
      } else {
        _enableDateOfBirth = false;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _numOrEmailController.dispose();
    _dateOfBirthController.dispose();
    _dateOfBirthFocusNode.dispose();
    super.dispose();
  }

  void _onNextTap() async {
    if (_username.isEmpty) return;
    if (_numOrEmail.isEmpty) return;
    if (_dateOfBirth.isEmpty) return;
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ExpScreen();
        },
      ),
    );
    if (result != null) {
      setState(() {
        _receivedData = result as String;
      });
    }
  }

  void _setTextFieldDate(DateTime date) {
    final textDate = date.toString().split(" ").first;
    _dateOfBirthController.value = TextEditingValue(text: textDate);
  }

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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: Sizes.size18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    SvgPicture.asset('assets/images/twitter-logo.svg'),
                  ],
                ),
                Gaps.v40,
                const Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v16,
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: "Name",
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
                        cursorColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    if (isUserNameValid())
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
                  ],
                ),
                Gaps.v20,
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _numOrEmailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "email address",
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
                        cursorColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    if (isNumOfEmailValid())
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
                  ],
                ),
                Gaps.v20,
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        readOnly: true,
                        focusNode: _dateOfBirthFocusNode,
                        controller: _dateOfBirthController,
                        decoration: InputDecoration(
                          hintText: "Date of birth",
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
                        cursorColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    if (isDateOfBirthValid())
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
                  ],
                ),
                if (_receivedData.isEmpty)
                  SizedBox(
                    child: Expanded(
                      child: Text(
                        "This will not be shown publicly. Confirm your own age, even if this account is for a business, a pet, or something else.",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                Gaps.v28,
                if (_receivedData.isEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: _onNextTap,
                          child: FormButton(
                            disabled: !(isUserNameValid() &&
                                isNumOfEmailValid() &&
                                isDateOfBirthValid()),
                          ),
                        ),
                      ),
                    ],
                  ),
                if (_receivedData.isEmpty &&
                    _enableDateOfBirth &&
                    isUserNameValid() &&
                    isNumOfEmailValid())
                  SizedBox(
                    height: 300,
                    child: CupertinoDatePicker(
                      maximumDate: initialDate,
                      initialDateTime: initialDate,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: _setTextFieldDate,
                    ),
                  ),
                if (_receivedData.isNotEmpty &&
                    _receivedData.matchAsPrefix('signup') != null)
                  SizedBox(
                    child: Expanded(
                      child: Text(
                        "By signing up, you agree to the Terms of Service and Privacy Policy, including Cookie Use. Twitter may use your contact information, including your email address and phone number for purposes outlined in our Privacy Policy, like keeping your account secure and personalizing our services, including ads. Learn more. Others will be able to find you by email or phone number, when provided, unless you choose otherwise here",
                        softWrap: true,
                        style: TextStyle(
                          fontSize: Sizes.size16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                if (_receivedData.isNotEmpty &&
                    _receivedData.matchAsPrefix('signup') != null)
                  Row(
                    children: [
                      Expanded(
                        child: AuthButton(
                            isInverted: true,
                            text: "Sign up",
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ConfirmScreen(email: _numOrEmail);
                              }));
                            }),
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
