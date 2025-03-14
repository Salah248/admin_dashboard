import 'dart:developer';

import 'package:admin_dashboard/core/helper/network/error_handler.dart';
import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/helper/network/network_info.dart';
import 'package:admin_dashboard/data/auth/repository/repository.dart';
import 'package:admin_dashboard/data/auth/sources/api_services.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either<Failure, void>> login({Map<String, dynamic>? data}) async {
    if (await di<NetworkInfo>().isConnected) {
      try {
        var result = await di<AuthService>().login(data: data!);
        return result.fold(
          (error) => Left(Failure(0, error)),
          (_) {
            return const Right(null);
          }, // إرجاع Right(null) لأن النوع المتوقع هو void
        );
      } catch (e) {
        log(e.toString());
        return Left(ErrorHandler.handle(e).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
