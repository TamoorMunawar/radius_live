part of 'create_job_cubit.dart';

abstract class CreateJobState extends Equatable {
  const CreateJobState();
}

class CreateJobInitial extends CreateJobState {
  @override
  List<Object> get props => [];
}

class CreateJobLoading extends CreateJobState {
  @override
  List<Object> get props => [];
}

class CreateJobSuccess extends CreateJobState {
  final bool result;

  CreateJobSuccess({required this.result});
  @override
  List<Object> get props => [];
}

class CreateJobFailed extends CreateJobState {
  final String errorMessage;

  CreateJobFailed({required this.errorMessage});
  @override
  List<Object> get props => [];
}
