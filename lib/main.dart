import 'package:flutter/material.dart';
import 'package:my_map/pages/insideApp/home.dart';
import 'package:my_map/pages/insideApp/bus/busdirection_screen.dart';
import 'package:my_map/pages/userPages/sign_in/singin.dart';
import 'package:my_map/pages/userPages/sign_up/signup.dart';
import 'package:my_map/pages/userPages/welcome/welcome.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  await Supabase.initialize(
      url: 'https://fpzokiziymugabrilzoh.supabase.co',
      anonKey:
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZwem9raXppeW11Z2Ficmlsem9oIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mjc3ODUxMjksImV4cCI6MjA0MzM2MTEyOX0.se516l-61hMZRtt8pl1NP_wvAs1T0aTskNn-gzSzvO4');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomePage(),
        '/signUp': (context) => const Signup(),
        '/signIn': (context) => const Signin(),
        // '/forgetPassword': (context) => const Forgetpassword(),
        '/busDirection': (context) => const BusdirectionScreen(),
        '/home': (context) => const Home(),
        // '/my_account': (context) => const MyAccount(),
        // '/trash': (context) => const Trash(),
        // '/notifications': (context) => const Notifications(),
        // '/about': (context) => AboutPage(),
      },
      home: const WelcomePage(),
    );
  }
}
