import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {
  const ReviewState();
}

class ReviewInitial extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewLoading extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewFailure extends ReviewState {
  final String errorMessage;

  const ReviewFailure({required this.errorMessage});
  @override
  List<Object> get props => [];
}

class ReviewSuccess extends ReviewState {
  const ReviewSuccess();
  @override
  List<Object> get props => [];
}
