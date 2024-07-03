part of 'accept_invitation_cubit.dart';

abstract class AcceptInvitationState extends Equatable {
  const AcceptInvitationState();
}

class AcceptInvitationInitial extends AcceptInvitationState {
  @override
  List<Object> get props => [];
}
class AcceptInvitationLoading extends AcceptInvitationState {
  @override
  List<Object> get props => [];
}class DeclineInvitationLoading extends AcceptInvitationState {
  @override
  List<Object> get props => [];
}
class AcceptInvitationSuccess extends AcceptInvitationState {
  final bool result;

  AcceptInvitationSuccess({required this.result});
  @override
  List<Object> get props => [];
}class DeclineInvitationSuccess extends AcceptInvitationState {
  final bool result;

  DeclineInvitationSuccess({required this.result});
  @override
  List<Object> get props => [];
}
class AcceptInvitationFailed extends AcceptInvitationState {
  final String errorMessage;

  AcceptInvitationFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}
class DeclineInvitationFailed extends AcceptInvitationState {
  final String errorMessage;

  DeclineInvitationFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}

