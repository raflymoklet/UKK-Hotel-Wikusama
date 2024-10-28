class Room {
  final String typeName;
  final int price; // Harga sudah benar sebagai String
  final String photoPath;

  Room({
    required this.typeName,
    required this.price,
    required this.photoPath,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      typeName: json['type_name'],
      price: json['price'] != null
          ? int.parse(json['price'].toString())
          : 0, // Mengakses langsung field 'price' dan berikan default 0 jika null
      photoPath: json['photo_name'],
    );
  }
}
