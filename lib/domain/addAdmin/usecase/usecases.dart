import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/usecase/base_use_case.dart';
import 'package:admin_dashboard/data/addAdmin/repository/repository.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';

class AddAdminUseCase extends UseCase<Either<Failure, void>, dynamic> {
  @override
  Future<Either<Failure, void>> call({params}) async {
    return await di<UserManagementRepository>().addAdmin(data: params);
  }
}
