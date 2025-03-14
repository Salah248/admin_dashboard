class ProductsModel {
  ProductsModel({
    required this.productId,
    required this.createdAt,
    required this.productName,
    required this.price,
    required this.oldPrice,
    required this.sale,
    required this.description,
    required this.category,
    required this.imageUrl,
  });

  final String? productId;
  final DateTime? createdAt;
  final String? productName;
  final String? price;
  final String? oldPrice;
  final String? sale;
  final String? description;
  final String? category;
  final String? imageUrl;

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    return ProductsModel(
      productId: json["product_id"],
      createdAt: DateTime.tryParse(json["created_at"] ?? ""),
      productName: json["product_name"],
      price: json["price"],
      oldPrice: json["old_price"],
      sale: json["sale"],
      description: json["description"],
      category: json["category"],
      imageUrl: json["image_url"],
    );
  }
}

class CommentsModel {
    CommentsModel({
        required this.id,
        required this.createdAt,
        required this.comment,
        required this.forUser,
        required this.forProduct,
        required this.userName,
        required this.replay,
    });

    final String? id;
    final DateTime? createdAt;
    final String? comment;
    final String? forUser;
    final String? forProduct;
    final dynamic userName;
    final dynamic replay;

    factory CommentsModel.fromJson(Map<String, dynamic> json){ 
        return CommentsModel(
            id: json["id"],
            createdAt: DateTime.tryParse(json['created_at']),
            comment: json["comment"],
            forUser: json["for_user"],
            forProduct: json["for_product"],
            userName: json["user_name"],
            replay: json["replay"],
        );
    }

}