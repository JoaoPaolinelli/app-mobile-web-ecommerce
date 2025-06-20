// src/models/Order.ts

// Payload de pedido para a API (campos no nível root)
export interface OrderItem {
  productId: number;
  productName: string;
  quantity: number;
  unitPrice: number; // em centavos
}

export interface OrderPayload {
  name: string;
  email: string;
  phone: string;
  address: string;
  zip: string;
  items: OrderItem[];
}

// Builder para montar o payload de pedido
export class OrderBuilder {
  private name!: string;
  private email!: string;
  private phone!: string;
  private address!: string;
  private zip!: string;
  private items: OrderItem[] = [];

  setCustomer(
    name: string,
    email: string,
    phone: string,
    address: string,
    zip: string
  ): this {
    this.name = name;
    this.email = email;
    this.phone = phone;
    this.address = address;
    this.zip = zip;
    return this;
  }

  addItem(item: Omit<OrderItem, 'unitPrice'> & { unitPrice: number }): this {
    this.items.push({ ...item });
    return this;
  }

  build(): OrderPayload {
    if (!this.name || !this.email) {
      throw new Error('Dados do cliente incompletos');
    }
    return {
      name: this.name,
      email: this.email,
      phone: this.phone,
      address: this.address,
      zip: this.zip,
      items: this.items,
    };
  }
}
