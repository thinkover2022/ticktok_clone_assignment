import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktok_clone/app_theme.dart';
import 'package:ticktok_clone/features/main_navigation/views/activity_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/home_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/main_navigation_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/profile_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/search_screen.dart';
import 'package:ticktok_clone/features/main_navigation/views/write_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  List<CameraDescription>? cameras;
  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint("Error initializing cameras: $e");
  }
  runApp(TickTokApp(
    cameras: cameras ?? [],
  ));
}

class TickTokApp extends StatelessWidget {
  final List<CameraDescription> cameras;
  const TickTokApp({super.key, required this.cameras});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'TickTok Clone',
        themeMode: ThemeMode.dark,
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        routerConfig: GoRouter(initialLocation: "/", routes: [
          ShellRoute(
            builder: (context, state, child) {
              return MainNavigationScreen(
                cameras: cameras,
                child: child,
              );
            },
            routes: [
              GoRoute(
                path: "/",
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
        ]));
  }
}
