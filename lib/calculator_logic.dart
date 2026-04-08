import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';

/// A clean logic class responsible for building, parsing,
/// and evaluating mathematical expressions for the Scientific Calculator.
class CalculatorLogic {
  String _expression = '';
  String _result = '0';
  
  // History tracking (stores up to the last 10 equations)
  final List<Map<String, String>> _history = [];

  String get expression => _expression;
  String get result => _result;
  List<Map<String, String>> get history => _history;

  /// Appends a value (number, operator, or function) to the current expression.
  void append(String value) {
    if (_result == 'Error' || _result == 'Syntax Error' || _result == 'Cannot divide by zero') {
      _expression = '';
      _result = '0';
    }
    _expression += value;
  }

  /// Deletes the last character from the expression.
  void deleteLast() {
    if (_expression.isNotEmpty) {
      final functions = ['sin(', 'cos(', 'tan(', 'log(', 'sqrt('];
      for (final fn in functions) {
        if (_expression.endsWith(fn)) {
          _expression = _expression.substring(0, _expression.length - fn.length);
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
  
  /// Restores a past calculation to the current display
  void restoreHistory(String pastExpression) {
    _expression = pastExpression;
    _result = '';
  }

  /// Evaluates the current expression and updates the result.
  void evaluate() {
    if (_expression.isEmpty) return;

    // Advanced Error Trap: Catch explicitly typed division by zero
    if (_expression.contains('÷0') || _expression.endsWith('÷0')) {
      _result = 'Cannot divide by zero';
      return;
    }

    try {
      String prepared = _prepareExpression(_expression);
      GrammarParser parser = GrammarParser();
      Expression exp = parser.parse(prepared);
      ContextModel cm = ContextModel();

      double evalResult = exp.evaluate(EvaluationType.REAL, cm);

      // Handle computational infinity or NaN
      if (evalResult.isInfinite || evalResult.isNaN) {
         if (evalResult.isInfinite && prepared.contains('/0')) {
            _result = 'Cannot divide by zero';
         } else {
            _result = 'Error';
         }
         return;
      }

      // Format the result cleanly
      _result = _formatResult(evalResult);
      
      // Add to history
      _addToHistory(_expression, _result);
      
    } catch (e) {
      // Syntax Errors from the parser (e.g., hanging "sin(")
      _result = 'Syntax Error';
    }
  }
  
  /// Formats the numerical result for large numbers or decimals
  String _formatResult(double evalResult) {
     // If it's a whole number
     if (evalResult == evalResult.toInt().toDouble()) {
        int intResult = evalResult.toInt();
        // If it's too large, use exponential notation
        if (intResult.toString().length > 10) {
           return evalResult.toStringAsExponential(5);
        }
        // Otherwise use nice comma separation
        final formatter = NumberFormat('#,###');
        return formatter.format(intResult);
     } else {
        // It's a decimal number
        String decimalResult = evalResult.toStringAsFixed(8);
        decimalResult = decimalResult.replaceAll(RegExp(r'0+$'), '');
        decimalResult = decimalResult.replaceAll(RegExp(r'\.$'), '');
        
        // If the number before the decimal is very large
        if (decimalResult.split('.')[0].length > 10) {
            return evalResult.toStringAsExponential(5);
        }
        return decimalResult;
     }
  }
  
  void _addToHistory(String expr, String res) {
     _history.insert(0, {'expression': expr, 'result': res});
     if (_history.length > 10) {
        _history.removeLast(); // Keep only last 10
     }
  }

  /// Prepares the raw expression string for the math_expressions parser.
  String _prepareExpression(String expr) {
    String prepared = expr;
    prepared = prepared.replaceAll('×', '*');
    prepared = prepared.replaceAll('÷', '/');

    // Auto-close any unclosed parentheses
    int openCount = '('.allMatches(prepared).length;
    int closeCount = ')'.allMatches(prepared).length;
    for (int i = 0; i < openCount - closeCount; i++) {
      prepared += ')';
    }

    return prepared;
  }
}
