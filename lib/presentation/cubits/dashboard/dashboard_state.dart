part of 'dashboard_cubit.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();
}

final class DashboardInitial extends DashboardState {
  @override
  List<Object> get props => [];
}

final class DashboardDetailLoading extends DashboardState {
  @override
  List<Object> get props => [];
}

final class DashboardDetailSuccess extends DashboardState {
  final DashboardDetail dashboardDetail;

  DashboardDetailSuccess({required this.dashboardDetail});
  @override
  List<Object> get props => [];
}

final class DashboardJobSuccess extends DashboardState {
  List<JobDashboard> jobDashboard;

  DashboardJobSuccess({required this.jobDashboard});
  @override
  List<Object> get props => [];
}

final class DashboardZoneSuccess extends DashboardState {
  final List<ZoneDashboard> dashboardDetail;

  DashboardZoneSuccess({required this.dashboardDetail});
  @override
  List<Object> get props => [];
}

final class DashboardDetailFailed extends DashboardState {
  final String errorMessage;

  const DashboardDetailFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}
