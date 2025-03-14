part of 'add_admin_cubit.dart';

@immutable
sealed class AddAdminState {}

final class AddAdminInitial extends AddAdminState {}

final class AddAdminLoading extends AddAdminState {}

final class AddAdminSuccess extends AddAdminState {}

final class AddAdminFailure extends AddAdminState {
  final String errMessage;

  AddAdminFailure(this.errMessage);
}
