import 'package:flutter/material.dart' hide Colors;
import 'package:google_fonts/google_fonts.dart';
import 'package:tctt_mobile/theme/colors.dart';

final ThemeData theme = ThemeData(
  primaryColor: AppColors.primary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: AppColors.primary,
    background: AppColors.primaryBackground,
  ),
  textTheme: GoogleFonts.robotoTextTheme(),
);
