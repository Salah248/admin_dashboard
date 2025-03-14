import 'package:admin_dashboard/data/products/model/products_model.dart';
import 'package:admin_dashboard/domain/products/entity/products_entity.dart';

class ProductsMapper {
  static ProductsEntity toEntity(ProductsModel model) {
    return ProductsEntity(
      productId: model.productId,
      createdAt: model.createdAt,
      productName: model.productName,
      price: model.price,
      oldPrice: model.oldPrice,
      sale: model.sale,
      description: model.description,
      category: model.category,
      imageUrl: model.imageUrl,
    );
  }
}


// Comments_table

class CommentsMapper {
  static CommentsEntity toEntity(CommentsModel comment) {
    return CommentsEntity(
      id: comment.id,
      createdAt: comment.createdAt,
      comment: comment.comment,
      forUser: comment.forUser,
      forProduct: comment.forProduct,
      userName: comment.userName,
      replay: comment.replay,
    );
  }
}