import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/usecase/base_use_case.dart';
import 'package:admin_dashboard/data/products/repository/repository.dart';
import 'package:admin_dashboard/di.dart';
import 'package:admin_dashboard/domain/products/entity/products_entity.dart';
import 'package:dartz/dartz.dart';

class GetProductsUseCase
    extends UseCase<Either<Failure, List<ProductsEntity>>, String> {
  @override
  Future<Either<Failure, List<ProductsEntity>>> call({String? params}) async {
    return await di<ProductRepository>().getProducts(params!);
  }
}

class GetCommentsDataUseCase extends UseCase<Either<Failure, List<CommentsEntity>>, String> {
  @override
  Future<Either<Failure, List<CommentsEntity>>> call({ String? params}) async {
    return await di<ProductRepository>().getCommetntsData(params!);
  }
}
