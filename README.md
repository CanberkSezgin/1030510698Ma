# 🧮 Flutter Scientific Calculator

A fully functional, elegantly designed native Scientific Calculator app built with Flutter and Dart. This project was developed as part of my Mobile Application Development course.

## 🌟 Features

*   **Dark Mode Aesthetics**: True black UI with beautifully contrasting slate grey, vibrant orange, soft red, and forest green accents.
*   **Basic Arithmetic**: Addition (`+`), Subtraction (`-`), Multiplication (`×`), and Division (`÷`).
*   **Advanced Scientific Functions**:
    *   Trigonometry: `sin(`, `cos(`, `tan(`
    *   Logarithms: `log(`
    *   Square Root: `sqrt(`
    *   Exponents: `^`
*   **Expression Parsing**: Advanced string evaluation with proper parentheses handling using the `math_expressions` Dart package.
*   **Responsive Layout**: Engineered with Flutter's flexible layout systems to adapt natively to any screen size without overflow issues.

## 🚀 Tech Stack

*   **Language**: Dart
*   **Framework**: Flutter
*   **Key Dependencies**:
    *   [`math_expressions`](https://pub.dev/packages/math_expressions) - Core logic for safely building and evaluating complex mathematical strings.

## 🛠️ Architecture and Logic

The project uses a clean architectural approach focusing on straightforward state management using `setState`, maintaining modularity across the logic and UI tiers.

*   `calculator_logic.dart`: Abstracted mathematics logic handler. Parses custom calculator string syntax into tokens to be evaluated.
*   `calculator_screen.dart`: The primary orchestrator handling user inputs and widget state. 
*   `calculator_widgets.dart`: Decoupled Display screen and flexible Button Pad generator.
*   `calculator_button.dart`: Customizable UI template for individual interactive calculator buttons.

## 🏃‍♂️ How to Run the App

1. Ensure you have the Flutter SDK installed on your system.
2. Clone the repository:
   ```bash
   git clone https://github.com/CanberkSezgin/1030510698Ma.git
   ```
3. Navigate to the project directory:
   ```bash
   cd 1030510698Ma
   ```
4. Fetch dependencies:
   ```bash
   flutter pub get
   ```
5. Run the application (Chrome, Android, iOS, or Windows):
   ```bash
   flutter run
   ```

---
**Developer:** Canberk Sezgin
