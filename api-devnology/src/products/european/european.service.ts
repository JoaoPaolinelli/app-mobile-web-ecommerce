import { Injectable } from '@nestjs/common';
import { HttpService } from '@nestjs/axios';
import { firstValueFrom } from 'rxjs';
import { ConfigService } from '@nestjs/config';
import { ProductDto } from '../dto/product.dto';

@Injectable()
export class EuropeanService {
  private baseUrl: string;

  constructor(
    private http: HttpService,
    private config: ConfigService,
  ) {
    this.baseUrl = this.config.get<string>('api.europeanBaseUrl')!;
  }

  async findAll(): Promise<ProductDto[]> {
    const resp = await firstValueFrom(this.http.get<ProductDto[]>(this.baseUrl));
    return resp.data;
  }

  async findById(id: string): Promise<ProductDto> {
    const resp = await firstValueFrom(
      this.http.get<ProductDto>(`${this.baseUrl}/${id}`),
    );
    return resp.data;
  }
}
