part of 'products_cubit.dart';

@immutable
sealed class ProductsState {}

final class ProductsInitial extends ProductsState {}

final class ProductsLoading extends ProductsState {}

final class ProductsSuccess extends ProductsState {
  final List<ProductsEntity> products;

  ProductsSuccess(this.products);
}

final class ProductsFailure extends ProductsState {
  final String message;

  ProductsFailure(this.message);
}

final class UploadImageLoading extends ProductsState {}

final class UploadImageSuccess extends ProductsState {
  final String imageUrl;

  UploadImageSuccess(this.imageUrl);
}

final class UploadImageFailure extends ProductsState {
  final String message;

  UploadImageFailure(this.message);
}

final class EditProductLoading extends ProductsState {}

final class EditProductSuccess extends ProductsState {}

final class EditProductFailure extends ProductsState {
  final String message;

  EditProductFailure(this.message);
}

final class CommentsLoading extends ProductsState {}

final class CommentsSuccess extends ProductsState {
  final List<CommentsEntity> comments;

  CommentsSuccess(this.comments);
}

final class CommentsFailure extends ProductsState {
  final String message;

  CommentsFailure(this.message);
}

final class ReplayCommentLoading extends ProductsState {}

final class ReplayCommentSuccess extends ProductsState {}

final class ReplayCommentFailure extends ProductsState {
  final String message;

  ReplayCommentFailure(this.message);
}
final class DeleteProductDataLoading extends ProductsState {}

final class DeleteProductDataSuccess extends ProductsState {}

final class DeleteProductDataFailure extends ProductsState {
  final String message;

  DeleteProductDataFailure(this.message);
}


final class AddProductLoading extends ProductsState {}

final class AddProductSuccess extends ProductsState {}

final class AddProductFailure extends ProductsState {
  final String message;

  AddProductFailure(this.message);
}
