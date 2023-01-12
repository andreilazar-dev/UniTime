import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'daily_timetable_event.dart';
part 'daily_timetable_state.dart';

class DailyTimetableBloc
    extends Bloc<DailyTimetableEvent, DailyTimetableState> {
  DailyTimetableBloc() : super(DailyTimetableInitial()) {
    on<DailyTimetableEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
