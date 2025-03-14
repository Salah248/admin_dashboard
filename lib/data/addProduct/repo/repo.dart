import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AddProductRepository {
  Future<Either<Failure, void>> addProduct({
    required Map<String, dynamic> data,
  });
}
