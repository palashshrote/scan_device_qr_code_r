import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './screens/home_page.dart';
import './screens/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';

/*void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}*/
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp()); //entry point when application starts
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  //constant constructor "MyApp", its instance is created at compile time
  //StatefulWidget class property "key" is passed as a constructor parameter
  //used for identifying widgets and manage their state efficiently.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Scanner',
      theme: ThemeData(
        brightness: Brightness.dark, //for dark theme
      ),
      home: StreamBuilder(
        //StreamBuilder to handle authentication state changes
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomePage();
          } else {
            return const LoginPage();
          }
        },
      ),
    );
  }
}
