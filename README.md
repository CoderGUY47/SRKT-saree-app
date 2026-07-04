# 🌸 SRKT — Premium B2B Saree E-Commerce Platform

Welcome to **SRKT**, a premium mobile client application designed for digital wholesale saree sourcing and client demonstrations. This application delivers a state-of-the-art catalog experience with wholesale order/enquiry capabilities, built on top of a highly responsive, modern UI.

---

## 📱 Interactive Client Demo (Install APK)

To allow watchers, stakeholders, and clients to test the application immediately with full interaction, the pre-built Android release package is hosted directly within this repository.

> [!TIP]
> ### [⬇️ Download & Install the SRKT Demo APK](https://github.com/CoderGUY47/SRKT-saree-app/raw/main/releases/app-arm64-v8a-release.apk)
> *(Requires Android 8.0+ and ARM64-v8a architecture, standard for 99% of modern Android devices).*

---

## 🌟 Key Application Features

* **✨ Wholesale Saree Catalog**: Exquisite catalog layout with product categorization, collections browsing, responsive grid search, and custom filter metrics.
* **🛍️ Wishlist & Cart System**: Interactive product selection where wholesale clients can curate lists and manage quantities.
* **💬 WhatsApp & Enquiry Integration**: Submit order checklists directly to suppliers or generate instant WhatsApp booking notes.
* **🛡️ Client Credentials (Demo Access)**:
  * **Admin Account**: `admin@gmail.com` | Password: `1234`
  * **Wholesale Client**: `user@gmail.com` | Password: `1234`
* **📊 Admin Panel Dashboard**: Built-in dashboard displaying real-time metrics, active user registrations, wholesale product management tabs, and active buyer enquiries.

---

## 🛠️ Technology Stack

* **Frontend Framework**: [Flutter (Dart SDK 3.x)](https://flutter.dev)
* **Design Guidelines**: Material Design 3 with custom warm/luxury color grading.
* **Architecture**: Monorepo separating mobile frontend client and backend nodes.

---

## 📁 Repository Structure

```
SRKT-saree-app/
├── README.md               # Root documentation (this file)
├── SETUP_GUIDE.md          # Comprehensive build, running, and deploy guide
├── releases/               # Client-facing release binaries
│   └── app-arm64-v8a-release.apk
├── SRKT/                   # Flutter Mobile Client Source
│   ├── lib/                # Dart source files (Models, Screens, Providers)
│   ├── assets/             # Product and UI image assets
│   └── pubspec.yaml        # Flutter dependencies
└── backend/                # Backend API Services (empty placeholders)
```

---

## 🚀 Quick Start (For Developers)

### 1. Prerequisite Checklist
Make sure you have **Flutter SDK** and **Java JDK 17** installed and configured on your path. Run this command to verify:
```cmd
flutter doctor
```
*(No Android Studio installation is required to build or run this application).*

### 2. Run Locally on Emulator
1. Cold-boot your configured emulator:
   ```cmd
   %LOCALAPPDATA%\Android\Sdk\emulator\emulator.exe -avd medium_phone -no-snapshot-load
   ```
2. Launch the application:
   ```cmd
   cd SRKT
   flutter run -d emulator-5554 --no-pub
   ```

### 3. Compile a New Release
To compile the APK binary yourself:
```cmd
cd SRKT
flutter build apk --release --split-per-abi
```
Your outputs will be generated in `SRKT/build/app/outputs/flutter-apk/`.
