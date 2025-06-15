// src/products/dto/product.dto.ts
export class ProductDto {
  id: string;
  name: string;
  description: string;
  category: string;
  imageUrl: string;
  price: number;
  hasDiscount: boolean;
  discountValue: number;
}
