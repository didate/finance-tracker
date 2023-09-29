// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Solde {
  String nature;
  int amount;
  Solde({
    required this.nature,
    required this.amount,
  });

  Solde copyWith({
    String? nature,
    int? amount,
  }) {
    return Solde(
      nature: nature ?? this.nature,
      amount: amount ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nature': nature,
      'amount': amount,
    };
  }

  factory Solde.fromMap(Map<String, dynamic> map) {
    return Solde(
      nature: map['nature'] as String,
      amount: map['amount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Solde.fromJson(String source) =>
      Solde.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Solde(nature: $nature, amount: $amount)';

  @override
  bool operator ==(covariant Solde other) {
    if (identical(this, other)) return true;

    return other.nature == nature && other.amount == amount;
  }

  @override
  int get hashCode => nature.hashCode ^ amount.hashCode;
}
