part of 'attandance_cubit.dart';

abstract class AttandanceState extends Equatable {
  const AttandanceState();
}

class AttandanceInitial extends AttandanceState {
  @override
  List<Object> get props => [];
}
class AttandanceLoading extends AttandanceState {
  @override
  List<Object> get props => [];
}
class AttandanceSuccess extends AttandanceState {
  final List<Attandance>attanfanceList;

  AttandanceSuccess({required this.attanfanceList});
  @override
  List<Object> get props => [];
}class DashboardDetailEventSuccess extends AttandanceState {
  final List<LatestEventModel>attanfanceList;

  DashboardDetailEventSuccess({required this.attanfanceList});
  @override
  List<Object> get props => [];
}class DashBoardAttandanceSuccess extends AttandanceState {
  final DashboardAttandanceData attandanceData;

  DashBoardAttandanceSuccess({required this.attandanceData});
  @override
  List<Object> get props => [];
}
class AttandanceFailure extends AttandanceState {
  final String errorMessage;

  AttandanceFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
