# 🚀 Devnology Full-Stack E-Commerce

> **Resolução Teste Desenvolvedor(a) Júnior**

Este repositório contém a solução completa de um e-commerce full-stack, abrangendo:

- **Front-end Web**: SPA em React + Material-UI  
- **App Mobile**: Flutter nativo [Melhor desenvolvimento] 
- **(FEITO-Opcional) Back-end**: API unificada em Node.js/NestJS  

---

## 📋 Requisitos Obrigatórios

1. **Listagem de produtos** de dois fornecedores externos  
2. **Busca e filtro** de produtos  
3. **Carrinho de compras** (adicionar, remover, ajustar quantidade)  
4. **Checkout** com formulário de cliente  
5. **Registro de pedidos** em persistência (MongoDB ou similar)  

<details>
<summary>🎯 Requisitos Opcionais / Diferenciais</summary>

- Endpoint único de produtos via **NestJS**  
- Cache de chamadas HTTP  
- Documentação **Swagger**  
- CI/CD (GitHub Actions)  
- Testes unitários e E2E  
</details>

---

## 🔧 Tecnologias

| Camada      | Stack / Bibliotecas                                  |
|-------------|------------------------------------------------------|
| **Web**     | React, React Router, Axios, Material-UI, FontAwesome |
| **Mobile**  | Flutter, GetX, Provider, Shared_Preferences, HTTP    |
| **Backend** | NestJS, TypeScript, Mongoose, Axios, Cache-Manager   |
| **DevOps**  | Docker, GitHub Actions, ESLint, Prettier             |

---

## ⚙️ Como Rodar

### 1. Front-end Web (React)

cd frontend-react
npm install
npm start
# Acesse http://localhost:5173/
2. App Mobile (Flutter)

cd mobile-flutter
flutter pub get
flutter run
# Emulador ou dispositivo conectado
3. API (NestJS)
bash
Copiar
Editar
cd api-devnology
cp .env.example .env        # Preencha endpoints e MONGODB_URI
npm install
npm run start:dev
# Swagger em http://localhost:3000/api-docs

📐 Arquitetura & Boas Práticas
Modularidade: separação clara entre domínios (produtos, pedidos, UI, serviços)

DI & Controllers: NestJS e GetX para injeção de dependências e organização

DTOs + Validation: entrada validada via class-validator (backend) e Form (Flutter)

Cache & Performance: interceptors e cache-manager para produtos

Theming: MUI Theme (web) e ThemeData (Flutter) com constantes de estilo

State Management: Context API / Zustand (web) e GetX + Provider (mobile)

Lint & Format: ESLint + Prettier e analysis_options.yaml (Flutter)

Documentação Viva: Swagger UI para API; README claros para web e mobile

📂 Estrutura Geral

/frontend-react      # SPA React + MUI
/mobile-flutter      # App Flutter nativo
/api-devnology       # API NestJS (opcional)
/README.md           # Documentação geral (este arquivo)
