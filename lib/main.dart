// Import necessary packages
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'dart:io';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  // Ensure that the Flutter app is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase app
  await Firebase.initializeApp();
  // Run the MyApp widget
  runApp(MyApp());
}

// Define the MyApp widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Disable the debug banner
      debugShowCheckedModeBanner: false,
      routes: {
        // Define named routes for LoginPage and HomePage widgets
        '/': (context) => LoginPage(),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}

// Define the LoginPage widget
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// Define the state for the LoginPage widget
class _LoginPageState extends State<LoginPage> {
  // Define text editing controllers for email and password
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Return a Scaffold widget with a black background
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        // Add padding to the body
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          // Build the layout using a LayoutBuilder and SingleChildScrollView
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    // Center the child widgets vertically
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      // Add a SizedBox for spacing
                      SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset('assets/images/woo_logo.jpeg'),
                        ),
                      ),
                      // Add a SizedBox for spacing
                      SizedBox(height: 16),
                      // Add a Text widget for the login title
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow),
                        textAlign: TextAlign.center,
                      ),
                      // Add a SizedBox for spacing
                      SizedBox(height: 16),
                      // Add a TextField widget for the email input
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.yellow),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                        ),
                      ),
                      // Add a SizedBox for spacing
                      SizedBox(height: 16),
                      // Add a TextField widget for the password input
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.yellow),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.yellow),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () async {
                          await _login();
                        },
                        child: Text('Login'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.yellow,
                          onPrimary: Colors.black,
                        ),
                      ),
                      SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()),
                          );
                        },
                        child: Text(
                          'Don\'t have an account? Sign up',
                          style: TextStyle(color: Colors.yellow),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // If successful, navigate to the home page
      Navigator.pushNamed(context, '/homepage');
    } on FirebaseAuthException catch (e) {
      // Show error message if there's an exception
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // Controllers for text fields
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  // Key for form validation
  final _formKey = GlobalKey<FormState>();

  // Regular expression pattern for password validation
  final RegExp _passwordPattern =
      RegExp(r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Set background color to black
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints
                        .maxHeight, // Minimum height constraint for SingleChildScrollView
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          SizedBox(height: 16),
                          // Display the logo
                          Center(
                            child: SizedBox(
                              width: 150,
                              height: 150,
                              child: Image.asset('assets/images/woo_logo.jpeg'),
                            ),
                          ),
                          Flexible(
                            flex: 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: <Widget>[
                                SizedBox(height: 1),
                                // Sign Up header
                                Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 16),
                                // Email TextFormField
                                TextFormField(
                                  controller: _emailController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle: TextStyle(color: Colors.yellow),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    if (!value.contains('@') ||
                                        !value.contains('.')) {
                                      return 'Please enter a valid email';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                // Password TextFormField
                                TextFormField(
                                  controller: _passwordController,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(color: Colors.yellow),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    if (!_passwordPattern.hasMatch(value)) {
                                      return 'Password must be at least 8 characters, have an uppercase letter, a number, and a special character';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                // Confirm Password TextFormField
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  obscureText: true,
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    labelText: 'Confirm Password',
                                    labelStyle: TextStyle(color: Colors.yellow),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.yellow),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please confirm your password';
                                    }
                                    if (value != _passwordController.text) {
                                      return 'Passwords do not match';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 16),
                                // Sign Up ElevatedButton
                                ElevatedButton(
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      await _signUp();
                                    }
                                  },
                                  child: Text('Sign Up'),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.yellow,
                                    onPrimary: Colors.black,
                                  ),
                                ),
                                // Log in TextButton
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => LoginPage()),
                                    );
                                  },
                                  child: Text(
                                    'Have an account? Log in',
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  // Method to sign up the user
  Future<void> _signUp() async {
    // Check if the passwords match
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords don't match.")));
      return;
    }

    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      // Attempt to create a new user
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      // If successful, navigate to the home page
      Navigator.pushNamed(context, '/homepage');
    } on FirebaseAuthException catch (e) {
      // Show an error message if there's an exception
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex =
      0; // index of currently selected bottom navigation bar item
  bool _isDarkMode = true; // whether the app is in dark mode
  String? _selectedLanguage; // the user's selected language, if any
  Widget _homeWidget = Home(); // the widget to be displayed in the home tab

  // A list of widgets for each bottom navigation bar item
  List<Widget> _widgetOptions() => [
        _homeWidget,
        DiningMenu(),
        ShuttleSchedule(),
        CampusMap(),
        Resources(),
      ];

  // Handles when a bottom navigation bar item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Toggles the app's theme between light and dark mode
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Signs the user out and navigates to the login page
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/loginpage', (route) => false);
  }

  // Updates the home widget with the user's selected language
  void _updateHomeWidget() {
    setState(() {
      _homeWidget = Home(preferredLanguage: _selectedLanguage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // remove debug banner
      title: 'My App',
      theme: _isDarkMode
          ? ThemeData(
              brightness: Brightness.dark,
              scaffoldBackgroundColor: Colors.black,
            )
          : ThemeData(
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              primaryColor: Colors.yellow,
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.yellow,
                textTheme: TextTheme(
                  headline6: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(color: Colors.black),
                bodyText2: TextStyle(color: Colors.black),
              ),
            ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: AppBar().preferredSize.height * 1,
                height: AppBar().preferredSize.height * 1,
                child: Image.asset(
                  'assets/images/woo_logo.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                  width: 21), // Add some space between the logo and the title
              Expanded(
                child:
                    Text('ScotCentral', style: GoogleFonts.exo2(fontSize: 28)),
              ),
            ],
          ),
          actions: [
            Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: Icon(Icons.settings),
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                );
              },
            ),
          ],
        ),
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Settings'),
                decoration: BoxDecoration(
                  color: Color(0xFFB88A00),
                ),
              ),
              ListTile(
                title: Text('Toggle Theme'),
                trailing: Container(
                  width: 48.0,
                  height: 48.0,
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: _isDarkMode
                        ? Icon(Icons.lightbulb_outline)
                        : Icon(Icons.nightlight_round),
                    onPressed: () {
                      _toggleTheme();
                    },
                  ),
                ),
              ),
              ListTile(
                title: Text('Preferred Welcome Language'),
                trailing: DropdownButton<String>(
                  value: _selectedLanguage,
                  items: [
                    DropdownMenuItem(
                      value: 'Amharic',
                      child: Text('Amharic'),
                    ),
                    DropdownMenuItem(
                      value: 'Arabic',
                      child: Text('Arabic'),
                    ),
                    DropdownMenuItem(
                      value: 'Chinese',
                      child: Text('Chinese'),
                    ),
                    DropdownMenuItem(
                      value: 'English',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'French',
                      child: Text('French'),
                    ),
                    DropdownMenuItem(
                      value: 'Hindi',
                      child: Text('Hindi'),
                    ),
                    DropdownMenuItem(
                      value: 'Japanese',
                      child: Text('Japanese'),
                    ),
                    DropdownMenuItem(
                      value: 'Korean',
                      child: Text('Korean'),
                    ),
                    DropdownMenuItem(
                      value: 'Mongolian',
                      child: Text('Mongolian'),
                    ),
                    DropdownMenuItem(
                      value: 'Nepali',
                      child: Text('Nepali'),
                    ),
                    DropdownMenuItem(
                      value: 'Portuguese',
                      child: Text('Portuguese'),
                    ),
                    DropdownMenuItem(
                      value: 'Spanish',
                      child: Text('Spanish'),
                    ),
                    DropdownMenuItem(
                      value: 'Kinyarwanda',
                      child: Text('Kinyarwanda'),
                    ),
                    DropdownMenuItem(
                      value: 'Twi',
                      child: Text('Twi'),
                    ),
                    DropdownMenuItem(
                      value: 'Yoruba',
                      child: Text('Yoruba'),
                    ),
                  ],
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLanguage = newValue!;
                      _updateHomeWidget();
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Logout'),
                onTap: () {
                  Navigator.pop(context);
                  _signOut();
                },
              ),
            ],
          ),
        ),
        body: Center(child: _widgetOptions().elementAt(_selectedIndex)),
        bottomNavigationBar: BottomNavigationBar(
          unselectedItemColor: Colors.grey[500],
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: 'Dining',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_bus),
              label: 'Shuttle',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_pin),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.school),
              label: 'Resources',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.yellow,
          onTap: _onItemTapped,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                child: Text('Menu'),
                decoration: BoxDecoration(
                  color: Color(0xFFB88A00),
                ),
              ),
              ListTile(
                title: Text('Academic Deadlines'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AcademicDeadlines(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// A stateless widget for the home page.
class Home extends StatelessWidget {
  // The preferred language for the home page, passed in as a parameter.
  final String? preferredLanguage;
  // Constructs a new instance of the [Home] widget.
  const Home({super.key, this.preferredLanguage});

  // Returns the language code for the given language name.
  String languageCodeFromName(String languageName) {
    switch (languageName) {
      case 'English':
        return 'en';
      case 'Spanish':
        return 'es';
      case 'French':
        return 'fr';
      case 'Arabic':
        return 'ar';
      case 'Portuguese':
        return 'po';
      case 'Amharic':
        return 'am';
      case 'Mongolian':
        return 'mo';
      case 'Japanese':
        return 'ja';
      case 'Chinese':
        return 'ch';
      case 'Kinyarwanda':
        return 'rw';
      case 'Korean':
        return 'ko';
      case 'Nepali':
        return 'ne';
      case 'Yoruba':
        return 'ni';
      case 'Hindi':
        return 'in';
      case 'Twi':
        return 'tw';
      default:
        return 'en';
    }
  }

  // Returns a welcome message in the user's preferred language, or the device's language if no preferred language is selected.
  String getWelcomeMessage(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'Welcome back!';
      case 'sp':
        return 'Bienvenido de nuevo!';
      case 'fr':
        return 'Bienvenue à nouveau!';
      case 'ar':
        return 'مرحبًا بعودتك';
      case 'ni':
        return 'ku aabọ pada!';
      case 'am':
        return 'እንኳን ደህና መጡ!';
      case 'mo':
        return 'Буцаад тавтай морил';
      case 'po':
        return 'Bem vindo de volta!';
      case 'rw':
        return 'Murakaza neza!';
      case 'tw':
        return 'Akwaaba!';
      case 'ni':
        return 'Ku aabọ pada!';
      case 'ch':
        return '欢迎回来！';
      case 'po':
        return 'Bem vindo de volta!';
      case 'ja':
        return 'おかえり！';
      case 'ko':
        return '다시 오신 것을 환영합니다!';
      case 'in':
        return 'वापसी पर स्वागत है!';
      case 'ne':
        return 'फिर्ता आउनु भएकोमा स्वागत छ!';
      // Add more languages here
      default:
        return 'Welcome back!';
    }
  }

  Widget build(BuildContext context) {
    // Determine the language code to use for the welcome message.
    String languageCode = Localizations.localeOf(context).languageCode;
    String displayLanguageCode = preferredLanguage != null
        ? languageCodeFromName(preferredLanguage!)
        : languageCode;

    // Build the main widget for the screen.
    return Stack(
      children: [
        // Background image container
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/woo_img2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Column containing the welcome message and the event information
        Column(
          children: [
            // Welcome message container
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: Center(
                  child: Text(
                    '${getWelcomeMessage(displayLanguageCode)}',
                    style: GoogleFonts.crimsonPro(
                        fontSize: 26, color: Colors.white),
                  ),
                ),
              ),
            ),
            // Event information container
            Expanded(
              flex: 8,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment:
                            CrossAxisAlignment.start, // Align text to the left
                        children: [
                          // Upcoming Event title
                          Text(
                            'Upcoming Event:',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          // Event 1
                          Text(
                            'Regal Gala - April 28, 8-10 pm Knowlton Commons',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          // Event 2
                          Text(
                            'Last day of classes - May 2',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          SizedBox(height: 8),
                          // Event 3
                          Text(
                            'Reading Days - May 3',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          // Event 4
                          Text(
                            'Exam week - May 4 to May 9',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AcademicDeadlines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Define the app bar with a title and a background color
      appBar: AppBar(
        title: Text(
          'Academic Deadlines',
          style: TextStyle(
            fontFamily: 'Helvetica',
          ),
        ),
        backgroundColor: Colors.grey[850],
      ),
      // Use a stack to layer multiple widgets on top of each other
      body: Stack(
        children: [
          // Display the background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/woo_img2.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Add a semi-transparent black layer on top of the image
          Opacity(
            opacity: 0.8,
            child: Container(
              color: Colors.black,
            ),
          ),
          // Use a Positioned.fill widget to fill the available space and add padding
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Display the title for the academic deadlines
                    Text(
                      '2022-2023 Spring Semester Deadlines',
                      style: TextStyle(
                        fontFamily: 'Helvetica',
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Display the list of deadlines
                    Text('Fall Semester Incompletes',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text('  Student’s Final Work Due: Friday, January 6, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Faculty’s Final Grade Due: Friday, January 13, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text('  Classes Begin: Wednesday, January 11, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    // More deadline items
                    // ...
                    Text('Taken from the college website',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiningMenu extends StatefulWidget {
  @override
  _DiningMenuState createState() => _DiningMenuState();
}

class _DiningMenuState extends State<DiningMenu> {
  String? _pdfPath;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  // Loads the PDF from assets and saves it to temporary directory
  Future<void> loadPdf() async {
    final pdfFile =
        await copyAssetToTempDirectory('assets/documents/dining.pdf');
    setState(() {
      _pdfPath = pdfFile.path;
    });
  }

  // Copies the asset PDF to the temporary directory
  Future<File> copyAssetToTempDirectory(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final tempDir = await getTemporaryDirectory();
    final file = File('${tempDir.path}/${assetPath.split('/').last}');
    await file.writeAsBytes(byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pdfPath == null
          ? Center(child: CircularProgressIndicator())
          : PDFView(
              filePath: _pdfPath!,
              fitEachPage: true,
              defaultPage: 0,
              pageSnap: true,
            ),
    );
  }
}

// Define a Shuttle class with location and schedule attributes
class Shuttle {
  final String location;
  final int schedule;

  // Constructor for the Shuttle class
  Shuttle({required this.location, required this.schedule});
}

// Create a list of Shuttle objects representing shuttle stops
final List<Shuttle> shuttles = [
  Shuttle(location: 'Spink & Nold', schedule: 0),
  Shuttle(location: 'Discount Drug Mart', schedule: 1),
  Shuttle(location: 'Lowry Circle', schedule: 2),
  Shuttle(location: 'Williamsburg Apartments', schedule: 4),
  Shuttle(location: 'Wooster Hospital', schedule: 5),
  Shuttle(location: 'Save A Lot', schedule: 5),
  Shuttle(location: 'College Hills', schedule: 8),
  Shuttle(location: 'Spruce Hill Apts.', schedule: 9),
  Shuttle(location: 'Northgate & Cleveland', schedule: 13),
  Shuttle(location: 'Freedlander Park', schedule: 15),
  Shuttle(location: 'Walmart Supercenter', schedule: 19),
  Shuttle(location: 'Movies 10', schedule: 23),
  Shuttle(location: 'Dollar Tree', schedule: 24),
  Shuttle(location: 'Buehler\'s Milltown', schedule: 26),
  Shuttle(location: 'Children\'s Services', schedule: 29),
  Shuttle(location: 'Reed & Burbank', schedule: 30),
  Shuttle(location: 'Cleveland Clinic', schedule: 32),
  Shuttle(location: 'Wayne & Beall', schedule: 34),
  Shuttle(location: 'University & Palmer', schedule: 36),
  Shuttle(location: 'Community Action', schedule: 38),
  Shuttle(location: 'Best Western', schedule: 40),
  Shuttle(location: 'Family Dollar', schedule: 53),
  Shuttle(location: 'Bowman & Grant', schedule: 54),
  Shuttle(location: 'Buehler\'s Towne Market', schedule: 56),
  Shuttle(location: 'North & Buckeye', schedule: 58),
  Shuttle(location: 'OneEighty', schedule: 59),
];

// Calculate the remaining time until the next shuttle arrives at a given location
int _calculateRemainingTime(String location) {
  // Calculate the remaining time until the next shuttle arrives at a given location
  Shuttle shuttle =
      shuttles.firstWhere((shuttle) => shuttle.location == location);
  // Get the current time
  DateTime currentTime = DateTime.now();
  int currentHour = currentTime.hour;
  int currentMinute = currentTime.minute;
// If it's past 10 PM, set the remaining time to -1 to indicate that the shuttle service has ended
  if (currentHour >= 22) {
    return -1;
  }

  int remainingTime = 0;
  // Calculate the remaining time until the shuttle arrives at the given location
  if (shuttle.schedule > currentMinute) {
    remainingTime = shuttle.schedule - currentMinute;
  } else {
    remainingTime = (60 - currentMinute) + shuttle.schedule;
  }

  return remainingTime;
}

// Define a StatefulWidget for the Shuttle Schedule screen
class ShuttleSchedule extends StatefulWidget {
  @override
  _ShuttleScheduleState createState() => _ShuttleScheduleState();
}

// Define a State for the Shuttle Schedule screen
class _ShuttleScheduleState extends State<ShuttleSchedule> {
  String? _pickupLocation;
  String? _dropoffLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Set the app bar title to 'Shuttle Schedule
      appBar: AppBar(title: Text('Shuttle Schedule')),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/shuttle_bg.jpeg'), // Replace with your transit image
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.1), BlendMode.dstATop),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Text('Pickup Location:'),
                DropdownButton<String>(
                  value: _pickupLocation,
                  items: shuttles.map((shuttle) {
                    return DropdownMenuItem(
                      value: shuttle.location,
                      child: Text(shuttle.location),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _pickupLocation = newValue;
                    });
                  },
                ),
                SizedBox(height: 16),
                Text('Dropoff Location:'),
                DropdownButton<String>(
                  value: _dropoffLocation,
                  items: shuttles.map((shuttle) {
                    return DropdownMenuItem(
                      value: shuttle.location,
                      child: Text(shuttle.location),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _dropoffLocation = newValue;
                    });
                  },
                ),
                SizedBox(height: 16),
                if (_pickupLocation != null && _dropoffLocation != null)
                  Text(
                    'You will be picked up in ${_calculateRemainingTime(_pickupLocation!)} minutes (${DateTime.now().add(Duration(minutes: _calculateRemainingTime(_pickupLocation!))).toIso8601String().substring(11, 16)}) and will be dropped off at $_dropoffLocation at ${DateTime.now().add(Duration(minutes: _calculateRemainingTime(_pickupLocation!) + _calculateRemainingTime(_dropoffLocation!))).toIso8601String().substring(11, 16)}.',
                    style: TextStyle(fontSize: 16),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CampusMap extends StatefulWidget {
  @override
  _CampusMapState createState() => _CampusMapState();
}

class _CampusMapState extends State<CampusMap> {
  late GoogleMapController _controller;

  final LatLng _woosterLatLng =
      LatLng(40.808884, -81.933188); // College of Wooster coordinates

  Set<Marker> _markers = {}; // Adds markers to locations

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('destination'),
      position: LatLng(40.808884, -81.933188),
      onTap: () => _launchMapsDirections(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wooster Campus Map'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _woosterLatLng,
          zoom: 17,
        ),
        mapType: MapType.normal,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _controller = controller;
        },
      ),
    );
  }

  Future<void> _launchMapsDirections() async {
    final destination =
        '40.808884,-81.933188'; // The LatLng values of the college
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=walking';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// displays a list of campus resources.
class Resources extends StatelessWidget {
  // A list of strings representing the names of various campus services.
  final List<String> services = [
    'Wellness Center',
    'Gym',
    'Libraries',
    'APEX',
    'Academic Resource Center',
    'Title IX',
    'Campus Safety',
  ];

  // A list of strings containing the corresponding URLs for each campus service.
  final List<String> serviceUrls = [
    'https://wooster.edu/wellness-center/',
    'https://www.woosterathletics.com/scotcenter/index',
    'https://wooster.edu/library/library-hours/',
    'https://inside.wooster.edu/apex/',
    'https://inside.wooster.edu/arc/',
    'https://inside.wooster.edu/title-ix/',
    'https://inside.wooster.edu/safety/',
  ];

  // An asynchronous function that takes a URL string as its argument.
  // It checks if the given URL can be launched, and if so, launches it.
  // Otherwise, it throws an exception with an error message.
  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // displays a list of campus resources with their corresponding URLs.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Campus Resources'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/woo_logo.png'),
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.9),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: services.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      services[index],
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      _launchUrl(serviceUrls[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
