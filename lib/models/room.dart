class Room {
  final String typeName;
  final int price; // Harga sudah benar sebagai String
  final String photoPath;
  final int makerID; // Ubah ini menjadi makerId agar sesuai dengan JSON

  Room({
    required this.typeName,
    required   this.price,
    required this.photoPath,
    required this.makerID,
  });

  factory Room.fromJson(Map<String, dynamic> json) {
    return Room(
      typeName: json['type_name'],
      price: json['price'] != null ? int.parse(json['price'])  : 0, // Mengakses langsung field 'price' dan berikan default 0 jika null
      photoPath: json['photo_path'],
      makerID: json['maker_id'],
    );
  }

}
  