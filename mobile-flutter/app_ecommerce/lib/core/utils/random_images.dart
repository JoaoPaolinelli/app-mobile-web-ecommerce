import 'dart:math';

class RandomImage {
  static final _rnd = Random();

  static const List<String> _images = [
    'assets/images/apple.jpg',
    'assets/images/Arraia.png',
    'assets/images/blusa_promo.jpeg',
    'assets/images/brinquedos.jpeg',
    'assets/images/Calça.jpeg',
    'assets/images/Camisa.jpg',
    'assets/images/Camiseta_default.jpg',
    'assets/images/Corrente.jpeg',
    'assets/images/cozinha.jpeg',
    'assets/images/facas.jpeg',
    'assets/images/Halter.jpeg',
    'assets/images/logo.png',
    'assets/images/Macbook.jpg',
    'assets/images/Ombro.jpeg',
    'assets/images/promocao.png',
    'assets/images/PulseiraMasculina.webp',
    'assets/images/Relogio.jpeg',
    'assets/images/Sandalha.jpeg',
    'assets/images/sapato.jpg',
    'assets/images/tempero.jpg',
    'assets/images/vestido.jpeg',
    'assets/images/Whisky.jpg',
  ];

  /// Retorna um caminho de asset aleatório
  static String next() {
    return _images[_rnd.nextInt(_images.length)];
  }
}
