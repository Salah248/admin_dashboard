import 'package:admin_dashboard/di.dart';
import 'package:admin_dashboard/domain/auth/usecase/usecase.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  void login({Map<String, dynamic>? data}) async {
    emit(AuthLoading());
    final result = await di<AuthUseCase>().call(params: data);
    result.fold((error) => emit(AuthFailure(error.message)), (_) {
      emit(AuthSuccess());
    },);
  }
}
