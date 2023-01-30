class UserModel {
  UserModel({
    this.id,
    this.userDisplayName,
    this.phone,
    this.address,
    this.profileUrl,
  });

  String? id;
  String? userDisplayName;
  String? phone;
  String? address;
  String? profileUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        userDisplayName: json["userDisplayName"],
        phone: json["phone"],
        address: json['address'],
        profileUrl: json["profileUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "userDisplayName": userDisplayName,
        "phone": phone,
        'address': address,
        "profileUrl": profileUrl,
      };
}
