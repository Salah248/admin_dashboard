import 'package:admin_dashboard/constants.dart';
import 'package:admin_dashboard/core/function/shared_pref.dart';
import 'package:admin_dashboard/core/helper/network/dio_clinet.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

abstract class AddProductService {
  Future<Either<String, void>> addProduct({required Map<String, dynamic> data});
}

class AddProductServiceImpl extends AddProductService {
  @override
  Future<Either<String, void>> addProduct({
    required Map<String, dynamic> data,
  }) async {
    final String? token = await SharedPref.getToken();

    try {
      await di<DioClient>().post(
        Constants.productsUrl,
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
