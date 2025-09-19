# TradeUpApp

TradeUpApp is a mobile application developed with Flutter, aimed at supporting trading, exchanging goods, and connecting users. The app features a clear architecture, easy to extend and maintain.

---

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Installation & Quick Start](#installation--quick-start)
- [Project Structure](#project-structure)
- [Naming Conventions](#naming-conventions)
- [Contributing](#contributing)
- [References](#references)

---

## Introduction

TradeUpApp is a cross-platform Flutter application, providing features such as posting, searching, chat, transaction management, etc. The app focuses on a smooth user experience and a modern, easy-to-use interface.

---

## Features

- User login/registration
- Profile management
- Post products/services
- Search and filter products/services
- Chat/messaging between users
- Transaction management
- Real-time notifications
- [Add more features if available]

---

## Installation & Quick Start

### Requirements

- Flutter SDK (>=3.x.x)
- Dart SDK
- Android Studio or VS Code
- Android/iOS device or emulator

### Instructions

1. **Clone the project:**

   ```bash
   git clone https://github.com/yourusername/tradeupapp.git
   cd tradeupapp
   ```

2. **Install dependencies:**

   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   flutter run
   ```

---

## Project Structure

```
lib/
├── constants/         # Common constants (colors, theme, ...)
├── firebase/          # Firebase config and services (auth, notification, database)
├── models/            # Data models (user, product, offer, ...)
├── screens/           # Main screens (authentication, main_app, shop, profile, chat, news, ...)
│   ├── authentication/    # Login, register, forgot password, onboarding
│   ├── main_app/          # Home, shop, profile, chat, news, ...
│   └── general/           # Supporting screens, search, share, ...
├── widgets/           # Reusable widgets (button, dialog, appbar, ...)
├── server/            # Internal server (Node.js, Express) for backend features
└── main.dart          # App entry point
```

The `assets/` folder contains images, fonts, and other static resources:

- `assets/images/`: UI images, icons, banners, ...
- `assets/fonts/`: Roboto font family

The `test/` folder contains widget test files.

Important configuration files:

- `pubspec.yaml`: Declares dependencies, assets, fonts
- `firebase.json`, `google-services.json`, `firebase_options.dart`: Firebase configuration
- `analysis_options.yaml`: Static code analysis rules
- `.github/workflows/flutter-ci.yml`: CI/CD with GitHub Actions

---

## Main Packages & Technologies

- **Flutter**: Cross-platform development (Android, iOS, Web, Desktop)
- **Firebase**: Authentication, Firestore, Notification
- **Node.js/Express**: Backend server (lib/server)
- **Provider/GetX**: State management (if used)
- **CI/CD**: GitHub Actions

---

## Build & Run Guide (Multi-platform)

### Android/iOS

```bash
flutter run
```

### Web

```bash
flutter run -d chrome
```

### Desktop (Windows, macOS, Linux)

```bash
flutter run -d windows # or -d macos, -d linux
```

### Run backend server (if used)

```bash
cd lib/server
npm install
npm start
```

---

## Main Modules Description

- **Authentication**: Login, register, forgot password, onboarding, complete personal info
- **Shop**: Product list, product details, post product, create offer, payment (Paypal, VNPay, ...)
- **Profile**: User profile, edit, purchase/sales history, saved products, change password, report, about us
- **Chat**: User-to-user chat, product chat, notifications
- **News**: News, system notifications
- **General**: Search, share, show notifications, ...
- **Widgets**: Reusable UI components (button, appbar, dialog, ...)
- **Server**: Backend API (Node.js/Express, if used)

---

## Resources

- `assets/images/`: Full set of icons, illustrations, banners, sample product images, ...
- `assets/fonts/`: Roboto font family

---

## Naming Conventions

- **screens:** `feature_folder_screen.dart`
- **widgets:** `feature_folder_widget.dart`
- **model:** `object_model.dart`
- **controller:** `object_controller.dart`

---

## Contributing

All contributions are welcome! Please create a pull request or issue if you want to contribute or report a bug.

---

## References

- [Flutter Documentation](https://docs.flutter.dev/)
- [Dart Documentation](https://dart.dev/guides)
- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

---

