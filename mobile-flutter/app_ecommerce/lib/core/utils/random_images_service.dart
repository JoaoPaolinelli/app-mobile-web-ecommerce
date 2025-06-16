// random_image_service.dart
class RandomImageService {
  static final List<String> _images = [
    'assets/images/apple.jpg',
    'assets/images/Arraia.png',
    'assets/images/Banner.png',
    'assets/images/blusa_promo.jpeg',
    'assets/images/brinquedos.jpeg',
    'assets/images/Calça_feminina_default.jpeg',
    'assets/images/Calça.jpeg',
    'assets/images/Camisa.jpg',
    'assets/images/Camiseta_default.jpg',
    'assets/images/Compras.jpg',
    'assets/images/Corrente.jpeg',
    'assets/images/cozinha.jpeg',
    'assets/images/Esteira.jpeg',
    'assets/images/facas.jpeg',
    'assets/images/Halter.jpeg',
    'assets/images/Logo_old.png',
    'assets/images/logo.png',
    'assets/images/Macbook.jpg',
    'assets/images/Ombro.jpeg',
    'assets/images/Promo.png',
    'assets/images/promocao.png',
    'assets/images/PulseiraMasculina.webp',
    'assets/images/Relogio.jpeg',
    'assets/images/Relogio.webp',
    'assets/images/Sandalha.jpeg',
    'assets/images/sapato.jpg',
    'assets/images/tempero.jpg',
    'assets/images/vestido.jpeg',
    'assets/images/Whisky.jpg',
  ];

  static final Map<String, String> _cache = {};

  /// Retorna uma imagem aleatória persistente para um produto
  static String getImageFor(String productName) {
    if (_cache.containsKey(productName)) {
      return _cache[productName]!;
    }
    _images.shuffle();
    _cache[productName] = _images.first;
    return _cache[productName]!;
  }
}
