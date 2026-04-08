import 'package:flutter/material.dart';

/// Defines the button categories and their associated colors.
/// This keeps the color scheme consistent and centralized.
class ButtonType {
  /// Scientific function buttons (sin, cos, tan, log, sqrt, ^, (, ))
  static const Color scientific = Color(0xFF718093);

  /// Numeric buttons (0-9, .)
  static const Color numeric = Color(0xFF2d3436);

  /// Operator buttons (+, -, ×, ÷)
  static const Color operator_ = Color(0xFFFF9500);

  /// Delete / Backspace button
  static const Color delete_ = Color(0xFFFF6B81);

  /// Clear button
  static const Color clear = Color(0xFFFF4757);

  /// Equals button
  static const Color equals = Color(0xFF2ED573);
}

/// A single calculator button widget with consistent styling.
class CalculatorButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final int flex;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.color,
    required this.onPressed,
    this.flex = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(8),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: onPressed,
            splashColor: Colors.white24,
            highlightColor: Colors.white10,
            child: Container(
              alignment: Alignment.center,
              child: _buildLabel(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    // Backspace icon for delete button
    if (label == '⌫') {
      return const Icon(
        Icons.backspace_outlined,
        color: Colors.white,
        size: 24,
      );
    }

    return Text(
      label,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}
