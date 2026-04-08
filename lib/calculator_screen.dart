import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calculator_logic.dart';
import 'calculator_widgets.dart';

/// The main screen of the Scientific Calculator.
/// Uses setState for simple, clean state management.
class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final CalculatorLogic _logic = CalculatorLogic();

  void _onButtonPressed(String label) {
    setState(() {
      switch (label) {
        case 'C':
          _logic.clear();
          break;
        case '=':
          _logic.evaluate();
          break;
        case '⌫':
          _logic.deleteLast();
          break;
        default:
          _logic.append(label);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The high-end dark premium gradient background
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF0F172A), Color(0xFF020617)],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // Subtle modern app bar area
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Row(
                  children: [
                    Text(
                      'Scientific Calculator',
                      style: GoogleFonts.inter(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                ),
              ),
              // Main content
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        // Display area takes ~35% of height
                        SizedBox(
                          height: constraints.maxHeight * 0.35,
                          child: CalculatorDisplay(
                            expression: _logic.expression,
                            result: _logic.result,
                          ),
                        ),
                        // Soft divider
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Divider(
                            height: 1,
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                        // Button pad takes up the remaining height
                        // Using Expanded so rows scale properly
                        Expanded(
                          child: CalculatorButtonPad(
                            onButtonPressed: _onButtonPressed,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
