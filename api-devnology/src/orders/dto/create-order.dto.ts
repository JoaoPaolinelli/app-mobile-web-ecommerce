// src/orders/dto/create-order.dto.ts
import {
  ValidateNested,
  ArrayMinSize,
} from 'class-validator';
import { Type } from 'class-transformer';
import { OrderItemDto } from './order-item.dto';
import { CreateUserInfoDto } from './create-user-info.dto';

export class CreateOrderDto {
  @ValidateNested({ each: true })
  @Type(() => OrderItemDto)
  @ArrayMinSize(1)
  items: OrderItemDto[];

  @ValidateNested()
  @Type(() => CreateUserInfoDto)
  user: CreateUserInfoDto;
}
