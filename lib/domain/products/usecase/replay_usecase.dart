import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/usecase/base_use_case.dart';
import 'package:admin_dashboard/data/products/repository/repository.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';

class ReplayUsecase
    extends UseCase<Either<Failure, void>, ReplayUsecaseParams> {
  @override
  Future<Either<Failure, void>> call({ReplayUsecaseParams? params}) async {
    if (params == null) {
      return Left(Failure(0, 'params is null'));
    }
    return await di<ProductRepository>().addReply(
      data: params.data,
      commentId: params.commentId,
      productId: params.productId,
    );
  }
}

class ReplayUsecaseParams {
  final Map<String, dynamic> data;
  final String commentId;
  final String productId;
  ReplayUsecaseParams({
    required this.data,
    required this.commentId,
    required this.productId,
  });
}
