import { Injectable } from '@nestjs/common';
import { BannerDto } from './dto/banner.dto';

@Injectable()
export class HomeService {
  getBanner(): BannerDto {
    return {
      imageUrl: 'https://…/valentine.jpg',
      title: 'Dia dos namorados Devnology',
      subtitle: 'Descontos de até 30%',
      buttonText: 'VER OFERTAS',
      buttonAction: '/products?promo=true',
    };
  }
}
