import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calculator_button.dart';

/// The display area of the calculator showing the current expression
/// and the computed result. Features a subtle glass blur effect.
class CalculatorDisplay extends StatelessWidget {
  final String expression;
  final String result;
  final VoidCallback onHistoryTap;

  const CalculatorDisplay({
    super.key,
    required this.expression,
    required this.result,
    required this.onHistoryTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // History Icon at top right of display
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: Icon(Icons.history, color: Colors.white.withValues(alpha: 0.4)),
                    onPressed: onHistoryTap,
                    tooltip: 'Show History',
                  ),
                ),
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
                const SizedBox(height: 8),
                // Result text — scales down for very long numbers
                FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerRight,
                  child: Text(
                    result,
                    style: TextStyle(
                      color: (result == 'Error' || result == 'Syntax Error' || result == 'Cannot divide by zero') 
                             ? const Color(0xFFFF6B81) 
                             : Colors.white,
                      fontSize: 48,
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

/// The button pad containing a new Pro 5-column layout
class CalculatorButtonPad extends StatelessWidget {
  final Function(String) onButtonPressed;

  const CalculatorButtonPad({
    super.key,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Column(
        children: [
          // Row 1: Scientific functions (5 columns layout)
          _expandedRow([
            _btn('sin(', CalcButtonStyle.scientific),
            _btn('cos(', CalcButtonStyle.scientific),
            _btn('tan(', CalcButtonStyle.scientific),
            _btn('log(', CalcButtonStyle.scientific),
            _btn('sqrt(', CalcButtonStyle.scientific),
          ]),
          // Row 2: Secondary ops & clear (5 columns layout)
          _expandedRow([
            _btn('^', CalcButtonStyle.scientific),
            _btn('(', CalcButtonStyle.scientific),
            _btn(')', CalcButtonStyle.scientific),
            _btn('⌫', CalcButtonStyle.delete_),
            _btn('C', CalcButtonStyle.clear),
          ]),
          // Row 3: 7, 8, 9, ÷ (4 columns for the rest, looks cleaner for nums)
          _expandedRow([
            _btn('7', CalcButtonStyle.numeric),
            _btn('8', CalcButtonStyle.numeric),
            _btn('9', CalcButtonStyle.numeric),
            _btn('÷', CalcButtonStyle.operator_),
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
          // Row 6: 0, ., =, +
          _expandedRow([
            _btn('0', CalcButtonStyle.numeric),
            _btn('.', CalcButtonStyle.numeric),
            _btn('=', CalcButtonStyle.equals),
            _btn('+', CalcButtonStyle.operator_),
          ]),
        ],
      ),
    );
  }

  Widget _expandedRow(List<Widget> children) {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: children,
      ),
    );
  }

  Widget _btn(String label, CalcButtonStyle style, {int flex = 1}) {
    return CalculatorButton(
      label: label,
      style: style,
      flex: flex,
      onPressed: () => onButtonPressed(label),
    );
  }
}
