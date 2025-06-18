// src/orders/orders.service.ts
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
    const totalAmount = createDto.items
      .reduce((sum, i) => sum + i.unitPrice * i.quantity, 0);

    const order = new this.orderModel({
      items: createDto.items,
      totalAmount,
      user: createDto.user,
    });

    return order.save();
  }

  /** Todos os pedidos, do mais novo para o mais antigo */
  async findAll(): Promise<Order[]> {
    return this.orderModel
      .find()
      .sort({ orderDate: -1 })
      .exec();
  }

  async findByUser(userId: string): Promise<Order[]> {
    return this.orderModel.find({ 'user.identification': userId }).exec();
  }
}
