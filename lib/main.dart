import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeNotifier(ThemeData.dark()), // Start with dark theme
      child: MyApp(),
    ),
  );
}

class ThemeNotifier extends ChangeNotifier {
  ThemeData _themeData;

  ThemeNotifier(this._themeData);

  ThemeData getTheme() => _themeData;

  void setDarkMode() {
    _themeData = ThemeData.dark().copyWith(
      primaryColor: Colors.black,
      hintColor: Colors.greenAccent, // Neon green
      scaffoldBackgroundColor: Colors.black,
      cardColor: Colors.grey[900],
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: Colors.white,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'San Francisco', 
        ),
        bodyLarge: TextStyle(
          color: Colors.white70,
          fontSize: 16,
          fontFamily: 'San Francisco', 
        ),
      ),
    );
    notifyListeners();
  }

  void setLightMode() {
    _themeData = ThemeData.light().copyWith(
      primaryColor: Colors.black,
      hintColor: Colors.greenAccent,
      scaffoldBackgroundColor: Colors.white,
      cardColor: Colors.white,
      buttonTheme: ButtonThemeData(
        buttonColor: Colors.greenAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
          color: Colors.black,
          fontSize: 32,
          fontWeight: FontWeight.bold,
          fontFamily: 'San Francisco',
        ),
        bodyLarge: TextStyle(
          color: Colors.black87,
          fontSize: 16,
          fontFamily: 'San Francisco',
        ),
      ),
    );
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeNotifier>(
      builder: (context, themeNotifier, child) {
        return MaterialApp(
          title: 'LOGIN App',
          theme: themeNotifier.getTheme(),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/signup': (context) => const SignupScreen(),
            '/home': (context) => const HomeScreen(),
          },
        );
      },
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String? _email, _password;

  final String _correctEmail = "something@example.com";
  final String _correctPass = "123456";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("LOGIN", style: theme.textTheme.headlineSmall),
        backgroundColor: theme.primaryColor,
        titleTextStyle: const TextStyle(fontWeight:FontWeight.bold),
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: theme.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0), 
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Welcome Back",
                    style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Username",
                      hintText: "e.g., $_correctEmail",
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 43, 43, 43),
                      hintStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white54),
                    ),
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "e.g., $_correctPass",
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: const Color.fromARGB(255, 32, 32, 32)  ,  
                      hintStyle: const TextStyle(color: Colors.white54),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (_email == _correctEmail && _password == _correctPass) {
                          Navigator.pushReplacementNamed(context, '/home');
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Invalid email or password')),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.greenAccent, // Neon green buttons
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text("LOGIN IN", style: TextStyle(fontWeight:FontWeight.bold,color: Colors.black)),
                  ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/signup');
                    },
                    child: const Text("New user? Sign Up", style: TextStyle(color: Colors.greenAccent)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("SIGN UP", style: theme.textTheme.headlineSmall),
        backgroundColor: theme.primaryColor,
      ),
      body: Center(
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: theme.cardColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sign up",
                    style: theme.textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Full Name",
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[800],
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: const OutlineInputBorder(),
                      filled: true,
                      fillColor: Colors.grey[800],
                    ),
                    style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(255, 66, 66, 66),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: "Confirm password",
                      border: OutlineInputBorder(),
                      filled: true,
                      fillColor: Color.fromARGB(255, 66, 66, 66),
                    ),
                    obscureText: true,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      backgroundColor: Colors.greenAccent, 
                      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    ),
                    child: const Text(
                      "SIGN UP",
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: const Text("Already have an account? LOGIN", style: TextStyle(color: Colors.greenAccent)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("HOME", style: theme.textTheme.headlineSmall),
        backgroundColor: theme.primaryColor,
        actions: [
          IconButton(
            icon: Icon(
              theme.brightness == Brightness.dark ? Icons.wb_sunny : Icons.nightlight_round,
            ),
            onPressed: () {
              final themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
              if (themeNotifier.getTheme() == ThemeData.dark()) {
                themeNotifier.setLightMode();
              } else {
                themeNotifier.setDarkMode();
              }
            },
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'For You'),
            Tab(text: 'Trending'),
            Tab(text: 'Favorites'),
            Tab(text: 'Settings'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(child: Text("For You", style: theme.textTheme.bodyLarge)),
          Center(child: Text("Trending", style: theme.textTheme.bodyLarge)),
          Center(child: Text("Favorites", style: theme.textTheme.bodyLarge)),
          Center(child: Text("Settings", style: theme.textTheme.bodyLarge)),
        ],
      ),
    );
  }
}
