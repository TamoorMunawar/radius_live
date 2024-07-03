import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/attandance/Attandance.dart';
import 'package:radar/domain/entities/dashboard_attandace_data/Dashboard_attandace_data.dart';
import 'package:radar/domain/entities/lastest_event/latest_event_model.dart';
import 'package:radar/domain/usecase/attandance_usecase.dart';

part 'attandance_state.dart';

class AttandanceCubit extends Cubit<AttandanceState> {
  final AttandanceUsecase usecase;

  AttandanceCubit(this.usecase) : super(AttandanceInitial());

  void getAttandance() async {
    try {
      emit(AttandanceLoading());
      List<Attandance> result = await usecase.getAttandance();
      emit(AttandanceSuccess(attanfanceList: result));
    } on Exception catch (e) {
      emit(
        AttandanceFailure(
          errorMessage: e.toString(),
        ),
      );
    
    }
  }
  void latestEvent() async {
    try {
      emit(AttandanceLoading());
      List<LatestEventModel> result = await usecase.latestEvents(  );
      emit(DashboardDetailEventSuccess(attanfanceList:result ));
      print("latestEvent");
    } on Exception catch (e) {
      print("latestEvent");
      emit(
        AttandanceFailure(
          errorMessage: e.toString(),
        ),
      );

    }
  }
  void getAttandanceData({int?userId}) async {
    try {
      emit(AttandanceLoading());
      DashboardAttandanceData result = await usecase.getAttandaceData(userId:userId );
      emit(DashBoardAttandanceSuccess(attandanceData: result));
    } on Exception catch (e) {
      emit(
        AttandanceFailure(
          errorMessage: e.toString(),
        ),
      );

    }
  }
}
