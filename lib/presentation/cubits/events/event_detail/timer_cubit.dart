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
    if (_timer != null) return; // Prevent multiple timers
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) => _updateTimeDifference());
  }
  stop() {
    _timer?.cancel();
    _timer = null;
    _expiryTime = null; // Reset expiry time
  }

  bool checkIfExpired(EventDetail eventDetail) {
    DateTime startTime = DateTime(
      eventDetail.startDate!.year,
      eventDetail.startDate!.month,
      eventDetail.startDate!.day,
      int.parse(eventDetail.startTime.toString().split(":")[0]),
      int.parse(eventDetail.startTime.toString().split(":")[1]),
      eventDetail.startTime.toString().split(":").length > 2
          ? int.parse(eventDetail.startTime.toString().split(":")[2])
          : 0,
    );

    if (eventDetail.leadTimeUnit == "hour") {
      _expiryTime = startTime.add(Duration(hours: int.parse(eventDetail.leadTime!)));
    } else if (eventDetail.leadTimeUnit == "days") {
      _expiryTime = startTime.add(Duration(days: int.parse(eventDetail.leadTime!)));
    } else {
      // Handle other cases or throw an error
    }

    log(DateFormat("yyyy:MM:dd hh:mm a").format(_expiryTime!));

    return DateTime.now().isAfter(_expiryTime!);
  }


  void _updateTimeDifference() {
    if (_expiryTime == null) return;
    final now = DateTime.now();
    emit(_expiryTime!.difference(now));
  }
}
