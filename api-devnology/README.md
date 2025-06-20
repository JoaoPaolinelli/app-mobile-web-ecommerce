# 📦 API Devnology – Resolução Teste Desenvolvedor(a) Júnior

> **Objetivo:**
> Construir uma solução full-stack de e-commerce, com front-end Web (React), Mobile (Flutter) e back-end opcional em Node.js/NestJS, integrando produtos de dois fornecedores, gerenciando carrinho e registro de pedidos.

---

## 📑 Sumário

1. [Visão Geral](#visão-geral)
2. [Requisitos de Projeto](#requisitos-de-projeto)
3. [Tecnologias e Dependências](#tecnologias-e-dependências)
4. [Arquitetura & Padrões de Projeto](#arquitetura--padrões-de-projeto)
5. [Setup & Como Rodar](#setup--como-rodar)
6. [Endpoints Principais](#endpoints-principais)
7. [Decisões Técnicas e Boas Práticas](#decisões-técnicas-e-boas-práticas)
8. [Testes](#testes)
9. [Docker](#docker)
10. [Swagger / API Docs](#swagger--api-docs)
11. [Próximos Passos / Diferenciais](#próximos-passos--diferenciais)

---

## 🌐 Visão Geral

* Integra produtos de dois fornecedores via APIs externas.
* Permite busca, filtro, carrinho de compras e checkout.
* Registra pedidos em MongoDB.
* (Opcional) Back-end em NestJS com cache e documentação Swagger.

---

## ✅ Requisitos de Projeto

**Obrigatórios**

* Listagem de produtos de dois fornecedores
* Busca e filtro
* Carrinho (adicionar/remover)
* Checkout com formulário do cliente
* Registro de compras (persistência)

**Diferenciais (opcionais)**

* Back-end unificado em NestJS

  * Endpoint único de produtos
  * Registro de compras via API
  * Autenticação JWT (futuro)
  * Docs Swagger

---

## 🛠️ Tecnologias e Dependências

* **NestJS** (modular, DI)
* **TypeScript**
* **Mongoose** (ODM MongoDB)
* **@nestjs/axios** + **cache-manager** (HTTP + cache)
* **@nestjs/config** (env vars)
* **class-validator** + **class-transformer** (DTOs)
* **Jest & Supertest** (testes)
* **ESLint & Prettier** (lint/format)
* **Swagger** (@nestjs/swagger)
* **Docker** (containerização)

<details>
<summary>📦 Principais pacotes (package.json)</summary>

"dependencies": {
  "@nestjs/common": "^10.x",
  "@nestjs/core": "^10.x",
  "@nestjs/axios": "^4.x",
  "@nestjs/cache-manager": "^3.x",
  "@nestjs/config": "^3.x",
  "@nestjs/mongoose": "^10.x",
  "@nestjs/swagger": "^6.x",
  "mongoose": "^7.x",
  "cache-manager": "^5.x",
  "class-validator": "^0.14.x",
  "class-transformer": "^0.5.x"
},
"devDependencies": {
  "jest": "^29.x",
  "ts-jest": "^29.x",
  "eslint": "^9.x",
  "prettier": "^3.x",
  "supertest": "^7.x",
  "ts-node": "^10.x"
}

</details>

---

## 🏛️ Arquitetura & Padrões de Projeto

* Modular: módulos por domínio (products, orders, etc.)
* Controller → Service → DTO/Schema
* Dependency Injection nativo NestJS
* DTOs + ValidationPipe global (whitelist, forbidNonWhitelisted)
* Mongoose Schemas para pedidos
* CacheInterceptor para chamadas de produtos
* @nestjs/config para variáveis de ambiente
* Swagger configurado em main.ts

---

## ⚙️ Setup & Como Rodar

1. Clone o repositório:

   git clone https://github.com/seu-usuario/api-devnology.git
   cd api-devnology
2. Crie o arquivo .env na raiz com as variáveis:

   BRAZILIAN_PROVIDER_URL=https://api.fornecedor-brasil.com/produtos
   EUROPEAN_PROVIDER_URL=https://api.fornecedor-europa.com/products
   MONGODB_URI=mongodb://localhost:27017/devnology
   PORT=3000

3. Instale as dependências:
 
   npm install
   
5. Para desenvolvimento:

   npm run start:dev
   
7. Para produção:

   npm run build
   npm run start:prod

---

## 🚀 Endpoints Principais

| Método | Rota                | Descrição                   |
| ------ | ------------------- | --------------------------- |
| GET    | `/products`         | Lista unificada de produtos |
| GET    | `/products?search=` | Busca / filtro de produtos  |
| POST   | `/orders`           | Cria um pedido              |
| GET    | `/orders/:id`       | Consulta pedido por ID      |
| GET    | `/api-docs`         | Interface Swagger           |

---

## 💡 Decisões Técnicas e Boas Práticas

* NestJS modular + DI para escalabilidade
* DTOs + ValidationPipe garantem segurança e integridade
* CacheInterceptor reduz latência externa
* Config Service desacopla ambiente do código
* Mongoose com schemas tipados
* Testes unitários & E2E
* ESLint & Prettier para código consistente
* Swagger para documentação viva

---

## 🔍 Testes

npm run test      # unitários
npm run test:cov  # cobertura
npm run test:e2e  # integração



## 📖 Swagger / API Docs

Acesse após subir a API em:

http://localhost:3000/api-docs


