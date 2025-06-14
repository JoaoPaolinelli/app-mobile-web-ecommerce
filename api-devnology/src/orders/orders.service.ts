import { Injectable } from '@nestjs/common';
import { InjectModel } from '@nestjs/mongoose';
import { Model } from 'mongoose';
import { Order, OrderDocument } from './schemas/order.schema';
import { CreateOrderDto } from './dto/create-order.dto';

@Injectable()
export class OrdersService {
  constructor(
    @InjectModel(Order.name) private orderModel: Model<OrderDocument>,
  ) {}

  // Persiste (save) um novo pedido
  async create(dto: CreateOrderDto): Promise<Order> {
    const order = new this.orderModel(dto);
    return order.save();
  }

  // Lê (find) todos os pedidos
  async findAll(): Promise<Order[]> {
    return this.orderModel.find().exec();
  }
}
