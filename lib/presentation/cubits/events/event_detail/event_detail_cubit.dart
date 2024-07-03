import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/events/event_detail/Event_detail.dart';
import 'package:radar/domain/usecase/event/event_detail/event_detail_usecase.dart';

part 'event_detail_state.dart';

class EventDetailCubit extends Cubit<EventDetailState> {
  final EventDetailUsecase usecase;
  EventDetailCubit(this.usecase) : super(EventDetailInitial());
  void getEventDetailById({int?eventId,}) async {
    try {
      emit(EventDetailLoading());
   EventDetail result = await usecase.getEventDetailById(eventId: eventId);
      emit(EventDetailSuccess(eventDetail: result ));
    } on Exception catch (e) {
      emit(
        EventDetailFailed(
          errorMessage: e.toString(),
        ),
      );
      throw Exception(
        e.toString().substring(11),
      );
    }
  }

}
