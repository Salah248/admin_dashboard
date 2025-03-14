import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/usecase/base_use_case.dart';
import 'package:admin_dashboard/data/products/repository/repository.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';

class EditProductUseCse
    extends UseCase<Either<Failure, void>, EditProductParames> {
  @override
  Future<Either<Failure, void>> call({EditProductParames? params}) async {
    if (params == null) {
      return Left(Failure(0, "Upload parameters cannot be null"));
    }
    return await di<ProductRepository>().editProduct(
      data: params.data,
      productId: params.productId,
    );
  }
}

class EditProductParames {
  final Map<String, dynamic> data;
  final String productId;

  EditProductParames({required this.data, required this.productId});
}
