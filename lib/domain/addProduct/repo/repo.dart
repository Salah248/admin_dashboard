import 'package:admin_dashboard/core/helper/network/error_handler.dart';
import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/helper/network/network_info.dart';
import 'package:admin_dashboard/data/addProduct/repo/repo.dart';
import 'package:admin_dashboard/data/addProduct/sources/api_services.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class  AddProductRepositoryImpl  extends AddProductRepository {
  @override
  Future<Either<Failure, void>> addProduct({required Map<String, dynamic> data}) async{
if (await di<NetworkInfo>().isConnected) {
      try {
        var result = await di<AddProductService>().addProduct(
          data: data,
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