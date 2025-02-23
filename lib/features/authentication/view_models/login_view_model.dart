import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktok_clone/features/authentication/repos/authentication_repo.dart';
import 'package:ticktok_clone/utils/utils.dart';

class LoginViewModel extends AsyncNotifier<void> {
  late final AuthenticationRepo _repository;
  Future<void> login(
      String email, String password, BuildContext context) async {
    state = AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      return await _repository.signIn(email, password);
    });

    if (!context.mounted) return;

    if (state.hasError) {
      showFirebaseErrorSnack(context, state.error);
    } else {
      context.go("/home");
    }
  }

  @override
  FutureOr<void> build() {
    _repository = ref.read(authRepo);
  }
}

final loginProvider = AsyncNotifierProvider<LoginViewModel, void>(
  () {
    return LoginViewModel();
  },
);
