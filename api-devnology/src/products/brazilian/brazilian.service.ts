// src/products/brazilian/brazilian.service.ts
import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { ConfigService } from '@nestjs/config';
import { ProductDto } from '../dto/product.dto';

@Injectable()
export class BrazilianService {
  private baseUrl: string;
  constructor(private http: HttpService, private config: ConfigService) {
    this.baseUrl = this.config.get<string>('api.brazilianBaseUrl')!;
  }

  private toDto(raw: any): ProductDto {
    return {
      id: raw.id.toString(),
      name: raw.nome ?? raw.name ?? '',
      description: raw.descricao ?? '',
      category: raw.categoria ?? '',
      imageUrl: raw.imagem ?? '',
      price: parseFloat(raw.preco) || 0,
      hasDiscount: false,
      discountValue: 0,
    };
  }

  async findAll(): Promise<ProductDto[]> {
    const resp = await firstValueFrom(this.http.get<any[]>(this.baseUrl));
    return resp.data.map(r => this.toDto(r));
  }

  async findById(id: string): Promise<ProductDto> {
    const resp = await firstValueFrom(this.http.get<any>(`${this.baseUrl}/${id}`));
    return this.toDto(resp.data);
  }
}
