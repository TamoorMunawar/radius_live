import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/announcement/Announcement.dart';
import 'package:radar/domain/usecase/announcement/announcement_usecase.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementUsecase usecase;

  AnnouncementCubit(this.usecase) : super(AnnouncementInitial());

  void getAnnouncement({int? page}) async {
    try {
      emit(AnnouncementLoading());
      List<Announcement>? result = await usecase.getAnnouncement(page: page);
      print("Announcement result ${result.length}");
      // result.add(Announcement(id: 0));
      print("Announcement result ${result.length}");
      emit(AnnouncementSuccess(announcement: result));
    } on Exception catch (e) {
      emit(
        AnnouncementFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
