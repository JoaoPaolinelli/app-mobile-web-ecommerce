import { NestFactory } from '@nestjs/core';
import { AppModule } from './app.module';
import { DocumentBuilder, SwaggerModule } from '@nestjs/swagger';
import { ValidationPipe } from '@nestjs/common';


async function bootstrap() {
  const app = await NestFactory.create(AppModule);
 
  app.enableCors();
  // app.enableCors({
  //   origin: ['*'],
  //   // origin: ['http://localhost:8080', 'http://localhost:5000'], // ou '*' para tudo
  //   methods: 'GET,HEAD,PUT,PATCH,POST,DELETE',
  // });

  const config = new DocumentBuilder()
    .setTitle('Devnology E-Commerce API')
    .setDescription('Endpoints de produtos e pedidos')
    .setVersion('1.0')
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api-docs', app, document);

  app.useGlobalPipes(new ValidationPipe({
  whitelist: true,
  forbidNonWhitelisted: true,
  transform: true,         // ← isso converte os tipos
  }));

  await app.listen(process.env.PORT || 3000);
}
bootstrap();
