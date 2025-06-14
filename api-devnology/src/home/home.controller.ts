// src/home/home.controller.ts
import { Controller, Get, Query } from '@nestjs/common';
import { HomeService } from './home.service';
import { BannerDto } from './dto/banner.dto';
import { ProductDto } from '../products/dto/product.dto';
import { BrazilianService } from '../products/brazilian/brazilian.service';
import { EuropeanService } from '../products/european/european.service';

@Controller('home')
export class HomeController {
  constructor(
    private readonly homeService: HomeService,
    private readonly brazilian: BrazilianService,
    private readonly european: EuropeanService,
  ) {}

  @Get('banner')
  getBanner(): BannerDto {
    return this.homeService.getBanner();
  }

  @Get('most-ordered')
  async getMostOrdered(
    @Query('limit') limit = 3,
  ): Promise<ProductDto[]> {
    const all = await this.getAllProducts();
    return shuffle(all).slice(0, +limit);
  }

  @Get('favorites')
  async getFavorites(
    @Query('limit') limit = 3,
  ): Promise<ProductDto[]> {
    const all = await this.getAllProducts();
    return shuffle(all).slice(0, +limit);
  }

  private async getAllProducts(): Promise<ProductDto[]> {
    const [br, eu] = await Promise.all([
      this.brazilian.findAll(),
      this.european.findAll(),
    ]);
    return [...br, ...eu];
  }
}

// função auxiliar para embaralhar
function shuffle<T>(array: T[]): T[] {
  return array
    .map(value => ({ value, sort: Math.random() }))
    .sort((a, b) => a.sort - b.sort)
    .map(({ value }) => value);
}
