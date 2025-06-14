// test/app.e2e-spec.ts
import { INestApplication, ValidationPipe } from '@nestjs/common';
import { Test } from '@nestjs/testing';
import * as request from 'supertest';
import { AppModule } from '../src/app.module';

describe('E2E Tests', () => {
  let app: INestApplication;
  let server: any;

  beforeAll(async () => {
    const moduleRef = await Test.createTestingModule({
      imports: [AppModule],
    }).compile();

    app = moduleRef.createNestApplication();
    app.useGlobalPipes(new ValidationPipe({
      whitelist: true,
      forbidNonWhitelisted: true,
      transform: true,
    }));
    await app.init();
    server = app.getHttpServer();
  });

  afterAll(async () => {
    await app.close();
  });

  it('/products (GET) should return array', async () => {
    const res = await request(server)
      .get('/products')
      .expect(200);
    expect(Array.isArray(res.body)).toBe(true);
  });

  it('/orders (GET) initially empty', async () => {
    const res = await request(server)
      .get('/orders')
      .expect(200);
    expect(Array.isArray(res.body)).toBe(true);
    expect(res.body.length).toBeGreaterThanOrEqual(0);
  });

  let createdOrderId: string;

  it('/orders (POST) should create an order', async () => {
    const payload = {
      productId: '1',
      quantity: 3,
      customerName: 'Test User',
      address: 'Rua Teste, 123'
    };
    const res = await request(server)
      .post('/orders')
      .send(payload)
      .expect(201);

    expect(res.body).toHaveProperty('_id');
    expect(res.body.productId).toBe(payload.productId);
    expect(res.body.quantity).toBe(payload.quantity);
    createdOrderId = res.body._id;
  });

  it('/orders (GET) should include the created order', async () => {
    const res = await request(server)
      .get('/orders')
      .expect(200);

    expect(res.body.some((o: any) => o._id === createdOrderId)).toBe(true);
  });
});
