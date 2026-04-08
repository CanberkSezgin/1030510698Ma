import 'package:math_expressions/math_expressions.dart';
import 'package:intl/intl.dart';

class CalculatorLogic {
  String _expression = '';
  String _result = '0';
  
  // son islemleri tutmak icin
  final List<Map<String, String>> _history = [];

  String get expression => _expression;
  String get result => _result;
  List<Map<String, String>> get history => _history;

  void append(String value) {
    // hata varsa temizle
    if (_result == 'Error' || _result == 'Syntax Error' || _result == 'Cannot divide by zero') {
      _expression = '';
      _result = '0';
    }
    _expression += value;
  }

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

  void clear() {
    _expression = '';
    _result = '0';
  }
  
  void restoreHistory(String pastExpression) {
    _expression = pastExpression;
    _result = '';
  }

  void evaluate() {
    if (_expression.isEmpty) return;

    // sifira bolme hatasi engelleme
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

      if (evalResult.isInfinite || evalResult.isNaN) {
         if (evalResult.isInfinite && prepared.contains('/0')) {
            _result = 'Cannot divide by zero';
         } else {
            _result = 'Error';
         }
         return;
      }

      _result = _formatResult(evalResult);
      _addToHistory(_expression, _result);
      
    } catch (e) {
      _result = 'Syntax Error';
    }
  }
  
  String _formatResult(double evalResult) {
     if (evalResult == evalResult.toInt().toDouble()) {
        int intResult = evalResult.toInt();
        // cok buyuk sayilari duzenleme
        if (intResult.toString().length > 10) {
           return evalResult.toStringAsExponential(5);
        }
        final formatter = NumberFormat('#,###');
        return formatter.format(intResult);
     } else {
        String decimalResult = evalResult.toStringAsFixed(8);
        decimalResult = decimalResult.replaceAll(RegExp(r'0+$'), '');
        decimalResult = decimalResult.replaceAll(RegExp(r'\.$'), '');
        
        if (decimalResult.split('.')[0].length > 10) {
            return evalResult.toStringAsExponential(5);
        }
        return decimalResult;
     }
  }
  
  void _addToHistory(String expr, String res) {
     _history.insert(0, {'expression': expr, 'result': res});
     if (_history.length > 10) {
        _history.removeLast(); // maksimum 10 gecmis kaydi
     }
  }

  String _prepareExpression(String expr) {
    String prepared = expr;
    prepared = prepared.replaceAll('×', '*');
    prepared = prepared.replaceAll('÷', '/');

    // eksik parantezleri kapatmak icin
    int openCount = '('.allMatches(prepared).length;
    int closeCount = ')'.allMatches(prepared).length;
    for (int i = 0; i < openCount - closeCount; i++) {
      prepared += ')';
    }

    return prepared;
  }
}
