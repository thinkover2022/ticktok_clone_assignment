import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktok_clone/features/authentication/views/create_account_screen.dart';
import 'package:ticktok_clone/features/authentication/views/sign_in_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/activity_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/home_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/main_navigation_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/profile_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/search_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/write_screen.dart';

final camerasProvider = Provider<List<CameraDescription>>((ref) {
  return [];
});
final routerProvider = Provider.autoDispose<GoRouter>(
  (ref) {
    final cameras = ref.watch(camerasProvider);
    return GoRouter(initialLocation: SignInScreen.routeURL, routes: [
      GoRoute(
        path: SignInScreen.routeURL,
        builder: (context, state) {
          return SignInScreen();
        },
      ),
      GoRoute(
        path: CreateAccountScreen.routeURL,
        builder: (context, state) {
          return CreateAccountScreen();
        },
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigationScreen(
            cameras: cameras,
            child: child,
          );
        },
        routes: [
          GoRoute(
            path: "/home",
            builder: (context, state) {
              final toggleFunc = state.extra as Function(bool)?;
              return HomeScreen(
                toggleAppBar: toggleFunc ?? (bool _) {},
              );
            },
          ),
          GoRoute(
            path: "/search",
            builder: (context, state) {
              final query = state.extra as String;
              return SearchScreen(query: query);
            },
          ),
          GoRoute(
            path: "/write",
            builder: (context, state) {
              return WriteScreen(
                cameras: cameras,
              );
            },
          ),
          GoRoute(
            path: "/activity",
            builder: (context, state) {
              return ActivityScreen();
            },
          ),
          GoRoute(
            path: "/profile",
            builder: (context, state) {
              return ProfileScreen();
            },
          ),
        ],
      ),
    ]);
  },
);
