import { Module } from '@nestjs/common';
import { CategoriesService } from './categories.service';
import { CategoriesController } from './categories.controller';
import { BrazilianService } from '../products/brazilian/brazilian.service';
import { EuropeanService } from '../products/european/european.service';
import { HttpModule } from '@nestjs/axios';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [HttpModule, ConfigModule],
  controllers: [CategoriesController],
  providers: [CategoriesService, BrazilianService, EuropeanService],
})
export class CategoriesModule {}
