class Product {
  final String imageUrl;
  final String name;
  final String category;
  final double price;
  final String location;
  final String description;

  Product({
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    required this.location,
    required this.description,
  });
}

class Products {
  String? sId;
  String? productName;
  int? productPrice;
  String? productDescription;
  String? productCategory;
  String? productLocation;
  String? productImage;
  bool? isApproved;
  String? createAt;
  String? updatedAt;
  int? v;

  Products(
      {this.sId,
      this.productName,
      this.productPrice,
      this.productDescription,
      this.productCategory,
      this.productLocation,
      this.productImage,
      this.isApproved,
      this.createAt,
      this.updatedAt,
      this.v});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productDescription = json['productDescription'];
    productCategory = json['productCategory'];
    productLocation = json['productLocation'];
    productImage = json['productImage'];
    isApproved = json['isApproved'];
    createAt = json['createAt'];
    updatedAt = json['updatedAt'];
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['productName'] = productName;
    data['productPrice'] = productPrice;
    data['productDescription'] = productDescription;
    data['productCategory'] = productCategory;
    data['productLocation'] = productLocation;
    data['productImage'] = productImage;
    data['isApproved'] = isApproved;
    data['createAt'] = createAt;
    data['updatedAt'] = updatedAt;
    data['v'] = v;
    return data;
  }
}
