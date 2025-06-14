import { Type } from 'class-transformer';
import { IsString, IsNotEmpty, IsOptional, IsNumber, Min } from 'class-validator';

export class CreateOrderDto {
  @IsString() @IsNotEmpty()
  productId: string;

  @Type(() => Number)      // ← garante que o valor seja convertido
  @IsNumber() @Min(1)
  quantity: number;

  @IsString() @IsNotEmpty()
  customerName: string;

  @IsString() @IsOptional()
  address?: string;
}
