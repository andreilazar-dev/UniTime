part of 'daily_timetable_bloc.dart';

@freezed
class DailyTimetableEvent with _$DailyTimetableEvent {
  const factory DailyTimetableEvent.load(DateTime date) =
      _LoadDailyTimetableEvent;
}
