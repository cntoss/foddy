class ProductModel {
  ProductModel(
      {this.id,
      this.name,
      this.price,
      this.currency,
      this.ownerId,
      this.createAt,
      this.validTill,
      this.imageUrl,
      this.description,
      this.location,
      this.restaurantName});

  String? id;
  String? name;
  String? price;
  String? currency;
  String? ownerId;
  DateTime? createAt;
  DateTime? validTill;
  String? imageUrl;
  String? description;
  String? location;
  String? restaurantName;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json["name"],
      price: json["price"],
      currency: json["currency"],
      ownerId: json["ownerId"],
      createAt:
          json["createAt"] == null ? null : DateTime.parse(json["createAt"]),
      validTill:
          json["validTill"] == null ? null : DateTime.parse(json["validTill"]),
      imageUrl: json["imageUrl"],
      description: json["description"],
      location: json["location"],
      restaurantName: json["restaurantName"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "price": price,
        "currency": currency,
        "ownerId": ownerId,
        "createAt": createAt == null ? null : createAt!.toIso8601String(),
        "validTill": validTill == null ? null : validTill!.toIso8601String(),
        "imageUrl": imageUrl,
        "description": description,
        "location": location,
        "restaurantName": restaurantName
      };

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProductModel && other.id == id && other.name == null;
  }

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}
