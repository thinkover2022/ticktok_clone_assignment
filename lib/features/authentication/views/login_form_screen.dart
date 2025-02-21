import 'package:flutter/material.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/constants/sizes.dart';
import 'package:ticktok_clone/features/authentication/widgets/form_button.dart';

class LoginFormScreen extends StatelessWidget {
  LoginFormScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, String> formData = {};

  void _onSubmitTap() {
    if (_formKey.currentState != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();

        // context.goNamed(InterestsScreen.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log in'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.size36,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Gaps.v28,
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
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
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Plase write your email";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['email'] = newValue;
                  }
                },
              ),
              Gaps.v16,
              TextFormField(
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
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return "Plase write your password";
                  }
                  return null;
                },
                onSaved: (newValue) {
                  if (newValue != null) {
                    formData['password'] = newValue;
                  }
                },
              ),
              Gaps.v28,
              GestureDetector(
                onTap: _onSubmitTap,
                child: FormButton(
                  disabled: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
