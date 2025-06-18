import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';

import { CreateOrderDto } from './dto/create-order.dto';
import { Order, OrderDocument } from './schemas/order.schema';

@Injectable()
export class OrdersService {
  constructor(
    @InjectModel(Order.name) private orderModel: Model<OrderDocument>,
  ) {}

  async create(createDto: CreateOrderDto): Promise<Order> {
    // 1) gerar dados de usuário "fake"
    const fakeUser = {
      userId: 'auto-' + Math.random().toString(36).substr(2, 9),
      userName: 'User_' + Date.now(),
      userEmail: `user${Date.now()}@example.com`,
    };

    // 2) calcular totalAmount
    const totalAmount = createDto.items
      .reduce((sum, i) => sum + i.unitPrice * i.quantity, 0);

    // 3) montar o objeto completo
    const order = new this.orderModel({
      ...fakeUser,
      items: createDto.items,
      totalAmount,
      address: createDto.address ?? 'Endereço não informado',  // usa o valor enviado ou um default

      // orderDate e id são preenchidos pelo schema via default
    });

    // 4) salvar e retornar
    return order.save();
  }

  async findAll(): Promise<Order[]> {
    return this.orderModel.find().exec();
  }

  async findByUser(userId: string): Promise<Order[]> {
    return this.orderModel.find({ userId }).exec();
  }
}
