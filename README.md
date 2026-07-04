# SRKT B2B E-commerce Platform

This repository is organized as a monorepo containing both the mobile client application (named SRKT) and the backend services.

---

## 📁 Repository Structure

```
B2B_Ecommerce/
├── README.md               # Root documentation (this file)
├── SRKT/                   # Flutter Mobile Client Application
│   ├── lib/                # Dart source files (Models, Providers, Screens, Widgets)
│   └── pubspec.yaml        # Flutter dependencies and assets
└── backend/                # Backend API & Database Services
```

---

## 💻 Environment Setup (Mobile Client)

To run the Flutter mobile application, verify your environment or install the required tools using the setup guide in [SETUP_GUIDE.md](file:///f:/B2B_Ecommerce/SETUP_GUIDE.md).

The environment uses:
1. **Java Development Kit (JDK 17)**
2. **Flutter SDK**
3. **Android SDK Command-line Tools** (configured without Android Studio)

Run `flutter doctor` in a new terminal to verify your configuration.

---

## 📱 Running the Android Emulator

If the emulator fails to show up visually on your screen, use these command-line steps:

1. **Clean stuck background processes**:
   ```cmd
   taskkill /F /IM emulator.exe
   taskkill /F /IM qemu-system-x86_64.exe
   ```
2. **Launch the emulator cleanly**:
   ```cmd
   %LOCALAPPDATA%\Android\Sdk\emulator\emulator.exe -avd medium_phone -no-snapshot-load
   ```
3. **Compile and run the Flutter app** (once the emulator is booted):
   ```cmd
   cd /d f:\B2B_Ecommerce\SRKT && flutter run -d emulator-5554 --no-pub
   ```

---

## ⚙️ Backend Services Guidelines

The `/backend` folder houses the database schemas, server services, and webhooks.

### Recommended Project Structure
```
backend/
├── src/
│   ├── controllers/   # Route handler logic
│   ├── models/        # Database models
│   ├── routes/        # Endpoint routing
│   └── app.js         # Entry point script
├── docker-compose.yml # Containerized services
└── package.json       # Backend dependencies
```

### Mobile Integration Standards
* **Protocol**: REST APIs over HTTPS returning JSON payloads.
* **Authentication**: Bearer JWT tokens in authorization headers.
* **Standard Response Format**:
  ```json
  {
    "success": true,
    "data": {},
    "error": null
  }
  ```
