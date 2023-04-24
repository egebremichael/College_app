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
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => LoginPage(),
        '/homepage': (context) => HomePage(),
      },
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Regular expression pattern for password validation
  final RegExp _passwordPattern =
      RegExp(r'^(?=.*[A-Z])(?=.*[!@#$&*])(?=.*[0-9])(?=.*[a-z]).{8,}$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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

String languageCodeFromName(String languageName) {
  switch (languageName) {
    case 'English':
      return 'en';
    case 'Español':
      return 'es';
    case 'Arabic':
      return 'ar';
    case 'Amharic':
      return 'am';
    // Add more languages here
    default:
      return 'en';
  }
}

String getWelcomeMessage(String languageCode) {
  switch (languageCode) {
    case 'en':
      return 'Welcome back!';
    case 'es':
      return 'Bienvenido de nuevo!';
    case 'fr':
      return 'Bienvenue à nouveau!';
    case 'ar':
      return 'مرحبًا بعودتك!';
    case 'ni':
      return 'ku aabọ pada!';
    case 'am':
      return 'እንኳን ደህና መጡ!';
    case 'mo':
      return 'Буцаад тавтай морил';
    case 'po':
      return 'Bem vindo de volta!';
    // Add more languages here
    default:
      return 'Welcome back!';
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = true;
  String? _selectedLanguage;
  Widget _homeWidget = Home();

  List<Widget> _widgetOptions() => [
        _homeWidget,
        DiningMenu(),
        ShuttleSchedule(),
        CampusMap(),
        HelpCenter(),
      ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  void _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamedAndRemoveUntil(context, '/loginpage', (route) => false);
  }

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
                      value: 'English',
                      child: Text('English'),
                    ),
                    DropdownMenuItem(
                      value: 'Español',
                      child: Text('Español'),
                    ),
                    DropdownMenuItem(
                      value: 'Arabic',
                      child: Text('Arabic'),
                    ),
                    DropdownMenuItem(
                      value: 'Amharic',
                      child: Text('Amharic'),
                    ),
                    DropdownMenuItem(
                      value: 'Mongolian',
                      child: Text('Mongolian'),
                    ),
                    DropdownMenuItem(
                      value: 'Kinyarwanda',
                      child: Text('Kinyarwanda'),
                    ),
                    //
                    //
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
              icon: Icon(Icons.map),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.help_center),
              label: 'Help Center',
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

class Home extends StatelessWidget {
  final String? preferredLanguage;
  const Home({super.key, this.preferredLanguage});

  String languageCodeFromName(String languageName) {
    switch (languageName) {
      case 'English':
        return 'en';
      case 'Español':
        return 'es';
      case 'Arabic':
        return 'ar';
      case 'Portugese':
        return 'po';
      case 'Amharic':
        return 'am';
      case 'Mongolian':
        return 'mo';
      case 'Kinyarwanda':
        return 'rw';
      default:
        return 'en';
    }
  }

  String getWelcomeMessage(String languageCode) {
    switch (languageCode) {
      case 'en':
        return 'Welcome back!';
      case 'es':
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
      // Add more languages here
      default:
        return 'Welcome back!';
    }
  }

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
                  color: Colors.black.withOpacity(0.6),
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
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Upcoming Events:',
                            style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Event 1 - Date & Time',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Event 2 - Date & Time',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          SizedBox(height: 4),
                          // Add more events here
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

class Events extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16), // Add some padding to the container
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6), // Darken the background
        image: DecorationImage(
          image: AssetImage('assets/images/woo_img.jpeg'),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6), BlendMode.srcATop),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
        children: [
          Text(
            'Upcoming Event:',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
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
            'Exam week - May 4 to May 9',
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

class AcademicDeadlines extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Academic Deadlines',
          style: TextStyle(
            fontFamily: 'Helvetica',
          ),
        ),
        backgroundColor: Colors.grey[850],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/woo_img2.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Opacity(
            opacity: 0.8,
            child: Container(
              color: Colors.black,
            ),
          ),
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
                    Text('  MLK Teach-In: Monday, January 16, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Add a First Half Semester Class: Tuesday, January 17, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Add a Full Semester Class: Tuesday, January 24, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Drop a First Half Semester Class: Tuesday, January 31, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Declare a Major: Friday, February 10, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Declare Audit Option: Tuesday, February 21, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Drop Full Semester Class: Tuesday, February 21, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Declare Pass/Fail (S/NC) Option: Tuesday, February 21, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  First Day of Class for Second Half Semester Class: Wednesday, March 1, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  First Half Class Grade Deadline: Friday, March 3, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Add Second Half Semester Class: Tuesday, March 7, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Senior I.S. Due to Registrar’s Office: Monday, March 27, 2023 by 5:00 p.m',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Advising Conferences: Class of 2024: Monday, March 27 – Friday, March 31, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Class of 2024 Registration: Monday, April 3 – Wednesday, April 5, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Advising Conferences: Class of 2025: Monday, April 3 – Friday, April 7, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Drop a Second Half Semester Class: Tuesday, April 4, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Class of 2025 Registration: Monday, April 10 – Wednesday, April 12, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Advising Conferences: Class of 2026: Monday, April 10 – Friday, April 14, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Class of 2026 Registration: Monday, April 17 – Thursday, April 20, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text('  I.S. Symposium: Friday, April 21, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Open Enrollment: Monday, April 24 – Tuesday, May 2, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Spring Break: Monday, May 15 – Sunday, June 4, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Last Day to Withdraw Full Semester Class with Petition: Tuesday, May 2, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text('  Last Day of Classes: Tuesday, May 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text(
                        '  Final Examinations: Thursday, May 4 – Friday May 5, 2023, Monday, May 8 – Tuesday May 9, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text('  Senior Grades Due: Wednesday, May 10, 2023, noon',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text('  Commencement: Saturday, May 13, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text('  Final Grades Due: Monday, May 15, 2023, noon',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    SizedBox(height: 16),
                    Text(
                      'Spring Semester Incompletes',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    Text('Student’s Final Work Due: Tuesday, May 30, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                    Text('Faculty’s Final Grade Due: Tuesday, June 6, 2023',
                        style: TextStyle(
                          color: Colors.white,
                        )),
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

  Future<void> loadPdf() async {
    final pdfFile =
        await copyAssetToTempDirectory('assets/documents/dining.pdf');
    setState(() {
      _pdfPath = pdfFile.path;
    });
  }

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

class Shuttle {
  final String location;
  final List<int> schedule;

  Shuttle({required this.location, required this.schedule});
}

final List<Shuttle> shuttles = [
  Shuttle(location: 'Lowry Circle', schedule: [2, 32]),
  Shuttle(location: 'Beall and Wayne', schedule: [10, 40]),
  Shuttle(location: 'Walmart', schedule: [15, 45]),
  Shuttle(location: 'Buelhers', schedule: [20, 50]),
];

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

  for (int time in shuttle.schedule) {
    if (time > currentMinute) {
      remainingTime = time - currentMinute;
      break;
    }
  }

  // If no matching time is found, calculate the time remaining until the next hour
  if (remainingTime == 0) {
    remainingTime = (60 - currentMinute) + shuttle.schedule[0];
  }

  return remainingTime;
}

class ShuttleSchedule extends StatefulWidget {
  @override
  _ShuttleScheduleState createState() => _ShuttleScheduleState();
}

class _ShuttleScheduleState extends State<ShuttleSchedule> {
  // Remove this list
  // final List<String> locations = [
  //   'Lowry Circle',
  //   'Beall and Wayne',
  //   'Walmart',
  //   'Buelhers',
  // ];

  String? _selectedLocation;
  int? _remainingTime;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/shuttle_bg.jpeg'), // Replace with your transit image
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<String>(
                  hint: Text('Select a location'),
                  value: _selectedLocation,
                  items: shuttles.map((Shuttle shuttle) {
                    return DropdownMenuItem<String>(
                      value: shuttle.location,
                      child: Text(shuttle.location),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                      _remainingTime = _calculateRemainingTime(newValue!);
                    });
                  },
                ),
                SizedBox(height: 20),
                if (_selectedLocation != null && _remainingTime != null)
                  Text(
                    _remainingTime == -1
                        ? 'The Wooster Transit is no longer available at $_selectedLocation for today.'
                        : 'The Wooster Transit will be at $_selectedLocation in $_remainingTime minutes',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white),
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

  Set<Marker> _markers = {}; // Add markers for your locations

  @override
  void initState() {
    super.initState();
    _markers.add(Marker(
      markerId: MarkerId('destination'),
      position:
          LatLng(40.808884, -81.933188), // Change this to the desired location
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
        '40.808884,-81.933188'; // Use the LatLng values of your desired location
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$destination&travelmode=walking';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

class HelpCenter extends StatelessWidget {
  final List<String> services = [
    'Wellness Center',
    'Academic Center',
    'APEX',
    'Gym',
    'Libraries' // Add more services here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Help Center'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/woo_logo.png'),
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.8),
              BlendMode.darken,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Which of these college services do you need help with?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
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
                      // You can handle each service's onTap event here
                      print('Tapped on ${services[index]}');
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
