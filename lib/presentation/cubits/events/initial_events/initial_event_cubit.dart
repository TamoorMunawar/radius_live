import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/events/initial_event/Initial_event.dart';
import 'package:radar/domain/usecase/event/initial_event/initial_event_usecase.dart';

part 'initial_event_state.dart';

class InitialEventCubit extends Cubit<InitialEventState> {
  final InitialEventUsecase usecase;

  InitialEventCubit(this.usecase) : super(InitialEventInitial());

  void getInitialEvent({int? page}) async {
    try {
      emit(InitialEventLoading());
      List<InitialEvent> result = await usecase.getInitialEvent(page: page);
      emit(
        InitialEventSuccess(initialEvent: result),
      );
    } on Exception catch (e) {
      emit(
        InitialEventFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getFinalEvent({int? page}) async {
    try {
      emit(FinalEventLoading());
      List<InitialEvent> result = await usecase.getFinalEvent(page: page);
      emit(FinalEventSuccess(finalEvent: result));
    } on Exception catch (e) {
      emit(
        FinalEventFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
  Future<List<InitialEvent>> getFinalEventTest({int? page}) async {
    try {
     // emit(FinalEventLoading());
      List<InitialEvent> result = await usecase.getFinalEvent(page: page);
    //  emit(FinalEventSuccess(finalEvent: result));

   return result; } on Exception catch (e) {
   return [];
    }
  }
  Future<List<InitialEvent>> getInitialEventTest({int? page}) async {
    try {
     // emit(FinalEventLoading());
      List<InitialEvent> result = await usecase.getInitialEvent(page: page);
    //  emit(FinalEventSuccess(finalEvent: result));

   return result; } on Exception catch (e) {
   return [];
    }
  }
}
