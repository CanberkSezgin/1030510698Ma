import 'package:math_expressions/math_expressions.dart';

/// A clean logic class responsible for building, parsing,
/// and evaluating mathematical expressions for the Scientific Calculator.
class CalculatorLogic {
  String _expression = '';
  String _result = '0';

  String get expression => _expression;
  String get result => _result;

  /// Appends a value (number, operator, or function) to the current expression.
  void append(String value) {
    // If the last result was an error, start fresh on new input
    if (_result == 'Error') {
      _expression = '';
      _result = '0';
    }
    _expression += value;
  }

  /// Deletes the last character from the expression.
  void deleteLast() {
    if (_expression.isNotEmpty) {
      // Handle deleting multi-char tokens like "sin(", "cos(", "tan(", "log(", "sqrt("
      final functions = ['sin(', 'cos(', 'tan(', 'log(', 'sqrt('];
      for (final fn in functions) {
        if (_expression.endsWith(fn)) {
          _expression =
              _expression.substring(0, _expression.length - fn.length);
          return;
        }
      }
      _expression = _expression.substring(0, _expression.length - 1);
    }
  }

  /// Clears the entire expression and resets the result.
  void clear() {
    _expression = '';
    _result = '0';
  }

  /// Evaluates the current expression and updates the result.
  void evaluate() {
    if (_expression.isEmpty) return;

    try {
      // Prepare the expression string for the parser
      String prepared = _prepareExpression(_expression);

      GrammarParser parser = GrammarParser();
      Expression exp = parser.parse(prepared);
      ContextModel cm = ContextModel();

      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      // Format the result: remove trailing .0 for whole numbers
      if (evalResult == evalResult.toInt().toDouble() &&
          !evalResult.isInfinite &&
          !evalResult.isNaN) {
        _result = evalResult.toInt().toString();
      } else {
        _result = evalResult.toStringAsFixed(8);
        // Remove trailing zeros after decimal point
        _result = _result.replaceAll(RegExp(r'0+$'), '');
        _result = _result.replaceAll(RegExp(r'\.$'), '');
      }

      if (evalResult.isInfinite || evalResult.isNaN) {
        _result = 'Error';
      }
    } catch (e) {
      _result = 'Error';
    }
  }

  /// Prepares the raw expression string for the math_expressions parser.
  /// Converts display symbols to parser-compatible format.
  String _prepareExpression(String expr) {
    String prepared = expr;

    // Replace display multiplication and division symbols
    prepared = prepared.replaceAll('×', '*');
    prepared = prepared.replaceAll('÷', '/');

    // Replace '^' with the parser's power syntax: use 'power' function call
    // math_expressions supports ^ as power operator natively
    // No replacement needed for ^

    // Auto-close any unclosed parentheses
    int openCount = '('.allMatches(prepared).length;
    int closeCount = ')'.allMatches(prepared).length;
    for (int i = 0; i < openCount - closeCount; i++) {
      prepared += ')';
    }

    return prepared;
  }
}
