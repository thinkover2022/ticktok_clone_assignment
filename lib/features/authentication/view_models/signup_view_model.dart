import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:ticktok_clone/utils/utils.dart';

class SignUpViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepo _authRepo;

  @override
  FutureOr<void> build() {
    _authRepo = ref.read(authRepo);
  }

  Future<void> signUp(BuildContext context) async {
    state = const AsyncValue.loading();
    final form = ref.read(signUpForm);

    state = await AsyncValue.guard(() async {
      await _authRepo.emailSignUp(
        form["email"],
        form["password"],
      );
    });
    if (state.hasError) {
      if (context.mounted) {
        showFirebaseErrorSnack(context, state.error);
      }
    } else {
      if (context.mounted) {
        context.go("/home");
      }
    }
  }
}

final signUpForm = StateProvider((ref) => {});

final signUpProvider = AsyncNotifierProvider<SignUpViewModel, void>(
  () => SignUpViewModel(),
);
