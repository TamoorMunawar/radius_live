import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/usecase/create_job/create_job_usecase.dart';

part 'create_job_state.dart';

class CreateJobCubit extends Cubit<CreateJobState> {
  final CreateJobUsecase usecase;

  CreateJobCubit(this.usecase) : super(CreateJobInitial());

  void createJob(
      {int?eventId, String ?jobName, String? totalMaleSalary, String? totalFemaleSalary, String? dailyMaleSalary, String? dailyFemaleSalary,}) async {
    try {
      emit(CreateJobLoading());
      bool result = await usecase.createJob(
          eventId: eventId,
          dailyMaleSalary: dailyMaleSalary,
          dailyFemaleSalary: dailyFemaleSalary,
          jobName: jobName,
          totalFemaleSalary: totalFemaleSalary,
          totalMaleSalary: totalMaleSalary);
      emit(CreateJobSuccess(result: result));
    } on Exception catch (e) {
      emit(
          CreateJobFailed(
            errorMessage: e.toString(),
          ));
    }
  }}