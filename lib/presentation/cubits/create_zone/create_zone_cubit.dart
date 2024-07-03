import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/usecase/accept_invitation/accept_ivitation_usecase.dart';
import 'package:radar/domain/usecase/create_zone/create_zone_usecase.dart';

part 'create_zone_state.dart';

class CreateZoneCubit extends Cubit<CreateZoneState> {
  final CreateZoneUsecase usecase;
  CreateZoneCubit(this.usecase) : super(CreateZoneInitial());
  void createZone({  int? eventId,
    int? supervisiorId,
    String? location,
    int? jobId,
    String? maleMainSeats,
    String? femaleMainSeats,
    String? malestbySeats,
    String? femalestbySeats,
    String? description,
    String? zoneName,}) async {
    try {
      emit(CreateZoneLoading());
      bool result = await usecase.createZone(    eventId: eventId,
        description: description,
        femaleMainSeats: femaleMainSeats,
        femalestbySeats: femalestbySeats,
        jobId: jobId,
        location: location,
        maleMainSeats: maleMainSeats,
        malestbySeats: malestbySeats,
        supervisiorId: supervisiorId,
        zoneName: zoneName,);
      emit(CreateZoneSuccess(result: result ));
      print("createZone");
    } on Exception catch (e) {
      print("createZone");
      emit(
        CreateZoneFailed(
          errorMessage: e.toString(),
        ),
      );

    }
  }
}
