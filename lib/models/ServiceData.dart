class ServiceData {
  final int id;
  final String name;
  final String description;
  final int price;
  final int days;

  ServiceData({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.days,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'days': days,
    };
  }

  // get class object from map
  static ServiceData fromMap(Map<dynamic, dynamic> map) {
    return ServiceData(
      id: map['id'] as int,
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as int,
      days: map['days'] as int,
    );
  }
}