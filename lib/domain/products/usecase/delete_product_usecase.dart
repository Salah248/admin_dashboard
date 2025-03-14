import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/usecase/base_use_case.dart';
import 'package:admin_dashboard/data/products/repository/repository.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';

class DeletProductDateUseCse
    extends UseCase<Either<Failure, void>, DeletProductDateParames> {
  @override
  Future<Either<Failure, void>> call({DeletProductDateParames? params}) async {
    if (params == null) {
      return Left(Failure(0, "Upload parameters cannot be null"));
    }
    return await di<ProductRepository>().deleteProductData(
      data: params.data,
      productId: params.productId,
    );
  }
}

class DeletProductDateParames {
  final Map<String, dynamic> data;
  final String productId;

  DeletProductDateParames({required this.data, required this.productId});
}
