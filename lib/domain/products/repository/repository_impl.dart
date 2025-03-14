import 'dart:developer';

import 'package:admin_dashboard/core/helper/network/error_handler.dart';
import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/helper/network/network_info.dart';
import 'package:admin_dashboard/data/products/model/products_model.dart';
import 'package:admin_dashboard/data/products/repository/repository.dart';
import 'package:admin_dashboard/data/products/sources/api_services.dart';
import 'package:admin_dashboard/di.dart';
import 'package:admin_dashboard/domain/products/entity/products_entity.dart';
import 'package:admin_dashboard/domain/products/mapper/products_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class ProductRepositoryImpl extends ProductRepository {
  @override
  Future<Either<Failure, List<ProductsEntity>>> getProducts(
    String token,
  ) async {
    if (await di<NetworkInfo>().isConnected) {
      try {
        var result = await di<ProductService>().getProducts(token);
        return result.fold((error) => Left(Failure(0, error)), (data) {
          // تأكد من أن البيانات قائمة
          if (data is List) {
            var products =
                data
                    .map(
                      (item) =>
                          ProductsMapper.toEntity(ProductsModel.fromJson(item)),
                    )
                    .toList();
            return Right(products);
          } else {
            return Left(Failure(0, "Invalid data format"));
          }
        });
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadeImage({
    required Uint8List image,
    required String imageName,
    required String bucketName,
  }) async {
    if (await di<NetworkInfo>().isConnected) {
      try {
        var result = await di<ProductService>().uploadeImage(
          bucketName: bucketName,
          imageName: imageName,
          image: image,
        );

        return result.fold(
          (error) => Left(Failure(0, error)),
          (imageUrl) => Right(imageUrl), // Pass the URL forward
        );
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> editProduct({
    required Map<String, dynamic> data,
    required String productId,
  }) async {
    if (await di<NetworkInfo>().isConnected) {
      try {
        var result = await di<ProductService>().editProduct(
          data: data,
          productId: productId,
        );
        return result.fold(
          (error) => Left(Failure(0, error)),
          (_) => const Right((null)),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CommentsEntity>>> getCommetntsData(
    String token,
  ) async {
    if (await di<NetworkInfo>().isConnected) {
      try {
        var result = await di<ProductService>().getCommetntsData(token);
        return result.fold((error) => Left(Failure(0, error)), (data) {
          // تأكد من أن البيانات قائمة
          if (data is List) {
            var comments =
                data
                    .map(
                      (item) =>
                          CommentsMapper.toEntity(CommentsModel.fromJson(item)),
                    )
                    .toList();
            return Right(comments);
          } else {
            return Left(Failure(0, "Invalid data format"));
          }
        });
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addReply({
    required Map<String, dynamic> data,
    required String commentId,
    required String productId,
  }) async {
    if (await di<NetworkInfo>().isConnected) {
      try {
        var result = await di<ProductService>().addRepaly(
          data: data,
          commentId: commentId,
          productId: productId,
        );
        return result.fold(
          (error) => Left(Failure(0, error)),
          (_) => const Right((null)),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteProductData({
    required Map<String, dynamic> data,
    required String productId,
  }) async {
    if (await di<NetworkInfo>().isConnected) {
      try {
        var result = await di<ProductService>().deleteProductData(
          data: data,
          productId: productId,
        );
        return result.fold(
          (error) => Left(Failure(0, error)),
          (_) => const Right((null)),
        );
      } catch (e) {
        if (kDebugMode) {
          print(e.toString());
        }
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
