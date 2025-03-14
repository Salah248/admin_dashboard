
import 'package:admin_dashboard/core/helper/network/failure.dart';
import 'package:admin_dashboard/core/usecase/base_use_case.dart';
import 'package:admin_dashboard/data/products/repository/repository.dart';
import 'package:admin_dashboard/di.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

class UploadImageUseCase extends UseCase<Either<Failure, String>, UploadImageParams> {
  @override
  Future<Either<Failure, String>> call({UploadImageParams? params}) async {
    if (params == null) {
      return Left(Failure(0, "Upload parameters cannot be null"));
    }
    
    return await di<ProductRepository>().uploadeImage(
      bucketName: params.bucketName,
      image: params.image,
      imageName: params.imageName,
    );
  }
}

class UploadImageParams {
  final Uint8List image;
  final String imageName;
  final String bucketName;

  UploadImageParams({
    required this.image,
    required this.imageName,
    required this.bucketName,
  });
}