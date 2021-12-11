import 'dart:convert';

class OrderModel {
  final String id;
  final String name;
  final double price;
  final String date;
  final String userId;

  OrderModel({
    required this.userId,
    required this.id,
    required this.name,
    required this.price,
    required this.date,
  });

  OrderModel copyWith({
    String? id,
    String? name,
    double? price,
    String? date,
  }) {
    return OrderModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      date: date ?? this.date,
      userId: userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'date': date,
      'userId': userId,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      date: map['date'] ?? '',
      userId: map['userId'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'OrderModel(id: $id, name: $name, price: $price, date: $date, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is OrderModel &&
        other.id == id &&
        other.name == name &&
        other.price == price &&
        other.date == date &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        price.hashCode ^
        date.hashCode ^
        userId.hashCode;
  }
}
