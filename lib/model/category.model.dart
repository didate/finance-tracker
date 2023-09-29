// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Category {
  String? id;
  String libelle;
  int version;
  Category({
    this.id,
    required this.libelle,
    required this.version,
  });

  Category copyWith({
    String? id,
    String? libelle,
    int? version,
  }) {
    return Category(
      id: id ?? this.id,
      libelle: libelle ?? this.libelle,
      version: version ?? this.version,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'libelle': libelle,
      'version': version,
    };
  }

  Map<String, dynamic> toMapWithoutId() {
    return <String, dynamic>{
      'libelle': libelle,
      'version': version,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as String : null,
      libelle: map['libelle'] as String,
      version: map['version'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Category(id: $id, libelle: $libelle, version: $version)';

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.libelle == libelle &&
        other.version == version;
  }

  @override
  int get hashCode => id.hashCode ^ libelle.hashCode ^ version.hashCode;
}
