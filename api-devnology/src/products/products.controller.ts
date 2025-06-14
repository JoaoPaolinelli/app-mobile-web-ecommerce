import { Controller, Get, Param } from '@nestjs/common';
import { BrazilianService } from './brazilian/brazilian.service';
import { EuropeanService } from './european/european.service';
import { ProductDto } from './dto/product.dto';

@Controller('products')
export class ProductsController {
  constructor(
    private readonly brazilian: BrazilianService,
    private readonly european: EuropeanService,
  ) {}

  @Get()
  async findAll(): Promise<ProductDto[]> {
    const [br, eu] = await Promise.all([
      this.brazilian.findAll(),
      this.european.findAll(),
    ]);
    return [...br, ...eu];
  }

  @Get(':id')
  async findOne(@Param('id') id: string): Promise<ProductDto> {
    try {
      return await this.brazilian.findById(id);
    } catch {
      return this.european.findById(id);
    }
  }
}
