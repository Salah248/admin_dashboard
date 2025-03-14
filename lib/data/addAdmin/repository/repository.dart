import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class UserManagementRepository {
  Future<Either<Failure,void>> addAdmin({Map<String,dynamic> data});
}