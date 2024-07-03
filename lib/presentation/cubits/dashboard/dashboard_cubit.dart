import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/attandance/Attandance.dart';
import 'package:radar/domain/entities/dashboard/dashboard_detail.dart';
import 'package:radar/domain/entities/job_dashboard/job_dashboard.dart';
import 'package:radar/domain/entities/lastest_event/latest_event_model.dart';
import 'package:radar/domain/entities/zone_dashboard/zone_dashboard.dart';
import 'package:radar/domain/usecase/dashboard/dashboard_usecase.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardUsecase usecase;
  DashboardCubit(this.usecase) : super(DashboardInitial());
  void dashboardDetail({int?eventId}) async {
    try {
      emit(DashboardDetailLoading());
      DashboardDetail result = await usecase.dashboardDetail(eventId: eventId  );
      emit(DashboardDetailSuccess(dashboardDetail:result ));
      print("dashboardDetail");
    } on Exception catch (e) {
      print("dashboardDetail");
      emit(
        DashboardDetailFailed(
          errorMessage: e.toString(),
        ),
      );

    }
  }

  void dashboardZone({int?eventId}) async {
    try {
      emit(DashboardDetailLoading());
      List<ZoneDashboard>  result = await usecase.dashboardZone(eventId: eventId  );
      emit(DashboardZoneSuccess(dashboardDetail:result ));
      print("dashboardDetail");
    } on Exception catch (e) {
      print("dashboardDetail");
      emit(
        DashboardDetailFailed(
          errorMessage: e.toString(),
        ),
      );

    }
  }
  void dashboardJob({int?eventId}) async {
    try {
      emit(DashboardDetailLoading());
      List<JobDashboard> result = await usecase.dashboardJob(eventId: eventId  );
      emit(DashboardJobSuccess(jobDashboard:result ));
      print("dashboardDetail");
    } on Exception catch (e) {
      print("dashboardDetail");
      emit(
        DashboardDetailFailed(
          errorMessage: e.toString(),
        ),
      );

    }
  }
}
