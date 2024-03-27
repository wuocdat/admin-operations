import 'package:flutter/material.dart' hide Colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:tctt_mobile/theme/colors.dart';

final ThemeData theme = ThemeData(
  primaryColor: Colors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.primary,
  ),
  textTheme: GoogleFonts.urbanistTextTheme(),
);
