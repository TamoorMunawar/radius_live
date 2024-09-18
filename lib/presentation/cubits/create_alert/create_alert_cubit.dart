import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/usecase/create_alert/create_alert_usecase.dart';

part 'create_alert_state.dart';

class CreateAlertCubit extends Cubit<CreateAlertState> {
  CreateAlertCubit(this.usecase) : super(CreateAlertInitial());
  final CreateAlertUsecase usecase;
  void createAlert({
    // String? heading,
    // String? to,
    // String? departmentId,
    // String? description,
    int? eventId,
    String? type,
    String? message,
  }) async {
    try {
      emit(CreateAlertLoading());
      bool result = await usecase.createAlert(
        // description: description,
        // departmentId: departmentId,
        // heading: heading,
        // to: to,
        eventId: eventId,
        type:type ,
        message: message,
      );
      emit(CreateAlertSuccess(result: result));
    } on Exception catch (e) {
      emit(
        CreateAlertFailure(
          errorMessage: e.toString(),
        ),
      );
      throw Exception(
        e.toString().substring(11),
      );
    }
  }
}
