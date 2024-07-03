import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/usecase/zone_seats/zone_seats_usecase.dart';

part 'zone_seats_state.dart';

class ZoneSeatsCubit extends Cubit<ZoneSeatsState> {
  final ZoneSeatsUsecase usecase;
  ZoneSeatsCubit(this.usecase) : super(ZoneSeatsInitial());
  void zoneSeats({int? zoneId}) async {
    try {
      emit(ZoneSeatsLoading());
      bool? result = await usecase.zoneSeats(zoneId: zoneId);
      emit(ZoneSeatsSuccess(result: result));
    } on Exception catch (e) {
      emit(
        ZoneSeatsFailed(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
