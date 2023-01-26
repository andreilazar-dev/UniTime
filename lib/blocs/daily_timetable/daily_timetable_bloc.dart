import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_essentials_kit/errors/localized_error.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:school_timetable/errors/connection_errors.dart';
import 'package:school_timetable/errors/generic_error.dart';
import 'package:school_timetable/errors/repository_error.dart';
import 'package:school_timetable/models/timetable/time_table.dart';
import 'package:school_timetable/repositories/courses_repository.dart';

part 'daily_timetable_bloc.freezed.dart';

part 'daily_timetable_event.dart';

part 'daily_timetable_state.dart';

class DailyTimetableBloc
    extends Bloc<DailyTimetableEvent, DailyTimetableState> {
  final CoursesRepository coursesRepository;

  DailyTimetableBloc({required this.coursesRepository})
      : super(const DailyTimetableState.fetching()) {
    on<_LoadDailyTimetableEvent>(_onLoading);
  }

  Future<void> _onLoading(
      _LoadDailyTimetableEvent event, Emitter<DailyTimetableState> emit) async {
    emit(const DailyTimetableState.fetching());
    try {
      final timetable = await coursesRepository.dailyLessons(event.date);
      emit(DailyTimetableState.fetched(timetable));
    } on RepositoryError catch (_) {
      emit(DailyTimetableState.error(ConnectionError()));
    } catch (error) {
      emit(DailyTimetableState.error(GenericError()));
    }
  }

  void loadTimetable(DateTime date) => add(_LoadDailyTimetableEvent(date));
}
