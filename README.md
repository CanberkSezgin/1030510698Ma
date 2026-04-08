#  Flutter Scientific Calculator (Pro)

A highly polished, premium native Scientific Calculator app built with Flutter and Dart. This project has been upgraded to a "Pro" version featuring advanced error handling, comprehensive history tracking, a modern 5-column layout, and haptic feedback.

##  Pro Features

*   **Dark Premium Glassmorphism UI**: High-end true black gradient UI (`#0F172A` to `#020617`) with beautifully contrasting blurred glass panels and glowing operator buttons.
*   **5-Column Scientific Layout**: A reimagined, highly logical 5-column layout for scientific operations, providing a cleaner grouping of operators compared to standard 4-column calculators.
*   **Calculation History**: Integrated pull-down modal to view the last 10 calculations. Tapping a history item instantly restores the expression to the calculator display.
*   **Haptic UX**: Integrated `HapticFeedback.lightImpact()` combined with nuanced button scaling (`0.95x`) to provide a tactile, physical feel to every keypress.
*   **Advanced Error Trapping**: Intelligently catches parser errors and explicit division by zero (`÷0`), displaying clean "Syntax Error" or "Cannot divide by zero" messages instead of crashing.
*   **Large Number Formatting**: Automatically formats large numbers exceeding 10 digits into Scientific Notation or separates large integers with commas using the `intl` package.
*   **Native Splash Screen**: Implements a sleek, dark-themed native boot screen using the `flutter_native_splash` package for instantaneous startup feedback.

##  Built With

*   **Language**: Dart 3
*   **Framework**: Flutter
*   **Dependencies**:
    *   [`math_expressions`](https://pub.dev/packages/math_expressions) - Logic core for parsing complex strings
    *   [`intl`](https://pub.dev/packages/intl) - Advanced numerical formatting
    *   [`google_fonts`](https://pub.dev/packages/google_fonts) - Premium 'Inter' typography
    *   [`flutter_native_splash`](https://pub.dev/packages/flutter_native_splash) - Zero-delay start screen


##  Architecture

Maintained highly decoupled code architecture for scalability:

*   `calculator_logic.dart`: The brain—handles expression parsing, automated error detection, numerical formatting, and history tracking.
*   `calculator_screen.dart`: The scaffold—manages `setState` orchestration, the top App Bar, and the History Modal overlay.
*   `calculator_widgets.dart`: The body—comprises the blurred `CalculatorDisplay` and the responsive `CalculatorButtonPad`.
*   `calculator_button.dart`: The tactile component—manages stateful press animations, glassmorphic rendering, and haptic engine callbacks.

##  How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/CanberkSezgin/1030510698Ma.git
   ```
2. Fetch dependencies:
   ```bash
   flutter pub get
   ```
3. Run the application:
   ```bash
   flutter run
   ```

---
**Developer:** Canberk Sezgin
