// src/products/products.module.ts
import { Module } from '@nestjs/common';
import { HttpModule } from '@nestjs/axios';
import { ConfigModule } from '@nestjs/config';

import { ProductsController } from './products.controller';
import { BrazilianService } from './brazilian/brazilian.service';
import { EuropeanService } from './european/european.service';

@Module({
  imports: [HttpModule, ConfigModule],
  controllers: [ProductsController],
  providers: [BrazilianService, EuropeanService],
  exports: [BrazilianService, EuropeanService],  // ← exporte aqui
})
export class ProductsModule {}
