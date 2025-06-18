// src/orders/dto/create-user-info.dto.ts
import { IsString, IsOptional, IsIn } from 'class-validator';

export class CreateUserInfoDto {
  @IsString() phoneNumber: string;
  @IsString() identification: string;
  @IsString() deliveryAddress: string;
  @IsOptional() @IsString() addressComplement?: string;
  @IsOptional() @IsString() deliveryInstructions?: string;
  @IsString()
  @IsIn(['CREDIT_CARD','PIX','BOLETO','OTHER'])
  paymentMethod: string;
}
