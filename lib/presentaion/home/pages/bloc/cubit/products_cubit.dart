import 'package:admin_dashboard/core/function/shared_pref.dart';
import 'package:admin_dashboard/di.dart';
import 'package:admin_dashboard/domain/addProduct/usecase/add_product_usecase.dart';
import 'package:admin_dashboard/domain/products/entity/products_entity.dart';
import 'package:admin_dashboard/domain/products/usecase/delete_product_usecase.dart';
import 'package:admin_dashboard/domain/products/usecase/edit_product_usecase.dart';
import 'package:admin_dashboard/domain/products/usecase/replay_usecase.dart';
import 'package:admin_dashboard/domain/products/usecase/upload_image_use_case.dart';
import 'package:admin_dashboard/domain/products/usecase/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit() : super(ProductsInitial());

  void getProducts() async {
    emit(ProductsLoading());
    String? token = await SharedPref.getToken();
    final result = await di<GetProductsUseCase>().call(params: token);
    result.fold((error) => emit(ProductsFailure(error.message)), (data) {
      emit(ProductsSuccess(data));
    });
  }

  String? imageUrl; // Add this as a class variable

  void uploadeImage({
    required Uint8List image,
    required String imageName,
    required String bucketName,
  }) async {
    emit(UploadImageLoading());

    final params = UploadImageParams(
      image: image,
      imageName: imageName,
      bucketName: bucketName,
    );

    final result = await di<UploadImageUseCase>().call(params: params);
    result.fold((error) => emit(UploadImageFailure(error.message)), (url) {
      imageUrl = url; // Store the URL
      emit(UploadImageSuccess(url));
    });
  }

  void editProduct({
    required Map<String, dynamic> data,
    required String productId,
  }) async {
    emit(EditProductLoading());
    final params = EditProductParames(data: data, productId: productId);
    final result = await di<EditProductUseCse>().call(params: params);
    result.fold(
      (error) => emit(EditProductFailure(error.message)),
      (_) => emit(EditProductSuccess()),
    );
  }

  void getComments() async {
    emit(CommentsLoading());
    String? token = await SharedPref.getToken();
    final result = await di<GetCommentsDataUseCase>().call(params: token);
    result.fold(
      (err) => emit(CommentsFailure(err.message)),
      (data) => emit(CommentsSuccess(data)),
    );
  }

  void addRepalyComment({
    required Map<String, dynamic> data,
    required String commentId,
    required String productId,
  }) async {
    emit(ReplayCommentLoading());
    final params = ReplayUsecaseParams(
      data: data,
      commentId: commentId,
      productId: productId,
    );
    final result = await di<ReplayUsecase>().call(params: params);
    result.fold(
      (err) => emit(ReplayCommentFailure(err.message)),
      (_) => emit(ReplayCommentSuccess()),
    );
  }

  void deleteProductData({
    required String productId,
    required Map<String, dynamic> data,
  }) async {
    emit(DeleteProductDataLoading());
    DeletProductDateParames params = DeletProductDateParames(
      data: data,
      productId: productId,
    );
    final result = await di<DeletProductDateUseCse>().call(params: params);
    result.fold((err) => emit(DeleteProductDataFailure(err.message)), (_) {
      getProducts();
      emit(DeleteProductDataSuccess());
    });
  }

  void addProduct({required Map<String, dynamic> data}) async {
    emit(AddProductLoading());
    final result = await di<AddProductUseCase>().call(params: data);
    result.fold(
      (error) => emit(AddProductFailure(error.message)),
      (_) => emit(AddProductSuccess()),
    );
  }
}
