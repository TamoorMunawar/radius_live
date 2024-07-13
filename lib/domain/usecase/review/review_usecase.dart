import 'package:radar/constants/logger.dart';
import 'package:radar/domain/entities/review_payload/review_playload.dart';
import 'package:radar/domain/repository/radar_mobile_repository.dart';

class ReviewUsecase {
  final RadarMobileRepository repository;

  ReviewUsecase({required this.repository});

  Future<bool> addReview(ReviewPayload reviewPayload) async {
    try {
      return await repository.addReview(reviewPayload);
    } on Exception catch (e) {
      LogManager.error("register::error", e);
      throw Exception(e.toString().substring(11));
    }
  }
}
