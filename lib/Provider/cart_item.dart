class CartItem {
  final String id;
  final String name;
  final int price;
  int quantity;
  final String size;
  final String iceLevel;
  final String syrup;
  final String imagePath;
  final String description;

  CartItem({
    required this.id,
    required this.name,
    required this.price,
    required this.quantity,
    required this.size,
    required this.iceLevel,
    required this.syrup,
    required this.imagePath,
    required this.description,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      quantity: map['quantity'],
      size: map['size'],
      iceLevel: map['iceLevel'],
      syrup: map['syrup'],
      imagePath: map['imagePath'],
      description: map['description'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'quantity': quantity,
      'size': size,
      'iceLevel': iceLevel,
      'syrup': syrup,
      'imagePath': imagePath,
      'description': description,
    };
  }

  void increaseQuantity() {
    quantity++;
  }

  void decreaseQuantity() {
    if (quantity > 1) {
      quantity--;
    }
  }
}
