import 'dart:async';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:radar/domain/entities/events/event_detail/Event_detail.dart';

class TimerCubit extends Cubit<Duration> {
  TimerCubit() : super(Duration.zero);

  Timer? _timer;
  DateTime? _expiryTime;

  start() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTimeDifference());
  }

  stop() {
    _timer!.cancel();
    _timer = null;
  }

  bool checkIfExpired(EventDetail eventDetail) {
    DateTime startTime = DateTime(
      eventDetail.startDate!.year,
      eventDetail.startDate!.month,
      eventDetail.startDate!.day,
      int.parse(eventDetail.startTime.toString().split(":").first),
      int.parse(eventDetail.startTime.toString().split(":").last),
    );
    DateTime? expiryTime;
    if (eventDetail.leadTimeUnit == "hour") {
      expiryTime = startTime.add(Duration(hours: int.parse(eventDetail.leadTime!)));
    } else if (eventDetail.leadTimeUnit == "days") {
      expiryTime = startTime.add(Duration(days: int.parse(eventDetail.leadTime!)));
    }

    _expiryTime = expiryTime;

    String date = DateFormat("yyyy:MM:dd hh:mm a").format(expiryTime!);
    log(date);

    final now = DateTime.now();
    if (now.difference(expiryTime).isNegative) {
      return false;
    } else {
      return true;
    }
  }

  void _updateTimeDifference() {
    final now = DateTime.now();
    emit(_expiryTime!.difference(now));
  }
}
