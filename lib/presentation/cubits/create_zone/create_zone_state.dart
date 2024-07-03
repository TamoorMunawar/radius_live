part of 'create_zone_cubit.dart';

abstract class CreateZoneState extends Equatable {
  const CreateZoneState();
}

class CreateZoneInitial extends CreateZoneState {
  @override
  List<Object> get props => [];
}
class CreateZoneLoading extends CreateZoneState {
  @override
  List<Object> get props => [];
}
class CreateZoneSuccess extends CreateZoneState {
  final bool result;

  CreateZoneSuccess({required this.result});
  @override
  List<Object> get props => [];
}
class CreateZoneFailed extends CreateZoneState {
  final String errorMessage;

  CreateZoneFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}

