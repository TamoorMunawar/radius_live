part of 'zone_seats_cubit.dart';

sealed class ZoneSeatsState extends Equatable {
  const ZoneSeatsState();
}

final class ZoneSeatsInitial extends ZoneSeatsState {
  @override
  List<Object> get props => [];
}final class ZoneSeatsLoading extends ZoneSeatsState {
  @override
  List<Object> get props => [];
}final class ZoneSeatsSuccess extends ZoneSeatsState {
  final bool?result;

  ZoneSeatsSuccess({required this.result});
  @override
  List<Object> get props => [];
}final class ZoneSeatsFailed extends ZoneSeatsState {
  final String errorMessage;

  ZoneSeatsFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}
