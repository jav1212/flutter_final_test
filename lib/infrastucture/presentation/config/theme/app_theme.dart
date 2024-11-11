import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          bodySmall:
              GoogleFonts.baloo2().copyWith(color: Colors.black, fontSize: 17),
          bodyLarge:
              GoogleFonts.baloo2().copyWith(color: Colors.black, fontSize: 24),
          bodyMedium:
              GoogleFonts.baloo2().copyWith(color: Colors.black, fontSize: 18),
        ),
      );
}
