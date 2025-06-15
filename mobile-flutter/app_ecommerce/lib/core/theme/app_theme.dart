import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_sizes.dart';
import '../constants/app_text_styles.dart';

class AppTheme {
  static ThemeData get light {
    return ThemeData(
      // Core
      scaffoldBackgroundColor: AppColors.background,
      primaryColor: AppColors.bannerButtonBg,
      colorScheme: ColorScheme.light(
        primary: AppColors.bannerButtonBg,
        secondary: AppColors.purchaseButton,
        background: AppColors.background,
        surface: AppColors.surface,
        onPrimary: AppColors.textPrimary,
        onSecondary: AppColors.textSecondary,
        error: AppColors.error,
      ),

      // // Tipografia
      // textTheme: TextTheme(
      //   headline1: AppTextStyles.banner, // se quiser usar
      //   headline6: AppTextStyles.sectionTitle, // títulos
      //   bodyText1: AppTextStyles.productName, // corpo
      //   bodyText2: AppTextStyles.productSub,
      //   button: AppTextStyles.bannerButton,
      // ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        iconTheme: IconThemeData(
          size: AppSizes.iconSize,
          color: AppColors.textPrimary,
        ),
        titleTextStyle: AppTextStyles.sectionTitle,
      ),

      // ElevatedButton padrão
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.bannerButtonBg,
          padding: const EdgeInsets.symmetric(
            vertical: AppSizes.buttonPaddingVertical,
            horizontal: AppSizes.buttonPaddingHorizontal,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.buttonRadius),
          ),
          textStyle: AppTextStyles.bannerButton,
        ),
      ),

      // Icones
      iconTheme: IconThemeData(
        size: AppSizes.iconSize,
        color: AppColors.textPrimary,
      ),

      // Card
      cardTheme: CardTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius),
        ),
        margin: const EdgeInsets.all(AppSizes.margin / 2),
        elevation: 2,
      ),

      // ListTile (em menus, sacola etc)
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSizes.padding,
        ),
        tileColor: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadius / 2),
        ),
      ),
    );
  }
}
