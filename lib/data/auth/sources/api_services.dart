import 'dart:developer';

import 'package:admin_dashboard/constants.dart';
import 'package:admin_dashboard/core/function/shared_pref.dart';
import 'package:admin_dashboard/core/helper/network/dio_clinet.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class AuthService {
  Future<Either<String, void>> login({Map<String, dynamic> data});
}

class AuthServiceImpl extends AuthService {
  final secondaryDioClient = di.get<DioClient>(
    instanceName: 'secondaryDioClient',
  ); // secondaryDioClient instance from di

  @override
  Future<Either<String, void>> login({Map<String, dynamic>? data}) async {
    try {
      final response = await secondaryDioClient.post(
        "${Constants.postLogin}?grant_type=password",
        data: data,
      );

      // Save the token after successful login
      if (response.data != null && response.data['access_token'] != null) {
        await SharedPref.saveToken(response.data['access_token']);
      }
      return const Right(null);
    } on DioException catch (e) {
      if (e.response != null &&
          e.response!.data != null &&
          e.response!.data['msg'] != null) {
        log(e.response!.data['msg']);
        return Left(e.response!.data['msg']);
      } else {
        return const Left("An error occurred");
      }
    }
  }
}
