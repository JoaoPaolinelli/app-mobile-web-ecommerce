// src/orders/schemas/user-info.schema.ts
import { Prop, Schema, SchemaFactory } from '@nestjs/mongoose';
import { Document } from 'mongoose';

export type UserInfoDocument = UserInfo & Document;

@Schema({ _id: false })
export class UserInfo {
  @Prop({ required: true })
  phoneNumber: string;

  @Prop({ required: true })
  identification: string;            // CPF, RG...

  @Prop({ required: true })
  deliveryAddress: string;

  @Prop()
  addressComplement?: string;

  @Prop()
  deliveryInstructions?: string;

  @Prop({ required: true, enum: ['CREDIT_CARD','PIX','BOLETO','OTHER'] })
  paymentMethod: string;
}

export const UserInfoSchema = SchemaFactory.createForClass(UserInfo);
