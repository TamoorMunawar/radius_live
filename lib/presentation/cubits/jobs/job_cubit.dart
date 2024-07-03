import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:radar/domain/entities/Job.dart';
import 'package:radar/domain/entities/supervisior/Supervisior.dart';
import 'package:radar/domain/usecase/job/job_usecase.dart';
import 'package:radar/domain/usecase/supervisor/supervisior_usecase.dart';

part 'job_state.dart';

class JobCubit extends Cubit<JobState> {
  final JobUsecase usecase;

  JobCubit(this.usecase) : super(JobInitial());

  void getJob({int? eventModelId,bool ?isZone,int?zoneId}) async {
    try {
      emit(JobLoading());
      List<Job> result = await usecase.getJob(eventModelId: eventModelId,isZone: isZone,zoneId: zoneId);
      emit(JobSuccess(result: result));
    } on Exception catch (e) {
      emit(
        JobFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
