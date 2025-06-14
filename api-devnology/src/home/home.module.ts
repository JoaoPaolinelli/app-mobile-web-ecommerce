import { Module } from '@nestjs/common';
import { HomeController } from './home.controller';
import { HomeService } from './home.service';


import { ProductsModule } from '../products/products.module';  // ← importe o módulo


@Module({
  imports:  [
    ProductsModule,
  ],
  
  controllers: [HomeController],
  providers: [HomeService]
})
export class HomeModule {}
