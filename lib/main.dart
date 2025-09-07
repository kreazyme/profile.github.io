import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:profile/profile_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FrameIt - Portfolio',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        fontFamily: GoogleFonts.firaMono().fontFamily,
      ),
      home: const ProfilePage(),
    );
  }
}
