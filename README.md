# Stateless or Stateful Widget

**Tip Calculator** mobile application built with Flutter,
demonstrating the use of both **Stateless** and **Stateful** widgets.

---

## 📱 Features

- Enter a bill amount
- Choose a tip percentage (5%, 10%, 15%, 20%, 25%)
- Split the bill among multiple people
- Instant breakdown: tip amount, total, and per-person cost

---

## 🧱 Widget Architecture

### Stateless Widgets
These widgets are **immutable** — they depend only on their constructor parameters and never change internally:

| Widget | File | Purpose |
|---|---|---|
| `TipCalculatorApp` | `main.dart` | Root app widget, sets up theme |
| `SectionHeader` | `widgets/section_header.dart` | Labelled section titles |
| `TipChip` | `widgets/tip_chip.dart` | Individual tip % selector chip |
| `ResultCard` | `widgets/result_card.dart` | Displays computed results |

### Stateful Widgets
These widgets **own mutable state** that can change during the app's lifecycle:

| Widget | File | State Managed |
|---|---|---|
| `HomeScreen` | `screens/home_screen.dart` | Bill amount, tip %, people count, result visibility |

---

## 🗂 Project Structure

```
lib/
├── main.dart                   ← App entry + root StatelessWidget
├── screens/
│   └── home_screen.dart        ← Main StatefulWidget
└── widgets/
    ├── section_header.dart     ← StatelessWidget
    ├── tip_chip.dart           ← StatelessWidget
    └── result_card.dart        ← StatelessWidget
```

---

## 🚀 Getting Started

```bash
# Install dependencies
flutter pub get

# Run on connected device or emulator
flutter run

# Build APK
flutter build apk --release
```

**Requirements:** Flutter SDK ≥ 3.0.0

---

## 🎓 Assignment Info

- **Course:** Mobile Application Development  
- **Topic:** Stateless vs Stateful Widgets in Flutter  
- **Framework:** Flutter (Dart)
