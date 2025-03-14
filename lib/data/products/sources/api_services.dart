import 'dart:developer';

import 'package:admin_dashboard/constants.dart';
import 'package:admin_dashboard/core/function/shared_pref.dart';
import 'package:admin_dashboard/core/helper/network/dio_clinet.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class ProductService {
  Future<Either<String, dynamic>> getProducts(String token);
  Future<Either<String, String>> uploadeImage({
    required Uint8List image,
    required String imageName,
    required String bucketName,
  });
  Future<Either<String, void>> editProduct({
    required Map<String, dynamic> data,
    required String productId,
  });
  Future<Either<String, dynamic>> getCommetntsData(String token);
  Future<Either<String, void>> addRepaly({
    required Map<String, dynamic> data,
    required String commentId,
    required String productId,
  });

  Future<Either<String, void>> deleteProductData({
    required Map<String, dynamic> data,
    required String productId,
  });
}

class ProductsServiceImpl extends ProductService {
  @override
  Future<Either<String, dynamic>> getProducts(String token) async {
    try {
      var response = await di<DioClient>().get(
        Constants.productsUrl,
        options: Options(headers: {'Authorization': "Bearer $token"}),
      );
      return Right(response.data);
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        log(e.response!.data['message']);
        return Left(e.response!.data['message']);
      } else {
        return const Left("An error occurred");
      }
    }
  }

  @override
  Future<Either<String, String>> uploadeImage({
    required Uint8List image,
    required String imageName,
    required String bucketName,
  }) async {
    final thirdDioClient = di.get<DioClient>(instanceName: 'thirdDioClient');
    final String? token = await SharedPref.getToken();

    FormData formData = FormData.fromMap({
      "file": MultipartFile.fromBytes(image, filename: imageName),
    });
    try {
      var response = await thirdDioClient.post(
        "${Constants.baseUrlStorage}/$bucketName/$imageName",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            "Content-Type": "multipart/form-data",
          },
        ),
        data: formData,
      );
      final String imageUrl =
          "${Constants.baseUrlStorage}/public/${response.data['Key']}";
      if (kDebugMode) {
        print(imageUrl);
      }

      return Right(imageUrl); // Return the URL directly
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        if (kDebugMode) {
          print(e.response!.data['message']);
        }
        return Left(e.response!.data['message']);
      } else {
        return const Left("An error occurred");
      }
    }
  }

  @override
  Future<Either<String, void>> editProduct({
    required Map<String, dynamic> data,
    required String productId,
  }) async {
    final String? token = await SharedPref.getToken();

    try {
      await di<DioClient>().patch(
        "${Constants.productsUrl}?product_id=eq.$productId",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return const Right(null);
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        if (kDebugMode) {
          print(e.response!.data['message']);
        }
        return Left(e.response!.data['message']);
      } else {
        return const Left("An error occurred");
      }
    }
  }

  @override
  Future<Either<String, dynamic>> getCommetntsData(String token) async {
    try {
      var response = await di<DioClient>().get(
        "${Constants.commentsUrl}?order=created_at",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return Right(response.data);
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        if (kDebugMode) {
          print(e.response!.data['message']);
        }
        return Left(e.response!.data['message']);
      } else {
        return const Left("An error occurred");
      }
    }
  }

  @override
  Future<Either<String, void>> addRepaly({
    required Map<String, dynamic> data,
    required String commentId,
    required String productId,
  }) async {
    final String? token = await SharedPref.getToken();
    try {
      await di<DioClient>().patch(
        "${Constants.commentsUrl}?id=eq.$commentId&for_product=eq.$productId",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return const Right(null);
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        if (kDebugMode) {
          print(e.response!.data['message']);
        }
        return Left(e.response!.data['message']);
      } else {
        return const Left("An error occurred");
      }
    }
  }

  @override
  Future<Either<String, void>> deleteProductData({
    required Map<String, dynamic> data,
    required String productId,
  }) async {
    final String? token = await SharedPref.getToken();

    try {
      // related tables: comments, favorite, purchase, rates
      await di<DioClient>().delete(
        "${Constants.commentsUrl}?for_product=eq.$productId",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      await di<DioClient>().delete(
        "${Constants.favoriteUrl}?for_product=eq.$productId",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      await di<DioClient>().delete(
        "${Constants.purchaseUrl}?for_product=eq.$productId",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      await di<DioClient>().delete(
        "${Constants.ratesUrl}?for_product=eq.$productId",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      // delete product
      await di<DioClient>().delete(
        "${Constants.productsUrl}?product_id=eq.$productId",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return const Right(null);
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['message'] != null) {
        if (kDebugMode) {
          print(e.response!.data['message']);
        }
        return Left(e.response!.data['message']);
      } else {
        return const Left("An error occurred");
      }
    }
  }
}
