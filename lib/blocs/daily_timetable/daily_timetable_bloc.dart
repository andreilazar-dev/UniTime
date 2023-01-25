import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/repositories/courses_repository.dart';

part 'daily_timetable_bloc.freezed.dart';

part 'daily_timetable_event.dart';

part 'daily_timetable_state.dart';

class DailyTimetableBloc
    extends Bloc<DailyTimetableEvent, DailyTimetableState> {
  final CoursesRepository coursesRepository;

  DailyTimetableBloc({required this.coursesRepository})
      : super(DailyTimetableState.fetching()) {
    on<_LoadDailyTimetableEvent>(_onLoading);
  }

  Future<void> _onLoading(
      _LoadDailyTimetableEvent event, Emitter<DailyTimetableState> emit) async {
    try {
      final timetable = await coursesRepository.dailyLessons(event.date);

      emit(DailyTimetableState.fetched(timetable));
      //emit(DailyTimetableState.fetched());

    } catch (error) {
      //TODO : EXCEPTION
      throw Exception(error);
    }
  }

  void loadTimetable(DateTime date) => add(_LoadDailyTimetableEvent(date));
}
