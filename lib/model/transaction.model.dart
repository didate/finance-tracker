// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Transaction {
  String? id;
  DateTime? createdAt;
  int amount;
  String nature;
  String? description;
  int version;
  String? categoryId;
  String? category;

  Transaction({
    this.id,
    this.createdAt,
    required this.amount,
    required this.nature,
    this.description,
    required this.version,
    this.categoryId,
    this.category,
  });

  Transaction copyWith({
    String? id,
    DateTime? createdAt,
    int? amount,
    String? nature,
    String? description,
    int? version,
    String? categoryId,
    String? category,
  }) {
    return Transaction(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      amount: amount ?? this.amount,
      nature: nature ?? this.nature,
      description: description ?? this.description,
      version: version ?? this.version,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'created_at': createdAt?.millisecondsSinceEpoch,
      'amount': amount,
      'nature': nature,
      'description': description,
      'version': version,
      'category_id': categoryId,
      'category': category,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return <String, dynamic>{
      'amount': amount,
      'nature': nature,
      'description': description,
      'version': version,
      'category_id': categoryId,
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] != null ? map['id'] as String : null,
      createdAt:
          map['created_at'] != null ? DateTime.parse(map['created_at']) : null,
      amount: map['amount'] as int,
      nature: map['nature'] as String,
      description:
          map['description'] != null ? map['description'] as String : null,
      version: map['version'] as int,
      categoryId:
          map['category_id'] != null ? map['category_id'] as String : null,
      category: map['category'] != null ? map['category'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(id: $id, createdAt: $createdAt, amount: $amount, nature: $nature, description: $description, version: $version, categoryId: $categoryId, category: $category)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.createdAt == createdAt &&
        other.amount == amount &&
        other.nature == nature &&
        other.description == description &&
        other.version == version &&
        other.categoryId == categoryId &&
        other.category == category;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        createdAt.hashCode ^
        amount.hashCode ^
        nature.hashCode ^
        description.hashCode ^
        version.hashCode ^
        categoryId.hashCode ^
        category.hashCode;
  }
}
