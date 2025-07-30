class Product {
  final String name;
  final String? imageUrl;
  final double price;

  Product({required this.name, this.imageUrl, required this.price});

  factory Product.fromMap(Map<String, dynamic> map) => Product(
    name: map['name'],
    price: (map['price'] as num).toDouble(),
    imageUrl: map['image'],
  );

  Map<String, dynamic> toMap() => {
    'name': name,
    'price': price,
    'image': imageUrl,
  };
}
