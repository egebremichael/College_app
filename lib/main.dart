// Import necessary packages and libraries
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';
import 'dart:io';
import 'dart:ui';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

// Define the main function
void main() async {
  // Ensure that the Widgets binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize the Firebase app
  await Firebase.initializeApp();
  // Run the MyApp widget
  runApp(MyApp());
}

// Define the MyApp widget
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(), // Route to the LoginPage widget
        '/homepage': (context) => HomePage(), // Route to the HomePage widget
      },
    );
  }
}

// represents the login screen of the app.
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

// manages the mutable state for the LoginPage widget.
class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Build the login screen with email and password inputs and a login button.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      SizedBox(height: 16),
                      Center(
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.asset('assets/images/woo_logo.jpeg'),
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 16),
                      SizedBox(height: 16),
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
                      SizedBox(height: 16),
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

  // Perform the login action using Firebase authentication.
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

// represents the sign up screen of the app.
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

// manages the mutable state for the SignUpPage widget.
class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Regular expression pattern for password validation
  final RegExp _passwordPattern =
      RegExp(r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$');

  // Build the sign up screen with email, password, and confirm password inputs, and a sign up button.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Form(
                      key: _formKey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            SizedBox(height: 16),
                            Center(
                              child: SizedBox(
                                width: 150,
                                height: 150,
                                child:
                                    Image.asset('assets/images/woo_logo.jpeg'),
                              ),
                            ),
                            Flexible(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  SizedBox(height: 1),
                                  Text(
                                    'Sign Up',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.yellow),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 16),
                                  TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Email',
                                      labelStyle:
                                          TextStyle(color: Colors.yellow),
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
                                  TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      labelStyle:
                                          TextStyle(color: Colors.yellow),
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
                                  TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    style: TextStyle(color: Colors.white),
                                    decoration: InputDecoration(
                                      labelText: 'Confirm Password',
                                      labelStyle:
                                          TextStyle(color: Colors.yellow),
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
                          ]),
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

  // Perform the sign-up action using Firebase authentication.
  Future<void> _signUp() async {
    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Passwords don't match.")));
      return;
    }

    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.createUserWithEmailAndPassword(
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

// HomePage StatefulWidget declaration
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

// _HomePageState class declaration
class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = true;
  String? _selectedLanguage;
  Widget _homeWidget = Home();

  // Define the list of widgets to be displayed
  List<Widget> _widgetOptions() => [
        _homeWidget,
        Dining(),
        ShuttleSchedule(),
        CampusMap(),
        Resources(),
      ];

  // Change the selected widget when an item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Toggle theme between dark and light mode
  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  // Sign out user and navigate to login page
  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/loginpage', (route) => false);
  }

  // Update the Home widget with a new preferred welcome language
  void _updateHomeWidget() {
    setState(() {
      _homeWidget = Home(preferredLanguage: _selectedLanguage);
    });
  }

  // Build method to create MaterialApp and its widgets
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
              primaryColor: Color(0xFFDEAB03),
              appBarTheme: AppBarTheme(
                backgroundColor: Color(0xFFDEAB03),
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
        // Build the endDrawer containing settings
        endDrawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 150,
                child: DrawerHeader(
                  child: Text(
                    'Settings',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFB88A00),
                  ),
                ),
              ),
              // Toggle appearance between dark and light mode
              ListTile(
                title: Text('Switch Appearance'),
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
              // Choose preferred welcome language
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
              // Log out and navigate to login page
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
        // Display the selected widget in the body
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
          selectedItemColor: Color(0xFFDEAB03),
          onTap: _onItemTapped,
        ),
        // Build the main navigation drawer
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 150,
                child: DrawerHeader(
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xFFB88A00),
                  ),
                ),
              ),
              // Navigate to Academic Deadlines page
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

// displays the home page with a welcome message and upcoming events
class Home extends StatelessWidget {
  final String? preferredLanguage;
  // Constructor with optional language parameter
  const Home({super.key, this.preferredLanguage});

  // Map language names to their respective language codes
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

  // Return a welcome message in the specified language code
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

