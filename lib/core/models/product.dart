class Product {
  final String id;
  final String name;
  final double price;
  final String imagePath;
  final String? description;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imagePath,
    this.description,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      imagePath: map['imagePath'] as String,
      description: map['description'] as String?, // Handle null description
    );
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toDouble(),
      imagePath: json['image'] as String, // Giả sử API trả về trường 'image'
      description: json['description'] as String?, // Handle null description
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'imagePath': imagePath,
      'description': description,
    };
  }
}