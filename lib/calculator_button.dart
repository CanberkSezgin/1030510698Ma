import 'dart:ui';
import 'package:flutter/material.dart';

/// Enum-like class defining visual categories for calculator buttons.
/// Each category now carries gradient, glow, and glass properties
/// for the premium dark-glassmorphism design language.
enum CalcButtonStyle {
  scientific,
  numeric,
  operator_,
  delete_,
  clear,
  equals,
}

/// Returns the gradient colors for a given button style.
List<Color> gradientForStyle(CalcButtonStyle style) {
  switch (style) {
    case CalcButtonStyle.scientific:
      return [
        Colors.white.withValues(alpha: 0.08),
        Colors.white.withValues(alpha: 0.03),
      ];
    case CalcButtonStyle.numeric:
      return [
        const Color(0xFF1E293B).withValues(alpha: 0.7),
        const Color(0xFF0F172A).withValues(alpha: 0.5),
      ];
    case CalcButtonStyle.operator_:
      return [
        const Color(0xFFFF6B00),
        const Color(0xFFE11D48),
      ];
    case CalcButtonStyle.delete_:
      return [
        const Color(0xFFFF6B81).withValues(alpha: 0.85),
        const Color(0xFFE11D48).withValues(alpha: 0.65),
      ];
    case CalcButtonStyle.clear:
      return [
        const Color(0xFFDC2626).withValues(alpha: 0.85),
        const Color(0xFF991B1B).withValues(alpha: 0.75),
      ];
    case CalcButtonStyle.equals:
      return [
        const Color(0xFF10B981),
        const Color(0xFF059669),
      ];
  }
}

/// Returns the border color for a given button style (glass effect).
Color borderForStyle(CalcButtonStyle style) {
  switch (style) {
    case CalcButtonStyle.scientific:
      return Colors.white.withValues(alpha: 0.15);
    case CalcButtonStyle.numeric:
      return Colors.white.withValues(alpha: 0.06);
    case CalcButtonStyle.operator_:
      return const Color(0xFFFF6B00).withValues(alpha: 0.4);
    case CalcButtonStyle.delete_:
      return const Color(0xFFFF6B81).withValues(alpha: 0.3);
    case CalcButtonStyle.clear:
      return const Color(0xFFDC2626).withValues(alpha: 0.3);
    case CalcButtonStyle.equals:
      return const Color(0xFF10B981).withValues(alpha: 0.45);
  }
}

/// Returns optional glow shadow for elevated button styles.
List<BoxShadow> glowForStyle(CalcButtonStyle style) {
  switch (style) {
    case CalcButtonStyle.operator_:
      return [
        BoxShadow(
          color: const Color(0xFFFF6B00).withValues(alpha: 0.25),
          blurRadius: 12,
          spreadRadius: 0,
        ),
      ];
    case CalcButtonStyle.equals:
      return [
        BoxShadow(
          color: const Color(0xFF10B981).withValues(alpha: 0.35),
          blurRadius: 16,
          spreadRadius: 1,
        ),
      ];
    default:
      return [];
  }
}

/// A premium glassmorphism calculator button with press animation,
/// gradient fill, frosted-glass border, and optional glow shadow.
class CalculatorButton extends StatefulWidget {
  final String label;
  final CalcButtonStyle style;
  final VoidCallback onPressed;
  final int flex;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.style,
    required this.onPressed,
    this.flex = 1,
  });

  @override
  State<CalculatorButton> createState() => _CalculatorButtonState();
}

class _CalculatorButtonState extends State<CalculatorButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails _) => _animController.forward();
  void _handleTapUp(TapUpDetails _) {
    _animController.reverse();
    widget.onPressed();
  }

  void _handleTapCancel() => _animController.reverse();

  @override
  Widget build(BuildContext context) {
    final gradientColors = gradientForStyle(widget.style);
    final borderColor = borderForStyle(widget.style);
    final glow = glowForStyle(widget.style);

    return Expanded(
      flex: widget.flex,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: AnimatedBuilder(
          animation: _scaleAnim,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnim.value,
              child: child,
            );
          },
          child: GestureDetector(
            onTapDown: _handleTapDown,
            onTapUp: _handleTapUp,
            onTapCancel: _handleTapCancel,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: borderColor, width: 1),
                boxShadow: glow,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: BackdropFilter(
                  filter: widget.style == CalcButtonStyle.scientific ||
                          widget.style == CalcButtonStyle.numeric
                      ? ImageFilter.blur(sigmaX: 8, sigmaY: 8)
                      : ImageFilter.blur(sigmaX: 0, sigmaY: 0),
                  child: Center(
                    child: _buildLabel(),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel() {
    if (widget.label == '⌫') {
      return Icon(
        Icons.backspace_outlined,
        color: Colors.white.withValues(alpha: 0.95),
        size: 22,
      );
    }

    // Operator and equals text is a touch bolder
    final bool isBold = widget.style == CalcButtonStyle.operator_ ||
        widget.style == CalcButtonStyle.equals;

    return Text(
      widget.label,
      style: TextStyle(
        color: Colors.white.withValues(alpha: 0.95),
        fontSize: isBold ? 22 : 18,
        fontWeight: isBold ? FontWeight.w700 : FontWeight.w500,
        letterSpacing: 0.5,
      ),
    );
  }
}
