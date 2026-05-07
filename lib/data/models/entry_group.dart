class EntryGroupModel {
  final String id;
  final String name;
  final String iconType; // "emoji" | "material"
  final String iconValue;
  final String createdAt;

  const EntryGroupModel({
    required this.id,
    required this.name,
    required this.iconType,
    required this.iconValue,
    required this.createdAt,
  });

  EntryGroupModel copyWith({
    String? id,
    String? name,
    String? iconType,
    String? iconValue,
    String? createdAt,
  }) {
    return EntryGroupModel(
      id: id ?? this.id,
      name: name ?? this.name,
      iconType: iconType ?? this.iconType,
      iconValue: iconValue ?? this.iconValue,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'iconType': iconType,
      'iconValue': iconValue,
      'createdAt': createdAt,
    };
  }

  factory EntryGroupModel.fromMap(Map<String, dynamic> map) {
    return EntryGroupModel(
      id: map['id'] as String,
      name: map['name'] as String,
      iconType: map['iconType'] as String,
      iconValue: map['iconValue'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
