import 'package:flutter/material.dart';

import 'core/theme/colors.dart';
import 'core/widgets/splash.dart'; // uses AnimatedAnifyBackground internally

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AnifyApp());
}

class AnifyApp extends StatelessWidget {
  const AnifyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ThemeData(
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accent,
        brightness: Brightness.dark,
      ),
      useMaterial3: true,
      fontFamily: 'Poppins',
      scaffoldBackgroundColor: Colors.black,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Anify',
      theme: theme,
      home: const SplashPage(),
    );
  }
}
