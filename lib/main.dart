import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ticktok_clone/app_theme.dart';
import 'package:ticktok_clone/firebase_options.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ticktok_clone/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  List<CameraDescription> cameras = [];
  try {
    cameras = await availableCameras();
  } catch (e) {
    debugPrint("Error initializing cameras: $e");
  }
  runApp(
    ProviderScope(
      overrides: [
        camerasProvider.overrideWithValue(cameras),
      ],
      child: TickTokApp(),
    ),
  );
}

class TickTokApp extends ConsumerWidget {
  const TickTokApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'TickTok Clone',
      themeMode: ThemeMode.light,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: router,
    );
  }
}
