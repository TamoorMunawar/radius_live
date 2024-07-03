import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/usecase/accept_invitation/accept_ivitation_usecase.dart';

part 'accept_invitation_state.dart';

class AcceptInvitationCubit extends Cubit<AcceptInvitationState> {
  final AcceptInvitationUsecase usecase;
  AcceptInvitationCubit(this.usecase) : super(AcceptInvitationInitial());
  void acceptInvitation({int?eventId,int?status}) async {
    try {
      emit(AcceptInvitationLoading());
      bool result = await usecase.acceptInvitation(eventId: eventId,status: status);
      emit(AcceptInvitationSuccess(result: result ));
      print("AcceptInvitationSuccess");
    } on Exception catch (e) {
      print("AcceptInvitationFailed");
      emit(
        AcceptInvitationFailed(
          errorMessage: e.toString(),
        ),
      );

    }
  }
  void declineInvitation({int?eventId,int?status}) async {
    try {
      emit(DeclineInvitationLoading());
      bool result = await usecase.acceptInvitation(eventId: eventId,status: status);
      emit(DeclineInvitationSuccess(result: result ));
      print("AcceptInvitationSuccess");
    } on Exception catch (e) {
      print("AcceptInvitationFailed");
      emit(
        DeclineInvitationFailed(
          errorMessage: e.toString(),
        ),
      );

    }
  }
}
