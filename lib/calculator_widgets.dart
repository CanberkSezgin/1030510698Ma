import 'dart:ui';
import 'package:flutter/material.dart';
import 'calculator_button.dart';

/// The display area of the calculator showing the current expression
/// and the computed result. Features a subtle glass blur effect.
class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Spacer(),
                // Expression text (scrollable for long expressions)
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  reverse: true,
                  child: Text(
                    expression.isEmpty ? '' : expression,
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.5),
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Result text — scales down for very long numbers
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 56,
                      fontWeight: FontWeight.w300,
                      letterSpacing: 1,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// The button pad containing all calculator buttons arranged in a grid.
/// Uses Expanded rows so buttons scale with available height.
class CalculatorButtonPad extends StatelessWidget {
  final Function(String) onButtonPressed;

  const CalculatorButtonPad({
    super.key,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          // Row 1: Scientific functions
          _expandedRow([
            _btn('sin(', CalcButtonStyle.scientific),
            _btn('cos(', CalcButtonStyle.scientific),
            _btn('tan(', CalcButtonStyle.scientific),
            _btn('log(', CalcButtonStyle.scientific),
          ]),
          // Row 2: More scientific + parentheses
          _expandedRow([
            _btn('sqrt(', CalcButtonStyle.scientific),
            _btn('^', CalcButtonStyle.scientific),
            _btn('(', CalcButtonStyle.scientific),
            _btn(')', CalcButtonStyle.scientific),
          ]),
          // Row 3: 7, 8, 9, +
          _expandedRow([
            _btn('7', CalcButtonStyle.numeric),
            _btn('8', CalcButtonStyle.numeric),
            _btn('9', CalcButtonStyle.numeric),
            _btn('+', CalcButtonStyle.operator_),
          ]),
          // Row 4: 4, 5, 6, ×
          _expandedRow([
            _btn('4', CalcButtonStyle.numeric),
            _btn('5', CalcButtonStyle.numeric),
            _btn('6', CalcButtonStyle.numeric),
            _btn('×', CalcButtonStyle.operator_),
          ]),
          // Row 5: 1, 2, 3, -
          _expandedRow([
            _btn('1', CalcButtonStyle.numeric),
            _btn('2', CalcButtonStyle.numeric),
            _btn('3', CalcButtonStyle.numeric),
            _btn('-', CalcButtonStyle.operator_),
          ]),
          // Row 6: 0, ., ⌫, ÷
          _expandedRow([
            _btn('0', CalcButtonStyle.numeric),
            _btn('.', CalcButtonStyle.numeric),
            _btn('⌫', CalcButtonStyle.delete_),
            _btn('÷', CalcButtonStyle.operator_),
          ]),
          // Row 7: C (clear) and = (equals) — each spanning 2 columns
          _expandedRow([
            _btn('C', CalcButtonStyle.clear, flex: 2),
            _btn('=', CalcButtonStyle.equals, flex: 2),
          ]),
        ],
      ),
    );
  }

  /// Wraps a row of buttons in Expanded so it fills vertical space equally.
  Widget _expandedRow(List<Widget> children) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  // Helper method for quicker button creation
  Widget _btn(String label, CalcButtonStyle style, {int flex = 1}) {
    return CalculatorButton(
      label: label,
      style: style,
      flex: flex,
      onPressed: () => onButtonPressed(label),
    );
  }
}
