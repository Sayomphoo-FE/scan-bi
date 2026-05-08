"# scan-bi 💰

A personal finance tracker app built with Flutter, featuring receipt scanning, multi-currency support, entry grouping, real-time monthly summaries, and Google Sign-In with Firestore backup.

---

## ✨ Features

- 📊 **Real-time Monthly Summary** — income, expenses, balance with animated progress bar
- 📷 **Receipt Scanning** — on-device ML Kit OCR auto-fills entries from photos
- 💱 **Multi-Currency** — supports THB, USD, EUR, JPY, GBP, SGD, CNY and more via Open Exchange Rates
- 🗂️ **Entry Grouping** — group related expenses (e.g., a single receipt with multiple items)
- ☁️ **Cloud Backup** — Google Sign-In + Firestore sync
- 🌙 **Dark Mode Friendly** — Material 3, blue-green color scheme

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter 3.x (iOS + Android) |
| State Management | Riverpod 2 (`flutter_riverpod`, `riverpod_annotation`) |
| Local DB | Drift (SQLite) |
| Receipt OCR | Google ML Kit Text Recognition (on-device) |
| Auth & Backup | Firebase Auth + Cloud Firestore |
| Exchange Rates | Open Exchange Rates API (HTTP) |
| Navigation | go_router |
| Formatting | intl (Thai + English) |

---

## 📁 Project Structure

```
lib/
├── main.dart
├── firebase_options.dart
├── app.dart
├── core/
│   ├── constants.dart
│   ├── extensions/
│   └── theme/
├── data/
│   ├── database/
│   ├── models/
│   ├── repositories/
│   └── services/
├── providers/
└── ui/
    ├── home/
    ├── entry/
    ├── group/
    └── settings/
```

---

## 🚀 Setup Instructions

### 1. Prerequisites

- Flutter 3.x installed: https://flutter.dev/docs/get-started/install
- Dart SDK >= 3.3.0

### 2. Clone & Install

```bash
git clone https://github.com/Sayomphoo-FE/scan-bi.git
cd scan-bi
flutter pub get
```

### 3. Firebase Setup

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

> ⚠️ `lib/firebase_options.dart` is a placeholder. Run `flutterfire configure` to generate the real one.

### 4. Run

```bash
flutter run
```

---

## 📸 Screenshots

> _Screenshots will be added after first build._

---

## 📝 Notes

- **ML Kit**: Receipt scanning runs entirely **on-device**.
- **Android**: Minimum SDK version is 21 (required for ML Kit).
- **Drift codegen**: Run `flutter pub run build_runner build` after modifying database tables.

---

## 📄 License

MIT" 
