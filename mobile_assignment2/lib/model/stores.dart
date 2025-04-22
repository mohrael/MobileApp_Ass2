class Store {
  final String id;
  final String name;
  final String address;
  final int isFavorite;

  Store(
      {required this.id,
      required this.isFavorite,
      required this.name,
      required this.address});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'isFavorite': isFavorite,
    };
  }

  factory Store.fromMap(Map<String, dynamic> map) {
    return Store(
        id: map['id'],
        name: map['name'],
        address: map['address'],
        isFavorite: map['isFavorite']);
  }
}
