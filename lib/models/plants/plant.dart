class Plant {
  int? id;
  int? categoryId;
  String? imageUrl;
  String? name;
  double? rating;
  int? displaySize;
  List<int>? availableSize;
  String? unit;
  String? price;
  String? priceUnit;
  String? description;

  Plant({
    this.id,
    this.categoryId,
    this.imageUrl,
    this.name,
    this.rating,
    this.displaySize,
    this.availableSize,
    this.unit,
    this.price,
    this.priceUnit,
    this.description,
  });

  factory Plant.fromJson(Map<String, dynamic> json) => Plant(
        id: json["id"],
        categoryId: json["category_id"],
        imageUrl: json["image_url"],
        name: json["name"],
        rating: json["rating"] != null
            ? double.parse(json["rating"].toString())
            : null,
        displaySize: json["display_size"],
        availableSize: List<int>.from(json["available_size"].map((x) => x)),
        unit: json["unit"],
        price: json["price"],
        priceUnit: json["price_unit"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "image_url": imageUrl,
        "name": name,
        "rating": rating,
        "display_size": displaySize,
        "available_size":
            List<dynamic>.from((availableSize ?? []).map((x) => x)),
        "unit": unit,
        "price": price,
        "price_unit": priceUnit,
        "description": description,
      };
}
