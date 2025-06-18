// // src/orders/schemas/order.schema.ts
// import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
// import { Document, Types } from 'mongoose';
// import { UserInfo, UserInfoSchema } from './user-info-schema';

// export type OrderDocument = Order & Document;

// @Schema()
// export class OrderItem {
//   @Prop({ type: Types.ObjectId, ref: 'Product', required: true })
//   productId: Types.ObjectId;

//   @Prop({ required: true })
//   productName: string;

//   @Prop({ required: true, min: 0 })
//   unitPrice: number;

//   @Prop({ required: true, min: 1 })
//   quantity: number;
// }

// export const OrderItemSchema = SchemaFactory.createForClass(OrderItem);

// @Schema({ timestamps: { createdAt: 'orderDate' } })
// export class Order {
//   @Prop({ type: [OrderItemSchema], required: true })
//   items: OrderItem[];

//   @Prop({ required: true, min: 0 })
//   totalAmount: number;

//   @Prop({ required: true, type: UserInfoSchema })
//   user: UserInfo;
// }

// export const OrderSchema = SchemaFactory.createForClass(Order);
// src/orders/schemas/order.schema.ts
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document, Types } from 'mongoose';
import { UserInfo, UserInfoSchema } from './user-info-schema';

export type OrderDocument = Order & Document;

@Schema({
  timestamps: { createdAt: 'orderDate', updatedAt: false },
  toJSON: {
    virtuals: true,
    versionKey: false,
    transform: (_doc, ret) => {
      ret.id = ret._id;
      delete ret._id;
    },
  },
})
export class OrderItem {
  @Prop({ type: Types.ObjectId, ref: 'Product', required: true })
  productId: Types.ObjectId;

  @Prop({ required: true })
  productName: string;

  @Prop({ required: true, min: 0 })
  unitPrice: number;

  @Prop({ required: true, min: 1 })
  quantity: number;
}
export const OrderItemSchema = SchemaFactory.createForClass(OrderItem);

@Schema({
  timestamps: { createdAt: 'orderDate', updatedAt: false },
  toJSON: {
    virtuals: true,
    versionKey: false,
    transform: (_doc, ret) => {
      ret.id = ret._id;
      delete ret._id;
    },
  },
})
export class Order {
  @Prop({ type: [OrderItemSchema], required: true })
  items: OrderItem[];

  @Prop({ required: true, min: 0 })
  totalAmount: number;

  @Prop({ required: true, type: UserInfoSchema })
  user: UserInfo;
}
export const OrderSchema = SchemaFactory.createForClass(Order);
