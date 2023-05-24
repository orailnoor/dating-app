class BannerModel {
  String name;
  String image;
  String createdDate;
  String id;
  int v;

  BannerModel({
    required this.name,
    required this.image,
    required this.createdDate,
    required this.id,
    required this.v,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      name: json['name'],
      image: json['image'],
      createdDate: json['created_date'],
      id: json['_id'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'image': image,
      'created_date': createdDate,
      '_id': id,
      '__v': v,
    };
  }
}
