// import { Controller, Post, Body, Get, Query, Param } from '@nestjs/common';
// import { ApiQuery, ApiTags } from '@nestjs/swagger';
// import { OrdersService } from './orders.service';
// import { CreateOrderDto } from './dto/create-order.dto';
// import { Order } from './schemas/order.schema';

// @ApiTags('orders')
// @Controller('orders')
// export class OrdersController {
//   constructor(private readonly svc: OrdersService) {}

//   @Post()
//   async create(@Body() dto: CreateOrderDto): Promise<Order> {
//     return this.svc.create(dto);
//   }

//   /** GET /orders?userId=opcional */
//   @Get()
//   @ApiQuery({ name: 'userId', required: false, description: 'Filtra por userId (identification)' })
//   async list(@Query('userId') userId?: string): Promise<Order[]> {
//     return userId
//       ? this.svc.findByUser(userId)
//       : this.svc.findAll();
//   }

//   @Get('user/:userId')
//   async listByUser(@Param('userId') userId: string): Promise<Order[]> {
//     return this.svc.findByUser(userId);
//   }
// }

// src/orders/orders.controller.ts
import { Controller, Post, Body, Get, Query, Param } from '@nestjs/common';
import { ApiQuery, ApiTags } from '@nestjs/swagger';
import { OrdersService } from './orders.service';
import { CreateOrderDto } from './dto/create-order.dto';
import { Order } from './schemas/order.schema';

@ApiTags('orders')
@Controller('orders')
export class OrdersController {
  constructor(private readonly svc: OrdersService) {}

  @Post()
  async create(@Body() dto: CreateOrderDto): Promise<Order> {
    return this.svc.create(dto);
  }

  /** 
   * GET /orders?userId=opcional
   */
  @Get()
  @ApiQuery({ name: 'userId', required: false, description: 'Filtra por identificação do usuário' })
  async list(@Query('userId') userId?: string): Promise<Order[]> {
    return userId ? this.svc.findByUser(userId) : this.svc.findAll();
  }

  /**
   * GET /orders/user/:userId
   */
  @Get('user/:userId')
  async listByUser(@Param('userId') userId: string): Promise<Order[]> {
    return this.svc.findByUser(userId);
  }
}

