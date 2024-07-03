part of 'zone_cubit.dart';

abstract class ZoneState extends Equatable {
  const ZoneState();
}

class ZoneInitial extends ZoneState {
  @override
  List<Object> get props => [];
}
class ZoneLoading extends ZoneState {
  @override
  List<Object> get props => [];
}
class ZoneSuccess extends ZoneState {
  final List<Zone>result;

  ZoneSuccess({required this.result});
  @override
  List<Object> get props => [];
}
class ZoneFailure extends ZoneState {
  final String errorMessage;

  ZoneFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
