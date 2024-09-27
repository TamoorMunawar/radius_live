part of 'job_cubit.dart';
abstract class JobState extends Equatable {
  const JobState();
}

class JobInitial extends JobState {
  @override
  List<Object> get props => [];
}

class JobLoading extends JobState {
  @override
  List<Object> get props => [];
}

class JobSuccess extends JobState {
  final List<job.Job> result;

  JobSuccess({required this.result});

  @override
  List<Object> get props => [];
}

class JobFailure extends JobState {
  final String errorMessage;

  JobFailure({required this.errorMessage});

  @override
  List<Object> get props => [];
}
