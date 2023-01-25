/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'manage_courses_bloc.dart';

@freezed
class ManageCoursesState with _$ManageCoursesState {
  const factory ManageCoursesState.fetching() = FetchingManageCoursesState;

  const factory ManageCoursesState.fetched(Configuration data) =
      FetchedManageCoursesState;

  const factory ManageCoursesState.saved() = SavedManageCoursesState;

  const factory ManageCoursesState.error() = ErrorManageCoursesState;
}
