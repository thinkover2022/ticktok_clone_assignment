import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/features/authentication/view_models/login_view_model.dart';

class SignInScreen extends ConsumerStatefulWidget {
  static const routeURL = "/login";
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _numOrEmailController = TextEditingController();

  String _numOrEmail = "";
  String _password = "";

  bool isPasswordValid() {
    return _password.isNotEmpty && _password.length > 8;
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

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() {
      setState(() {
        _password = _passwordController.text;
      });
    });
    _numOrEmailController.addListener(() {
      setState(() {
        _numOrEmail = _numOrEmailController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("English(US)")),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gaps.v20,
              Center(
                child: FaIcon(
                  FontAwesomeIcons.threads,
                  size: 40,
                ),
              ),
              Gaps.v20,
              Row(
                children: [
                  TextFormField(
                    controller: _numOrEmailController,
                    decoration: InputDecoration(
                      hintText: 'Mobile number or email',
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
              Gaps.v16,
              Row(
                children: [
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
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
                  if (isPasswordValid())
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
              Gaps.v16,
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (isNumOfEmailValid() && isNumOfEmailValid()) {
                          ref
                              .read(loginProvider.notifier)
                              .login(_username, _numOrEmail, context);
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).brightness == Brightness.dark
                                ? Colors.grey
                                : Colors.blue,
                      ),
                      child: Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 24,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? null
                              : Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gaps.v16,
              Text(
                "Forgot password?",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              Spacer(),
              SizedBox(
                height: 200,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          context.push("/create_account");
                        },
                        style: TextButton.styleFrom(
                          side: BorderSide(
                            width: 2,
                            color: Colors.grey.shade300,
                          ),
                          backgroundColor:
                              Theme.of(context).brightness == Brightness.dark
                                  ? Colors.grey
                                  : Colors.white,
                        ),
                        child: Text(
                          "Create new account",
                          style: TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/images/meta-logo.svg',
                      height: 80,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
