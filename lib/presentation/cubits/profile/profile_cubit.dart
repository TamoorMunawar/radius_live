import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/profile/profile_model.dart';
import 'package:radar/domain/usecase/profile/profile_usecase.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileUsecase usecase;
  ProfileCubit(this.usecase) : super(ProfileInitial());

  ProfileModel? result;

  void getProfileDetails() async {
    try {
      emit(ProfilLoading());
      result = await usecase.getProfileDetail();
      emit(ProfileSuccess(profileModel: result!));
    } on Exception catch (e) {
      emit(
        ProfileFailed(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
