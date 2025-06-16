class ProductImageHelper {
  static final Map<String, String> _imageMap = {
    'Camisa Hollister': 'assets/images/product_0.png',
    'Awesome Wooden Fish': 'assets/images/product_1.png',
    'Handcrafted Frozen Sausages': 'assets/images/product_2.png',
    // adicione mais conforme necessário
  };

  static String getImageFor(String productName) {
    return _imageMap[productName] ?? 'assets/images/placeholder.png';
  }
}
