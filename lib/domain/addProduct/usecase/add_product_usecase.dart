import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/usecase/base_use_case.dart';
import 'package:admin_dashboard/data/addProduct/repo/repo.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';

class AddProductUseCase
    extends UseCase<Either<Failure, void>, Map<String, dynamic>> {
  @override
  Future<Either<Failure, void>> call({Map<String, dynamic>? params}) async {
    return await di<AddProductRepository>().addProduct(data: params!);
  }
}
