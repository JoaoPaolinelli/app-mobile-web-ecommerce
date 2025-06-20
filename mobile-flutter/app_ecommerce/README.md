## 📱 App Mobile (Flutter)

> **Objetivo:**
> Consumir a API unificada de produtos, permitindo busca, filtro, carrinho e checkout em um app nativo Flutter.


### 🗂 Estrutura de Pastas

/lib
├── core/
│   ├── constants/
│   │   ├── app_colors.dart        # Cores reutilizáveis
│   │   ├── app_text_styles.dart   # TextStyle padrão
│   │   └── app_sizes.dart         # Espaçamentos e tamanhos
│   └── routes/
│       └── app_routes.dart        # Rotas nomeadas
│
├── data/
│   └── api_service.dart           # Cliente HTTP (http ou dio)
│
├── models/
│   ├── product.dart               # ProductModel
│   ├── category.dart              # CategoryModel
│   └── order.dart                 # OrderModel / CreateOrderRequest
│
├── presentation/
│   ├── controllers/
│   │   ├── category_controller.dart
│   │   ├── cart_controller.dart
│   │   └── checkout_controller.dart
│   │
│   ├── pages/
│   │   ├── home_page.dart
│   │   ├── category_page.dart
│   │   ├── cart_page.dart
│   │   ├── checkout_page.dart
│   │   └── profile_page.dart
│   │
│   └── widgets/
│       ├── product_card.dart
│       ├── app_nav_bar.dart
│       └── phone_input_field.dart
│
└── main.dart                      # App entrypoint & ThemeData

### 📦 Dependências (pubspec.yaml)

dependencies:
  flutter:
    sdk: flutter
  get: ^4.6.1
  provider: ^6.0.5
  shared_preferences: ^2.0.15
  font_awesome_flutter: ^10.4.0
  intl_phone_field: ^3.0.1
  mask_text_input_formatter: ^2.3.0
  http: ^0.13.5           # ou dio: ^5.1.1

### ⚙️ Setup & Como Rodar

**Clone o repositório**

git clone https://github.com/seu-usuario/mobile-flutter.git
cd mobile-flutter

**Instale as dependências**

flutter pub get

**Execute o app**

flutter run

Conecte um dispositivo físico ou emulador.

Use `flutter run -d <device_id>` para selecionar um dispositivo específico.

### 🚀 Principais Telas & Fluxo

* **HomePage**

  * Exibe categorias iniciais (chama `/categories`).
  * Utiliza AppNavBar customizado.

* **CategoryPage**

  * Lista os produtos de uma categoria (`/products?category=`).
  * Controlado pelo `CategoryController` (GetX).

* **ProductCard**

  * Widget reutilizável com imagem, nome e preço.

* **CartPage**

  * Gerenciado por `CartController` (GetX) com persistência local.
  * Permite ajustar quantidades e remover itens.

* **CheckoutPage**

  * Formulário controlado por `CheckoutController`.
  * Valida entradas e envia o pedido para `/orders`.

### 💡 Decisões Técnicas & Boas Práticas

* **GetX** para estado e injeção de dependências, mantendo controllers desacoplados da UI.
* **Provider** + **SharedPreferences** para persistir o estado do carrinho entre sessões.
* **Constants** centralizam cores, tamanhos e estilos para consistência visual.
* **Rotas nomeadas** em `app_routes.dart` para evitar strings soltas.

**Separation of Concerns:**

* `api_service.dart` lida com todas as chamadas HTTP.

* **Models** contêm apenas dados puros.

* **Controllers** orquestram a lógica de negócio.

* **Widgets** focam exclusivamente na UI.

* **Validação de Formulários** usando `Form` e `TextFormField` com validadores.

* **Tratamento de Erros** centralizado em snackbars/dialogs.

* **ThemeData** configurado em `main.dart` (ex.: fonte Poppins, esquema de cores).
