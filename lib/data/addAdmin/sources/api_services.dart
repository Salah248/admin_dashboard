import 'dart:developer';

import 'package:admin_dashboard/constants.dart';
import 'package:admin_dashboard/core/helper/network/dio_clinet.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

abstract class UserManagementService {
  Future<Either<String, void>> addAdmin({Map<String, dynamic> data});
}

class UserManagementServiceImpl extends UserManagementService {
  final secondaryDioClient = di.get<DioClient>(
    instanceName: 'secondaryDioClient',
  ); // secondaryDioClient instance from di

  @override
  Future<Either<String, void>> addAdmin({Map<String, dynamic>? data}) async {
    try {
      await secondaryDioClient.post(Constants.postSignUp, data: data);
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
