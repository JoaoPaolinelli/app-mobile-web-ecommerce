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

  //
  // Configuracoes pagina profile
  //
  static const headingProfile = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: Color(0xFF060606),
    letterSpacing: 0.03,
  );

  static const buttonProfile = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.03,
  );

  static const sectionTitleProfile = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color(0xFF060606),
  );

  static const itemLabelProfile = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: Color(0xFF060606),
  );

  //
  //FIM Configuracoes Profile
  //
  //
  // Título principal da página Sacola
  //
  static const cartTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);

  // Texto leve no card de entrega
  static const cartDeliveryInfo = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: Color(0xFF060606),
  );

  // Título da sessão de cupom
  static const cartCouponTitle = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );

  // Subtítulo da sessão de cupom
  static const cartCouponSubtitle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    letterSpacing: 0.3,
  );

  // Botão "Entrar ou fazer cadastro"
  static const cartLoginButton = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.0,
  );

  // Título da sessão de produtos
  static const cartProductsTitle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  // Título do produto no card
  static const cartProductName = TextStyle(fontSize: 10);

  // Descrição do produto no card
  static const cartProductDescription = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.w300,
  );

  // Preço do produto
  static const cartProductPrice = TextStyle(
    fontSize: 10,
    color: Color(0xFF0828C9),
  );

  // Quantidade de produto
  static const cartProductQuantity = TextStyle(
    fontSize: 8,
    fontWeight: FontWeight.bold,
  );

  // Texto "Total"
  static const cartTotalLabel = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
  );

  // Valor total
  static const cartTotalValue = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
  );

  // Texto do botão Continuar
  static const cartContinueButton = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  //
  // FIM
  //
}
