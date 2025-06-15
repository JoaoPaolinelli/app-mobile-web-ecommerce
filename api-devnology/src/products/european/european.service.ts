// src/products/european/european.service.ts
import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { ConfigService } from '@nestjs/config';
import { ProductDto } from '../dto/product.dto';

@Injectable()
export class EuropeanService {
  private baseUrl: string;
  constructor(private http: HttpService, private config: ConfigService) {
    this.baseUrl = this.config.get<string>('api.europeanBaseUrl')!;
  }

  private toDto(raw: any): ProductDto {
    return {
      id: raw.id.toString(),
      name: raw.name ?? '',
      description: raw.description ?? '',
      category: raw.details?.adjective ?? '',
      imageUrl: Array.isArray(raw.gallery) && raw.gallery.length > 0
        ? raw.gallery[0]
        : '',
      price: parseFloat(raw.price) || 0,
      hasDiscount: raw.hasDiscount === true,
      discountValue: parseFloat(raw.discountValue) || 0,
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
