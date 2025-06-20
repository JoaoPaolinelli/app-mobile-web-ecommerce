# Front-end Web (React)

> **Objetivo**
> Consumir a API unificada de produtos, permitindo busca, filtro, carrinho e checkout em uma SPA React com experiência fluida e componentes Material-UI.

---
## 📂 Estrutura de Pastas

```
/src
├── assets/            # Imagens, fontes e ícones estáticos
├── components/        # Componentes genéricos e reutilizáveis
│   ├── ProductCard/   # Card de produto (imagem, nome, preço, botão)
│   ├── Navbar/        # Barra de navegação principal
│   ├── Carousel/      # Carrossel de categorias
│   └── …
├── pages/             # Páginas mapeadas em rotas
│   ├── HomePage/      # Lista de categorias + carrossel
│   ├── CategoryPage/  # Produtos filtrados por categoria
│   ├── CartPage/      # Visão do carrinho e resumo
│   ├── CheckoutPage/  # Formulário de checkout
│   └── ProfilePage/   # Dados do usuário (opcional)
├── services/          # Instâncias Axios e chamadas a APIs
│   └── api.js         # Configura baseURL e interceptors
├── store/             # Context API / Zustand
│   └── cartContext.js # Estado global do carrinho
├── routes/            # Configuração de React Router
│   └── AppRoutes.js
├── styles/            # Tema MUI e estilos globais
│   └── theme.js
└── index.js           # Entrypoint, BrowserRouter e ThemeProvider
```

---

## ⚙️ Dependências Principais

```bash
npm install react react-dom react-router-dom axios \
  @mui/material @mui/icons-material \
  @emotion/react @emotion/styled \
  @fortawesome/react-fontawesome @fortawesome/free-solid-svg-icons
```

* **react-router-dom**: roteamento SPA
* **axios**: cliente HTTP
* **@mui/material + @mui/icons-material**: componentes UI e ícones
* **@emotion/react + @emotion/styled**: CSS-in-JS para MUI
* **@fortawesome/react-fontawesome**: biblioteca de ícones

---

## 🏗️ Setup & Como Rodar


1. **Instale as dependências**

   ```bash
   npm install
   ```

2. **Inicie em modo de desenvolvimento**

   ```bash
   npm start
   ```

   Abre automaticamente em [http://localhost:5173](http://localhost:3000)

3. **Build para produção**

   ```bash
   npm run build
   ```

---

## 🏛️ Arquitetura & Padrões de Projeto

* **Component-Driven**
  UI dividida em componentes atômicos e compostos.
* **Gerenciamento de Estado**
  Context API (ou Zustand) para o carrinho: adicionar, remover, atualizar quantidades.
* **Axios Interceptors**

  * Injeta token (para futura autenticação JWT)
  * Tratamento global de erros (exibe Snackbar)
* **React Router v6**
  Rotas nomeadas e lazy loading de páginas.
* **MUI Theme Centralizado**
  Configuração de cores, tipografia e espaçamentos em `styles/theme.js`.
* **Hooks Customizados**

  * `useProducts` — lógica de obtenção de produtos.
  * `useCart` — lógica de carrinho e total.
* **Error Boundary**
  Captura erros de UI e exibe componente de fallback.
* **Lint & Formatação**
  Husky + lint-staged com ESLint & Prettier — qualidade de código garantida antes de cada commit.

---

## 💡 Decisões Técnicas & Boas Práticas

* **MUI**: Consistência visual e acessibilidade (ARIA, foco, responsividade).
* **Camada Única de API**: `services/api.js` facilita troca de baseURL e políticas CORS.
* **State Management Leve**: Evita over-engineering utilizando Context + Reducer.
* **Lazy Loading**: Otimiza bundle inicial e melhora performance.
* **Tipagem**: PropTypes ou migração opcional para TypeScript em componentes.
* **CSS-in-JS**: Estilos dinâmicos e baseados em tema via Emotion.
