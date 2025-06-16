import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants/app_sizes.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/constants/app_colors.dart';
import '../../../models/banner_model.dart';

class BannerWidget extends StatelessWidget {
  final BannerModel banner;
  const BannerWidget({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Imagem de fundo
            Center(
              child: Image.asset(
                'assets/images/banner.png',
                fit: BoxFit.contain,
                // width: double.infinity,
                height: 180,
              ),
            ),

            // Conteúdo sobreposto
            Container(
              child: Positioned(
                left: AppSizes.padding + 48, // 16px
                top: AppSizes.padding + 4, // 16px
                child: SizedBox(
                  width: 200, // largura fixa do texto
                  height: 180 - AppSizes.padding * 2, // ajusta à altura interna
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Linha 1
                      Text(
                        banner.title
                            .split(' ')
                            .take(3)
                            .join(' '), // "Dia dos namorados"
                        style: AppTextStyles.banner.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),

                      // Linha 2 ("Devnology")
                      Text(
                        banner.title
                            .split(' ')
                            .skip(3)
                            .join(' '), // "Devnology"
                        style: AppTextStyles.bannerEmph.copyWith(fontSize: 16),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),

                      // Subtítulo
                      if (banner.subtitle != null) ...[
                        // Linha 1: “Desconto de até”
                        SizedBox(
                          width: 140,
                          child: Text(
                            'Desconto de até',
                            style: AppTextStyles.banner.copyWith(fontSize: 16),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 4),
                        // Linha 2: “30%”
                        SizedBox(
                          width: 140,
                          child: Text(
                            '30%',
                            style: AppTextStyles.bannerEmph.copyWith(
                              fontSize: 16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],

                      const Spacer(), // empurra o botão para baixo
                      // Botão “VER OFERTAS”
                      ElevatedButton(
                        onPressed: () => Get.toNamed(banner.buttonAction),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bannerButtonBg,
                          padding: const EdgeInsets.symmetric(
                            vertical: AppSizes.buttonPaddingVertical,
                            horizontal: AppSizes.buttonPaddingHorizontal,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppSizes.buttonRadius,
                            ),
                          ),
                        ),
                        child: Text(
                          banner.buttonText,
                          style: AppTextStyles.bannerButton,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
