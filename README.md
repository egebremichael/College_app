# Scot Central App

A Flutter-based mobile application designed to help students and faculty navigate the college campus and access important resources.

## Features

- **Home Screen**: A welcome screen displaying the campus logo and upcoming events.
- **Dining**: Dining News and a clickable link at the bottom of the pdf where students csan check their flex balances and meal swipes.
- **Shuttle Schedule**: Allows users to view shuttle times for various stops in Wooster. Users can select their pickup and dropoff locations to see the estimated time for their shuttle arrival and departure.
- **Map**: A campus map using Google maps API.
- **Resources**: A list of campus resources such as the Wellness Center, Gym, Libraries, and more. Each resource can be tapped to open a corresponding website with more information.

## Installation

To get started with this project, first clone the repository and make sure you have Flutter installed on your development machine.

1. Clone the repository:

```
https://github.com/egebremichael/Junior_IS.git
```

2. Change into the project directory:

```
cd Junior_IS
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

# Overall Structure 
Junior_IS/
|-- android/                  # Android-specific project configuration and native code. 

|-- assets/                   # Contains image assets used within the app. 

|-- build/                    # Build output files (generated during the build process). 

|-- ios/                      # iOS-specific project configuration and native code. 

|-- lib/                      # Contains the main Dart code for the app (main.dart, widgets, screens, etc.). 

|-- linux/                    # Linux-specific project configuration and native code. 

|-- macos/                    # macOS-specific project configuration and native code. 

|-- pubspec.lock              # A generated file containing the exact package versions used in the project. 

|-- pubspec.yaml              # Contains metadata about the project and dependencies. 

|-- README.md                 # A markdown file containing information about the project. 

|-- test/                     # Contains tests for the app. 

|-- web/                      # Web-specific project configuration and code. 

|-- windows/                  # Windows-specific project configuration and native code. 

|-- wooster_app.iml           # Project configuration file for IntelliJ-based IDEs (Android Studio, IntelliJ IDEA). 




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
   - VS Code will automatically detect the Flutter project and configure itself to use the Flutter and Dart extensions.
4. Run the Flutter project:
    Open the terminal in VS Code (Ctrl + `).
    Type flutter run and hit Enter. This command will build and run your Flutter app on a connected device or emulator.
    
# How to Use the App


### Home Screen

When you open the app, you will be greeted by the Home screen, which displays the campus logo and a welcome message. This screen serves as the starting point for using the app. You can see an upcoming events widget displaying events that will be happening soon.

### Dining

To access information about on-campus dining options, tap the "Dining" icon. This will open the Dining screen where you can see the dining news. Simply scroll through the list to view the news and you can also find a link to check flex balance and meal swipes.

### Shuttle Schedule

To view the shuttle schedule, tap the "Shuttle Schedule" icon. On the Shuttle Schedule screen, you can select your pickup and dropoff locations to see the estimated time for your shuttle arrival and departure. 

### Campus Map

To view the campus map, tap the "Map" icon. It uses Google Maps API and is linked to the internet.(not fully implemented)

### Resources

To access a list of campus resources, tap the "Resources" icon. The Resources screen displays a list of various campus resources, such as the Wellness Center, Gym, Libraries, and more. Each resource is clickable and will open a corresponding website with more information when tapped.

By following these simple steps, you can easily navigate the Scot Central App and make the most of its features. 

### Settings 

To access the settings which contains the light/dark mode, changing welcome message preferences or log out, click on the settings button on the top right corner of the app.

### Additional Feature

To access semester academic deadlines, click on the hamburger menu and click on the academic deadlines tab. (doesn't look so good right now)

## Limitations

The maps don't work as expected didn't have enough time to fully implement the Google maps API.
The Academic deadlines are formatted in a bad way and is very hard to read ans aesthetically unpleasing. 
The features in the resources tab aren't displayed when light mode is enabled. 
Limited number of languages available for selection due to lack of time for implememnting the Google translate API. 
The Dining page only shows the dining menu pdf and it's hard to find the link to check meal swipes and flex balance. 

## Troubleshooting Cocoapods Error

If you encounter a CocoaPods error while building the app for iOS, follow these steps to resolve the issue:

1. Install CocoaPods:

If you haven't already installed CocoaPods on your development machine, you can do so by running the following command in your terminal:

```
sudo gem install cocoapods
```

2. Navigate to the `ios` directory:

Change into the `ios` directory of your Flutter project by running:

```
cd ios
```

3. Run `pod install`:

In the `ios` directory, run the following commands to install the required CocoaPods dependencies:

```
pod install
pod update Firebase/CoreOnly

```

This command will generate a `Podfile.lock` file and a `Pods` directory, which contains the installed dependencies.

4. Return to the project root:

Navigate back to the root directory of your Flutter project:

```
cd ..
```

5. Rebuild the app:

Now, try rebuilding the app for iOS by running:

```
flutter run
```

If the CocoaPods error is resolved, the app should build and run successfully on an iOS device or simulator.



