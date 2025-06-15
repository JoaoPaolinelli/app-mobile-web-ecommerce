import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Banner
  static final banner = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w500, // Medium
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );
  static final bannerEmph = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700, // SemiBold
    letterSpacing: 0.5,
    color: AppColors.textPrimary,
  );
  static final bannerButton = GoogleFonts.poppins(
    fontSize: 8,
    fontWeight: FontWeight.w700, // Bold
    color: const Color.fromARGB(255, 255, 255, 255),
  );

  // Seções
  static final sectionTitle = GoogleFonts.poppins(
    fontSize: 14,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.bannerButtonBg,
  );
  static final sectionLink = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w700, // Bold
    color: AppColors.bannerButtonBg,
  );

  // Produto
  static final productName = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textSecondary,
  );
  static final productSub = GoogleFonts.poppins(
    fontSize: 8,
    fontWeight: FontWeight.w200, // ExtraLight
    color: AppColors.textSecondary,
  );
  static final productPrice = GoogleFonts.poppins(
    fontSize: 10,
    fontWeight: FontWeight.w400, // Regular
    color: AppColors.textSecondary,
  );
}
