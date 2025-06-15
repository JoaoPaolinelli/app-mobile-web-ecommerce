// src/products/products.controller.ts
import { Controller, Get, Param, Query } from '@nestjs/common';
import { ApiQuery, ApiTags } from '@nestjs/swagger';
import { BrazilianService } from './brazilian/brazilian.service';
import { EuropeanService } from './european/european.service';
import { ProductDto } from './dto/product.dto';

@ApiTags('products')
@Controller('products')
export class ProductsController {
  constructor(
    private readonly brazilian: BrazilianService,
    private readonly european: EuropeanService,
  ) {}

  @Get()
  @ApiQuery({
    name: 'limit',
    required: false,
    type: Number,
    description: 'Número máximo de itens retornados',
  })
  @ApiQuery({
    name: 'filter',
    required: false,
    type: String,
    description: 'Filtro de tipo especial (e.g. "most-ordered", "favorites")',
  })
  async findAll(
    @Query('limit') limit = 0,
    @Query('filter') filter?: string,
  ): Promise<ProductDto[]> {
    // Busca em paralelo das duas APIs
    const [br, eu] = await Promise.all([
      this.brazilian.findAll(),
      this.european.findAll(),
    ]);

    let all = [...br, ...eu];

    // Exemplo de tratamento de "filter" se quiser futuramente:
    if (filter === 'most-ordered') {
      // implemente lógica de ordenar por popularidade
    } else if (filter === 'favorites') {
      // implemente lógica de favoritos
    }

    // Se limit > 0, aplica slice, senão retorna tudo
    if (limit > 0) {
      all = all.slice(0, limit);
    }

    return all;
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
