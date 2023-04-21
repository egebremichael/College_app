import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  String _email = '';
  String _password = '';

  Future<void> _signIn() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
            email: _email, password: _password);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                  onChanged: (value) => _email = value,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  onChanged: (value) => _password = value,
                ),
                SizedBox(height: 16),
                Center(
                  child: SignInButton(
                    Buttons.Email,
                    onPressed: _signIn,
                    text: "Sign In",
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = true;

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    DiningMenu(),
    ShuttleSchedule(),
    CampusMap(),
    HelpCenter()];

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
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
              SizedBox(width: 21), // Add some space between the logo and the title
              Text('ScotCentral', style: GoogleFonts.exo2(fontSize: 28)),
            ],
          ),
          actions: [
            IconButton(
              icon: _isDarkMode ? Icon(Icons.lightbulb_outline) : Icon(Icons.nightlight_round),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: Center(child: _widgetOptions.elementAt(_selectedIndex)),
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
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.grey.shade800, Colors.grey], // define the colors for the gradient
                  begin: Alignment.topCenter, // define the starting point for the gradient
                  end: Alignment.bottomCenter, // define the ending point for the gradient
                ),
              ),
              child: Center(
                child: Text(
                  'Welcome back Scot!',
                  style: GoogleFonts.crimsonPro(fontSize: 20)),
                ),
              ),
            ),
          Expanded(
            flex: 8,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/woo_img2.png'),
                  fit: BoxFit.cover,
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
    final pdfFile = await copyAssetToTempDirectory('assets/documents/dining.pdf');
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


class ShuttleSchedule extends StatefulWidget {
  @override
  _ShuttleScheduleState createState() => _ShuttleScheduleState();
}

class _ShuttleScheduleState extends State<ShuttleSchedule> {
  final List<String> locations = [
    'Lowry Circle',
    'Beall and Wayne',
    'Walmart',
    'Buelhers',
  ];

  String? _selectedLocation;
  int? _remainingTime;

  void _calculateRemainingTime(String location) {
    // Replace this with your logic to calculate the remaining time
    // based on the selected location
    setState(() {
      _remainingTime = location.length * 3;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(style: GoogleFonts.crimsonPro(fontSize: 20), 'Shuttle Schedule'),
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/shuttle_bg.jpeg'), // Replace with your transit image
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
                  items: locations.map((String location) {
                    return DropdownMenuItem<String>(
                      value: location,
                      child: Text(location),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedLocation = newValue;
                      _calculateRemainingTime(newValue!);
                    });
                  },
                ),
                SizedBox(height: 20),
                if (_selectedLocation != null && _remainingTime != null)
                  Text(
                    'The Wooster Transit will be at $_selectedLocation in $_remainingTime minutes',
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
  String? _pdfPath;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  Future<void> loadPdf() async {
    final pdfFile = await copyAssetToTempDirectory('assets/documents/campusmap.pdf');
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
class HelpCenter extends StatelessWidget {
  final List<String> services = [
    'Wellness Center',
    'Academic Center',
    'APEX',
    'Gym',
    'Libraries'    // Add more services here
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
