import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/outside_event_usher/outside_event_usher.dart';
import 'package:radar/domain/entities/ushers/Ushers.dart';
import 'package:radar/domain/usecase/ushers/usher_usecase.dart';

part 'usher_state.dart';

class UsherCubit extends Cubit<UsherState> {
  final UsherUsecase usecase;
  UsherCubit(this.usecase) : super(UsherInitial());

  Future<List<Ushers>> getUsher({int? zoneId,bool? isZoneSelected,int?page}) async {
    try {
   //   emit(UsherLoading());
      List<Ushers> result = await usecase.getUshers(zoneId: zoneId,isZoneSelected: isZoneSelected,page:page);
  return result;
     // emit(UsherSuccess(usherList: result));
    } on Exception catch (e) {
      return [];
     /* emit(
        UsherFailure(
          errorMessage: e.toString(),
        ),
      );*/
    }
  }
  Future<List<OutsideEventUsher>> getUsherByEvent({int? eventId,int?page}) async {
    try {
   //   emit(UsherLoading());
      List<OutsideEventUsher> result = await usecase.getUshersByEvent(page:page,eventId: eventId);
  return result;
     // emit(UsherSuccess(usherList: result));
    } on Exception catch (e) {
      return [];
     /* emit(
        UsherFailure(
          errorMessage: e.toString(),
        ),
      );*/
    }
  }
}
