import 'package:flutter/material.dart';
import 'package:task/screens/welcome_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final ValueNotifier<bool> isDarkMode = ValueNotifier(false);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
   return ValueListenableBuilder<bool>(
        valueListenable: isDarkMode,
        builder: (context, isDark, _) {
          return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
            theme: isDark ? ThemeData.dark() : ThemeData.light(),
      home: WelcomeScreen(),
    );
  }
    );}}
