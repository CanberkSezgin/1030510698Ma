import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'calculator_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock status bar style to match dark theme
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(const ScientificCalculatorApp());
}

/// Root widget for the Scientific Calculator application.
class ScientificCalculatorApp extends StatelessWidget {
  const ScientificCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scientific Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          surface: Colors.black,
          primary: Color(0xFFFF9500),
        ),
        useMaterial3: true,
      ),
      home: const CalculatorScreen(),
    );
  }
}
