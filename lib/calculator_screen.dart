import 'package:flutter/material.dart';
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
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          'Scientific Calculator',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                // Display area takes up ~35% of available height
                SizedBox(
                  height: constraints.maxHeight * 0.30,
                  child: CalculatorDisplay(
                    expression: _logic.expression,
                    result: _logic.result,
                  ),
                ),
                // Divider between display and buttons
                Container(
                  height: 1,
                  color: Colors.grey.withValues(alpha: 0.2),
                ),
                // Button pad takes up the remaining ~65%
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
    );
  }
}
