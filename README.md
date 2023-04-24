# College Campus App

A Flutter-based mobile application designed to help students and faculty navigate the college campus and access important resources.

## Features

- **Home Screen**: A welcome screen displaying the campus logo and other relevant information.
- **Dining**: A list of on-campus dining options, their descriptions, and hours of operation. Displays each dining option with an image and basic details.
- **Shuttle Schedule**: Allows users to view shuttle times for various stops on campus. Users can select their pickup and dropoff locations to see the estimated time for their shuttle arrival and departure.
- **Map**: A campus map with important building locations to help users navigate the campus.
- **Resources**: A list of campus resources such as the Wellness Center, Gym, Libraries, and more. Each resource can be tapped to open a corresponding website with more information.

## Installation

To get started with this project, first clone the repository and make sure you have Flutter installed on your development machine.

1. Clone the repository:

```
git clone https://github.com/yourusername/college_campus_app.git
```

2. Change into the project directory:

```
cd college_campus_app
```

3. Install the required dependencies:

```
flutter pub get
```

4. Run the app on an emulator or a connected device:

```
flutter run
```

## Customization

To customize the app, you can update the following files:

- `lib/screens/home.dart` for the Home screen.
- `lib/screens/dining.dart` for the Dining screen.
- `lib/screens/shuttle_schedule.dart` for the Shuttle Schedule screen.
- `lib/screens/map.dart` for the Map screen.
- `lib/screens/resources.dart` for the Resources screen.

Additionally, replace the placeholder images, texts, and URLs with the information relevant to your campus.

## License

This project is open-source and available for free use and modification under the terms of the [MIT License](LICENSE).

# Flutter Application Setup

This README will guide you through setting up Flutter, Android Studio, and Xcode for your development machine, as well as configuring Visual Studio Code as an alternative code editor.

## Flutter Installation

First, download the Flutter SDK from the following link: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

Choose the appropriate download for your operating system (Windows, macOS, or Linux), then follow the instructions provided for your platform.

## Android Studio Setup

### 1. Install Android Studio

Download and install Android Studio from this link: [https://developer.android.com/studio](https://developer.android.com/studio)

During the installation, make sure to select the option to install the Android SDK, Android Virtual Device (AVD), and other necessary components.

### 2. Configure Android Studio for Flutter

Open Android Studio, and follow these steps:

- Install the Flutter and Dart plugins:
  - Go to `File > Settings > Plugins`.
  - Search for "Flutter" and click on "Install" (this will also install the Dart plugin).
  - Restart Android Studio when prompted.

- Configure the Android SDK:
  - Go to `File > Settings > Appearance & Behavior > System Settings > Android SDK`.
  - Make sure you have an Android SDK version 28 or higher installed (you can install additional SDKs through the SDK Manager).

### 3. Set up a device or emulator

You can either use a physical Android device or an Android emulator to run your Flutter applications.

- To use a physical device, enable USB debugging on your device and connect it to your computer via USB.
- To set up an emulator, follow these steps in Android Studio:
  - Go to `Tools > AVD Manager`.
  - Click on "Create Virtual Device".
  - Choose a device definition, and click "Next".
  - Select a system image (preferably one with the "Google APIs" label), and click "Next".
  - Configure any additional settings for your emulator, and click "Finish".

## Xcode Setup (macOS only)

### 1. Install Xcode

Download and install Xcode from the Mac App Store: [https://apps.apple.com/us/app/xcode/id497799835](https://apps.apple.com/us/app/xcode/id497799835)

### 2. Install additional components

After installing Xcode, open a Terminal window and run the following command to install additional required components:

```
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

### 3. Set up an iOS Simulator

To set up an iOS Simulator, follow these steps:

- Open Xcode.
- Go to `Xcode > Preferences > Components`.
- Download a simulator runtime for the desired iOS version.
- Close the preferences window.
- Go to `Window > Devices and Simulators` to manage and run simulators.

## Visual Studio Code Setup

If you prefer using Visual Studio Code as your code editor, follow these steps to set up Flutter:

1. Install Visual Studio Code from this link: [https://code.visualstudio.com/](https://code.visualstudio.com/)

2. Install the Flutter and Dart extensions:

   - Launch Visual Studio Code.
   - Go to `Extensions` (Ctrl + Shift + X) or click on the Extensions icon in the Activity Bar on the side of the window.
   - Search for "Flutter" and click on "Install" (this will also install the Dart extension).

3. Open your Flutter project in Visual Studio Code:

   - Go to `File > Open Folder`, and select the root folder of your Flutter project.
   - VS Code will automatically
