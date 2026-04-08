import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calculator_logic.dart';
import 'calculator_widgets.dart';

/// The main screen of the Scientific Calculator (Pro Version).
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

  void _showHistoryModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        final history = _logic.history;
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFF0F172A).withValues(alpha: 0.95),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'History',
                      style: GoogleFonts.inter(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Expanded(
                      child: history.isEmpty
                          ? Center(
                              child: Text(
                                'No history yet.',
                                style: GoogleFonts.inter(
                                  color: Colors.white.withValues(alpha: 0.4),
                                  fontSize: 16,
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: history.length,
                              separatorBuilder: (_, __) => Divider(color: Colors.white.withValues(alpha: 0.05)),
                              itemBuilder: (context, index) {
                                final item = history[index];
                                return ListTile(
                                  title: Text(
                                    item['expression'] ?? '',
                                    style: TextStyle(color: Colors.white.withValues(alpha: 0.6), fontSize: 18),
                                  ),
                                  trailing: Text(
                                    item['result'] ?? '',
                                    style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _logic.restoreHistory(item['expression'] ?? '');
                                    });
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Pro App Header
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B00).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.calculate_outlined, color: Color(0xFFFF6B00)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Scientific Calculator',
                        style: GoogleFonts.inter(
                          color: Colors.white.withValues(alpha: 0.9),
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Column(
                      children: [
                        // Display Box
                        SizedBox(
                          height: constraints.maxHeight * 0.35,
                          child: CalculatorDisplay(
                            expression: _logic.expression,
                            result: _logic.result,
                            onHistoryTap: _showHistoryModal,
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
                        // 5-Column Pro Button Pad
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
