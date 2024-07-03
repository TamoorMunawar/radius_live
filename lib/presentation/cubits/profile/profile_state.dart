part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();
}

final class ProfileInitial extends ProfileState {
  @override
  List<Object> get props => [];
}
final class ProfilLoading extends ProfileState {
  @override
  List<Object> get props => [];
}
final class ProfileSuccess extends ProfileState {
  final ProfileModel profileModel;

  const ProfileSuccess({required this.profileModel});
  @override
  List<Object> get props => [];
}
final class ProfileFailed extends ProfileState {
  final String errorMessage;

  const ProfileFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}
