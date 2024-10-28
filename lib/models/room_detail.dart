class RoomDetail {
  final int typeId;
  final String typeName;
  final int price;
  final String desc;
  final String photoPath;

  RoomDetail({
    required this.typeId,
    required this.typeName,
    required this.price,
    required this.desc,
    required this.photoPath,
  });

  factory RoomDetail.fromJson(Map<String, dynamic> json) {
    return RoomDetail(
      typeId: json['type_id'],
      typeName: json['type_name'],
      price: json['price'],
      desc: json['desc'],
      photoPath: json['photo_path'],
    );
  }
}