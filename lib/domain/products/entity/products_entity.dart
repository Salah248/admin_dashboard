class ProductsEntity {
  ProductsEntity({
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

}

// Comeents_table 

class CommentsEntity {
    CommentsEntity({
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
    

    factory CommentsEntity.fromJson(Map<String, dynamic> json){ 
        return CommentsEntity(
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