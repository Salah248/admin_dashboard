import 'package:admin_dashboard/di.dart';
import 'package:admin_dashboard/domain/addAdmin/usecase/usecases.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_admin_state.dart';

class AddAdminCubit extends Cubit<AddAdminState> {
  AddAdminCubit() : super(AddAdminInitial());

  void addAdmin({Map<String, dynamic>? data}) async {
    emit(AddAdminLoading());
    final result = await di<AddAdminUseCase>().call(params: data);
    result.fold(
      (error) {
        emit(AddAdminFailure(error.message));
      },
      (_) {
        emit(AddAdminSuccess());
      },
    );
  }
}
