import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'check_in_state.dart';

class CheckInCubit extends Cubit<CheckInState> {
  CheckInCubit() : super(CheckInInitial());
}
