class ReviewPayload {
  final String review;
  final int rating;
  final int usherId;
  final int teamId;
  final bool isBanned;

  ReviewPayload(
      {required this.review,
      required this.rating,
      required this.usherId,
      required this.teamId,
      required this.isBanned});
}
