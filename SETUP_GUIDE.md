# SRKT B2B Client Demo Setup & Build Guide

This guide details the steps to run, build, and deploy the **SRKT** B2B mobile client application.

---

## 1. Environment Status

Your system is already configured with the required tools:
* **Java Development Kit (JDK 17)** is installed and mapped via `JAVA_HOME`.
* **Flutter SDK** is installed and added to the System Path.
* **Android Command Line Tools & SDK** are configured. 

> [—]
> **Android Studio is NOT used or required** in this project environment. All compilation, execution, and deployment tasks are completed using the Flutter Command Line Interface (CLI) and Android Command-line Tools.

### SDK Download & Installation Links (For future reference)
If you need to install or update these SDKs on another machine:
* **Flutter SDK**: [Flutter SDK Windows Setup](https://docs.flutter.dev/get-started/install/windows)
* **Java Development Kit (JDK 17)**: [Oracle JDK 17 Downloads](https://www.oracle.com/java/technologies/downloads/#java17) or [Microsoft OpenJDK 17](https://learn.microsoft.com/en-us/java/openjdk/download)
* **Android SDK Command-line Tools**: [Android Command Line Tools](https://developer.android.com/studio#command-tools) (scroll down to "Command line tools only")

To verify your environment status at any time, run:
```cmd
flutter doctor
```

---

## 2. Running the Android Emulator

If you need to test the application locally on the Android emulator:

### Step 1 — Terminate stuck background emulator processes
```cmd
taskkill /F /IM emulator.exe
taskkill /F /IM qemu-system-x86_64.exe
```

### Step 2 — Cold-boot the emulator
Start the emulator using the AVD (`medium_phone`) configured on your system:
```cmd
%LOCALAPPDATA%\Android\Sdk\emulator\emulator.exe -avd medium_phone -no-snapshot-load
```
*Keep this command window open while running the app.*

### Step 3 — Compile and run the app
Open a second terminal window, navigate to the app directory, and start the app:
```cmd
cd /d f:\B2B_Ecommerce\SRKT
flutter run -d emulator-5554 --no-pub
```

---

## 3. Building the Demo APK

To generate the APK file to send to clients or watchers:

1. Open your terminal and navigate to the project folder:
   ```cmd
   cd /d f:\B2B_Ecommerce\SRKT
   ```
2. Build the optimized release APK:
   ```cmd
   flutter build apk --release
   ```
3. Locate the compiled APK file at:
   `f:\B2B_Ecommerce\SRKT\build\app\outputs\flutter-apk\app-release.apk`

---

## 4. Pushing to GitHub

Since Git has already been initialized and your initial commit is created locally:

1. Create a new repository on [GitHub](https://github.com/) named `SRKT` or `B2B_Ecommerce`.
2. Link your local repository and push:
   ```cmd
   git branch -M main
   git remote add origin https://github.com/YOUR_USERNAME/YOUR_REPO_NAME.git
   git push -u origin main
   ```

---

## 5. Sharing the APK with Watchers/Clients

To host the APK online so others can install it:

### Option A: GitHub Releases (Recommended)
1. Go to your GitHub repository page.
2. Click **Releases** -> **Create a new release**.
3. Create a tag (e.g., `v1.0.0`), set a title (e.g., `SRKT Demo v1.0.0`).
4. Drag and drop the `app-release.apk` file into the attachment box.
5. Click **Publish release**.

### Option B: Quick OTA Download (QR Code)
1. Upload the `app-release.apk` to [Diawi](https://www.diawi.com/) or [InstallOnAir](https://www.installonair.com/).
2. Copy the generated URL or scan the **QR Code** on a mobile device to install the app instantly.
