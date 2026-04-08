import 'package:flutter/material.dart';
import 'calculator_button.dart';

/// The display area of the calculator showing the current expression
/// and the computed result.
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      color: Colors.black,
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
                color: Colors.white.withValues(alpha: 0.6),
                fontSize: 22,
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Result text — scales down for very long numbers
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 52,
                fontWeight: FontWeight.w300,
                letterSpacing: 1,
              ),
              maxLines: 1,
            ),
          ),
        ],
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
      color: Colors.black,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: Column(
        children: [
          // Row 1: Scientific functions
          _expandedRow([
            _btn('sin(', ButtonType.scientific),
            _btn('cos(', ButtonType.scientific),
            _btn('tan(', ButtonType.scientific),
            _btn('log(', ButtonType.scientific),
          ]),
          // Row 2: More scientific + parentheses
          _expandedRow([
            _btn('sqrt(', ButtonType.scientific),
            _btn('^', ButtonType.scientific),
            _btn('(', ButtonType.scientific),
            _btn(')', ButtonType.scientific),
          ]),
          // Row 3: 7, 8, 9, +
          _expandedRow([
            _btn('7', ButtonType.numeric),
            _btn('8', ButtonType.numeric),
            _btn('9', ButtonType.numeric),
            _btn('+', ButtonType.operator_),
          ]),
          // Row 4: 4, 5, 6, ×
          _expandedRow([
            _btn('4', ButtonType.numeric),
            _btn('5', ButtonType.numeric),
            _btn('6', ButtonType.numeric),
            _btn('×', ButtonType.operator_),
          ]),
          // Row 5: 1, 2, 3, -
          _expandedRow([
            _btn('1', ButtonType.numeric),
            _btn('2', ButtonType.numeric),
            _btn('3', ButtonType.numeric),
            _btn('-', ButtonType.operator_),
          ]),
          // Row 6: 0, ., ⌫, ÷
          _expandedRow([
            _btn('0', ButtonType.numeric),
            _btn('.', ButtonType.numeric),
            _btn('⌫', ButtonType.delete_),
            _btn('÷', ButtonType.operator_),
          ]),
          // Row 7: C (clear) and = (equals) — each spanning 2 columns
          _expandedRow([
            _btn('C', ButtonType.clear, flex: 2),
            _btn('=', ButtonType.equals, flex: 2),
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

  Widget _btn(String label, Color color, {int flex = 1}) {
    return CalculatorButton(
      label: label,
      color: color,
      flex: flex,
      onPressed: () => onButtonPressed(label),
    );
  }
}
