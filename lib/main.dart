import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:magic_fit_workout/views/workout_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          colorScheme: const ColorScheme(
            primary: Colors.deepPurple,
            onPrimary: Colors.white,
            secondary: Colors.white,
            onSecondary: Colors.black,
            error: Colors.redAccent,
            onError: Colors.white,
            surface: Colors.white,
            onSurface: Colors.black,
            brightness: Brightness.light,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          )),
          useMaterial3: true,
          fontFamily: GoogleFonts.roboto().fontFamily,

          //Background color
          scaffoldBackgroundColor: Colors.white,

          // Text Theme
          textTheme: TextTheme(
            titleLarge: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            titleMedium: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
            bodyLarge: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.normal,
                color: Colors.grey[800]),
            bodyMedium: TextStyle(fontSize: 14, color: Colors.grey[600]),
          )),
      home: const WorkoutListScreen(),
    );
  }
}
