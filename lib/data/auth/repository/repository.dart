import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure,void>> login({Map<String,dynamic> data});
}