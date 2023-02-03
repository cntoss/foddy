class UserModel {
  UserModel(
      {this.id,
      this.userDisplayName,
      this.phone,
      this.address,
      this.profileUrl,
      this.carts,
      this.orders});

  String? id;
  String? userDisplayName;
  String? phone;
  String? address;
  String? profileUrl;
  List<String>? carts;
  List<String>? orders;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id: json["id"],
      userDisplayName: json["userDisplayName"],
      phone: json["phone"],
      address: json['address'],
      profileUrl: json["profileUrl"],
      carts: json["carts"] == null
          ? null
          : List<String>.from(json["carts"].map((x) => x)),
      orders: json["orders"] == null
          ? null
          : List<String>.from(json["orders"].map((x) => x)));

  Map<String, dynamic> toJson() => {
        "id": id,
        "userDisplayName": userDisplayName,
        "phone": phone,
        'address': address,
        "profileUrl": profileUrl,
        "carts": carts,
        "orders": orders
      };
}
