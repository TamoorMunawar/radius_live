import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/domain/entities/review_payload/review_playload.dart';
import 'package:radar/domain/usecase/review/review_usecase.dart';
import 'package:radar/presentation/cubits/review/review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final ReviewUsecase usecase;
  ReviewCubit(this.usecase) : super(ReviewInitial());

  void addReview(ReviewPayload payload) async {
    try {
      emit(ReviewLoading());
      final bool result = await usecase.addReview(payload);
      if (result) {
        emit(const ReviewSuccess());
      } else {
        const ReviewFailure(errorMessage: "Something wrong with review system!");
      }
    } on Exception catch (e) {
      emit(
        ReviewFailure(
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
