import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/domain/products/entity/products_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

abstract class ProductRepository {
  Future<Either<Failure, List<ProductsEntity>>> getProducts(String token);

  Future<Either<Failure, List<CommentsEntity>>> getCommetntsData(String token);

  Future<Either<Failure, String>> uploadeImage({
    required Uint8List image,
    required String imageName,
    required String bucketName,
  });
  Future<Either<Failure, void>> editProduct({
    required Map<String, dynamic> data,
    required String productId,
  });
  Future<Either<Failure, void>> addReply({
    required Map<String, dynamic> data,
    required String commentId,
    required String productId,
  });

  Future<Either<Failure, void>> deleteProductData({
    required Map<String, dynamic> data,
    required String productId,
  });
}
