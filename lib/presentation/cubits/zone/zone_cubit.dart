import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/domain/entities/zone/Zone.dart';
import 'package:radar/domain/usecase/supervisor/supervisior_usecase.dart';
import 'package:radar/domain/usecase/zone/zone_usecase.dart';

part 'zone_state.dart';

class ZoneCubit extends Cubit<ZoneState> {
  final ZoneUsecase usecase;

  ZoneCubit(this.usecase) : super(ZoneInitial());

  void getZone({int? eventId}) async {
    try {
      emit(ZoneLoading());
      List<Zone> result = await usecase.getZone(eventId: eventId);
      emit(ZoneSuccess(result: result));
    } on Exception catch (e) {
      emit(
        ZoneFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void getZoneByUserId({int? eventId, bool? isAddElement}) async {
    try {
      emit(ZoneLoading());
      List<Zone> result = await usecase.getZoneByUserId(eventId: eventId);
      if (result.isNotEmpty) {
        if (isAddElement ?? false) {
          result.insert(
              0,
              Zone(
                id: 0,
                categoryName: "All",suppervisor: ""
              ));
        }
      }
      emit(ZoneSuccess(result: result));
    } on Exception catch (e) {
      emit(
        ZoneFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