  // Build the Home widget with a welcome message and upcoming events
  Widget build(BuildContext context) {
    String languageCode = Localizations.localeOf(context).languageCode;
    String displayLanguageCode = preferredLanguage != null
        ? languageCodeFromName(preferredLanguage!)
        : languageCode;

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/woo_img2.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
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
                        fontSize: 30, color: Colors.white),
                  ),
                ),
              ),
            ),
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
                          Text(
                            'Upcoming Events:',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Regal Gala - April 28, 8-10 pm Knowlton Commons',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Last day of classes - May 2',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          SizedBox(height: 8),
                          Text(
                            'Reading Days - May 3',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Exam Week - May 4 - May 9',
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

// StatefulWidget that displays a list of academic deadlines
class AcademicDeadlines extends StatefulWidget {
  @override
  _AcademicDeadlinesState createState() => _AcademicDeadlinesState();
}

class _AcademicDeadlinesState extends State<AcademicDeadlines> {
  // List of academic deadlines, each containing a name and a date
  List<Map<String, String>> deadlines = [
    {
      'name': 'Classes Begin',
      'date': 'Wednesday, January 11, 2023',
    },
    {
      'name': 'MLK Teach-In',
      'date': 'Monday, January 16, 2023',
    },
    {
      'name': 'Last Day to Add a First Half Semester Class',
      'date': 'Tuesday, January 17, 2023',
    },
    {
      'name': 'Last Day to Add a Full Semester Class',
      'date': 'Tuesday, January 24, 2023',
    },
    {
      'name': 'Last Day to Drop a First Half Semester Class',
      'date': 'Tuesday, January 31, 2023',
    },
    {
      'name': 'Last Day to Declare a Major',
      'date': 'Friday, February 10, 2023',
    },
    {
      'name': 'Last Day to Declare Audit Option',
      'date': 'Tuesday, February 21, 2023',
    },
    {
      'name': 'Last Day to Drop Full Semester Class',
      'date': 'Tuesday, February 21, 2023',
    },
    {
      'name': 'Last Day to Declare Pass/Fail (S/NC) Option',
      'date': 'Tuesday, February 21, 2023',
    },
    {
      'name': 'First Day of Class for Second Half Semester Class',
      'date': 'Wednesday, March 1, 2023',
    },
    {
      'name': 'First Half Class Grade Deadline',
      'date': 'Friday, March 3, 2023',
    },
    {
      'name': 'Last Day to Add Second Half Semester Class',
      'date': 'Tuesday, March 7, 2023',
    },
    {
      'name': 'Senior I.S. Due to Registrar\'s Office',
      'date': 'Monday, March 27, 2023 by 5:00 p.m',
    },
    {
      'name': 'Advising Conferences: Class of 2024',
      'date': 'Monday, March 27 – Friday, March 31, 2023',
    },
    {
      'name': 'Class of 2024 Registration',
      'date': 'Monday, April 3 – Wednesday, April 5, 2023',
    },
    {
      'name': 'Advising Conferences: Class of 2025',
      'date': 'Monday, April 3 – Friday, April 7, 2023',
    },
    {
      'name': 'Last Day to Drop a Second Half Semester Class',
      'date': 'Tuesday, April 4, 2023',
    },
    {
      'name': 'Class of 2025 Registration',
      'date': 'Monday, April 10 – Wednesday, April 12, 2023',
    },
    {
      'name': 'Advising Conferences: Class of 2026',
      'date': 'Monday, April 10 – Friday, April 14, 2023',
    },
    {
      'name': 'Class of 2026 Registration',
      'date': 'Monday, April 17 – Thursday, April 20, 2023',
    },
    {
      'name': 'I.S. Symposium',
      'date': 'Friday, April 21, 2023',
    },
    {
      'name': 'Open Enrollment',
      'date': 'Monday, April 24 – Tuesday, May 2, 2023',
    },
    {
      'name': 'Spring Break',
      'date': 'Monday, May 15 – Sunday, June 4, 2023',
    },
    {
      'name': 'Last Day to Withdraw Full Semester Class with Petition',
      'date': 'Tuesday, May 2, 2023',
    },
    {
      'name': 'Last Day of Classes',
      'date': 'Tuesday, May 2023',
    },
    {
      'name': 'Final Examinations',
      'date':
          'Thursday, May 4 – Friday May 5, 2023, Monday, May 8 – Tuesday May 9, 2023',
    },
    {
      'name': 'Senior Grades Due',
      'date': 'Wednesday, May 10, 2023, noon',
    },
    {
      'name': 'Commencement',
      'date': 'Saturday, May 13, 2023',
    },
    {
      'name': 'Final Grades Due',
      'date': 'Monday, May 15, 2023, noon',
    },
    {
      'name': 'Spring Semester Incompletes - Student\'s Final Work Due',
      'date': 'Tuesday, May 30, 2023',
    },
    {
      'name': 'Spring Semester Incompletes - Faculty\'s Final Grade Due',
      'date': 'Tuesday, June 6, 2023',
    },
  ];

  // Stores the selected deadline from the dropdown menu
  Map<String, String>? selectedDeadline;

  // Function to show the deadlines menu and update the selected deadline
  Future<void> _showDeadlinesMenu(BuildContext context) async {
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Overlay.of(context)!.context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(Offset.zero, ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero),
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    // Builds the UI for the AcademicDeadlines screen
    Map<String, String>? deadline = await showMenu<Map<String, String>>(
      context: context,
      position: position,
      items: deadlines.map((deadline) {
        return PopupMenuItem<Map<String, String>>(
          value: deadline,
          child: Row(
            children: [
              Flexible(child: Text(deadline['name']!)),
            ],
          ),
        );
      }).toList(),
    );

    if (deadline != null) {
      setState(() {
        selectedDeadline = deadline;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Academic Deadlines'),
        backgroundColor: Colors.grey[850],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/woo_img2.jpeg"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.9),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(flex: 5),
              GestureDetector(
                onTap: () => _showDeadlinesMenu(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(color: Colors.white, width: 1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedDeadline == null
                            ? 'Select a deadline'
                            : selectedDeadline!['name']!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              if (selectedDeadline != null)
                Text(
                  '${selectedDeadline!['name']} is ${selectedDeadline!['date']}.',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              Spacer(flex: 10),
              Text(
                'Taken from the college website:',
                style: TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                    color: Colors.white),
              ),
              RichText(
                text: TextSpan(
                  text: 'https://inside.wooster.edu/registrar/deadlines/',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    color: Color(0xFFDEAB03),
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () async {
                      final url =
                          'https://inside.wooster.edu/registrar/deadlines/';
                      if (await canLaunch(url)) {
                        await launch(url);
                      } else {
                        throw 'Could not launch $url';
                      }
                    },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Class representing a dining location
class DiningLocation {
  final String name;
  final String image;
  final String times;
  final String menuUrl;
  final String mealSwipesUrl;
  final String lateNightMealUrl;

  DiningLocation({
    required this.name,
    required this.image,
    required this.times,
    this.menuUrl = '',
    this.mealSwipesUrl = '',
    this.lateNightMealUrl = '',
  });
}

// StatelessWidget that displays a list of dining locations
class Dining extends StatelessWidget {
  // List of dining location instances
  final List<DiningLocation> diningLocations = [
    DiningLocation(
      name: 'Lowry Center Dining Hall',
      image: 'assets/images/lowry.png',
      times: 'Monday – Friday\n\n7:00 a.m. - 8:00 p.m.',
      menuUrl:
          'https://sites.google.com/creativedining.com/dineatwooster/menus-locations/menus',
      mealSwipesUrl:
          'https://wooster.avrocustomer.com/login.aspx?ReturnUrl=%2flogin',
    ),
    DiningLocation(
      name: 'Knowlton Cafe',
      image: 'assets/images/knowlton.png',
      times: 'Monday – Friday\n\n7:30 a.m. - 6:00 p.m.',
    ),
    DiningLocation(
      name: 'Old Main Cafe',
      image: 'assets/images/oldmain.png',
      times: 'Monday – Friday\n\n7:30 a.m. - 6:00 p.m.',
    ),
    DiningLocation(
      name: "Mom's Late Night",
      image: 'assets/images/moms.png',
      times: 'Monday – Friday\n\n8:00 p.m. - 1:00 a.m.',
      lateNightMealUrl: 'https://collegeofwooster.trufflestg.com/near-location',
    ),
    DiningLocation(
      name: "MacLeod's Convenience Store & Coffee Shop",
      image: 'assets/images/cstore.png',
      times:
          'Monday - Friday\n\n7:00 a.m. - midnight\n\nSaturday - Sunday\n\n10:00 a.m. - midnight',
    ),
  ];

  // Function to launch the provided URL in a browser
  void _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Builds the UI for the Dining screen
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: diningLocations.length,
      itemBuilder: (context, index) {
        final diningLocation = diningLocations[index];
        return Card(
          child: Column(
            children: [
              Image.asset(diningLocation.image),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diningLocation.name,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Text(
                      diningLocation.times,
                      style: TextStyle(fontSize: 16),
                    ),
                    if (diningLocation.menuUrl.isNotEmpty ||
                        diningLocation.mealSwipesUrl.isNotEmpty)
                      SizedBox(height: 8),
                    if (diningLocation.menuUrl.isNotEmpty)
                      ElevatedButton(
                          onPressed: () => _launchUrl(diningLocation.menuUrl),
                          child: Text('Check Menu'),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFDEAB03))),
                    if (diningLocation.mealSwipesUrl.isNotEmpty)
                      ElevatedButton(
                          onPressed: () =>
                              _launchUrl(diningLocation.mealSwipesUrl),
                          child: Text('Check Meal Swipes'),
                          style: ElevatedButton.styleFrom(
                              primary: Color(0xFFDEAB03))),
                    if (diningLocation.lateNightMealUrl.isNotEmpty)
                      ElevatedButton(
                        onPressed: () =>
                            _launchUrl(diningLocation.lateNightMealUrl),
                        child: Text('Order a Late Night Meal'),
                        style: ElevatedButton.styleFrom(
                            primary: Color(0xFFDEAB03)),
                      ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// Class representing a shuttle stop
class Shuttle {
  final String location;
  final int schedule;

  Shuttle({required this.location, required this.schedule});
}

// List of shuttle stop instances
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

// Function to calculate the remaining time until a shuttle arrives at a given location
int _calculateRemainingTime(String location) {
  Shuttle shuttle =
      shuttles.firstWhere((shuttle) => shuttle.location == location);
  DateTime currentTime = DateTime.now();
  int currentHour = currentTime.hour;
  int currentMinute = currentTime.minute;

  // If it's past 10 PM, set the remaining time to -1
  if (currentHour >= 22) {
    return -1;
  }

  int remainingTime = 0;

  if (shuttle.schedule > currentMinute) {
    remainingTime = shuttle.schedule - currentMinute;
  } else {
    remainingTime = (60 - currentMinute) + shuttle.schedule;
  }

  return remainingTime;
}

// StatefulWidget representing the shuttle schedule screen
class ShuttleSchedule extends StatefulWidget {
  @override
  _ShuttleScheduleState createState() => _ShuttleScheduleState();
}

// State object for the ShuttleSchedule StatefulWidget
class _ShuttleScheduleState extends State<ShuttleSchedule> {
  // Variables to store the selected pickup and dropoff locations
  String? _pickupLocation;
  String? _dropoffLocation;

  // Builds the UI for the shuttle schedule screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Wooster Transit Schedule')),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/shuttle.png'), // Replace with your transit image
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.2), BlendMode.dstATop),
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

// StatefulWidget for the campus map screen
class CampusMap extends StatefulWidget {
  @override
  _CampusMapState createState() => _CampusMapState();
}

// State object for the CampusMap StatefulWidget
class _CampusMapState extends State<CampusMap> {
  late GoogleMapController _controller;

  final LatLng _woosterLatLng =
      LatLng(40.808884, -81.933188); // College of Wooster coordinates

  Set<Marker> _markers = {}; // Add markers for your locations

  // Initializes the state with custom markers for important locations on the campus
  @override
  void initState() {
    super.initState();

    _markers.addAll([
      _createMarker(
          id: 'library',
          position: LatLng(40.808884, -81.933188),
          label: 'Library',
          onTap: () => _launchMapsDirections('40.808884,-81.933188')),
    ]);
  }

  // Creates a marker with the given attributes
  Marker _createMarker(
      {required String id,
      required LatLng position,
      required String label,
      VoidCallback? onTap}) {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(title: label),
      onTap: onTap,
    );
  }

  // Builds the UI for the campus map screen
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: _woosterLatLng,
          zoom: 16, // Adjust zoom level to fit the entire campus
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

  // Function to launch Google Maps directions
  Future<void> _launchMapsDirections(String destination) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=walking';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

// StatelessWidget for the resources screen
class Resources extends StatelessWidget {
  // Lists of campus services and their corresponding URLs
  final List<String> services = [
    'Wellness Center',
    'Gym',
    'Libraries',
    'APEX',
    'Academic Resource Center',
    'Title IX',
    'Campus Safety'
  ];

  // Function to launch the URL in the browser
  final List<String> serviceUrls = [
    'https://wooster.edu/wellness-center/',
    'https://www.woosterathletics.com/scotcenter/index',
    'https://wooster.edu/library/library-hours/',
    'https://inside.wooster.edu/apex/',
    'https://inside.wooster.edu/arc/',
    'https://inside.wooster.edu/title-ix/',
    'https://inside.wooster.edu/safety/'
  ];

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Builds the UI for the resources screen
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
