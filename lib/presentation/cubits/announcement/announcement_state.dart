part of 'announcement_cubit.dart';

abstract class AnnouncementState extends Equatable {
  const AnnouncementState();
}

class AnnouncementInitial extends AnnouncementState {
  @override
  List<Object> get props => [];
}class AnnouncementLoading extends AnnouncementState {
  @override
  List<Object> get props => [];
}class AnnouncementSuccess extends AnnouncementState {
  final List<Announcement>? announcement;

  AnnouncementSuccess({required this.announcement});
  @override
  List<Object> get props => [];
}class AnnouncementFailure extends AnnouncementState {
  final String errorMessage;

  const AnnouncementFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}
