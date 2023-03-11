/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:school_timetable/policy/model/privacy_status.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'privacy_policy_cubit.freezed.dart';
part 'privacy_policy_state.dart';

class PrivacyPolicyCubit extends HydratedCubit<PrivacyPolicyState> {
  PrivacyPolicyCubit() : super(const PrivacyPolicyState());

  @override
  PrivacyPolicyState? fromJson(Map<String, dynamic> json) => PrivacyPolicyState(
        privacyStatus:
            PrivacyStatus.values.byName(json['privacy_status'] as String),
      );

  @override
  Map<String, dynamic>? toJson(PrivacyPolicyState state) => {
        'privacy_status': state.privacyStatus.name,
      };

  void setPrivacy(PrivacyStatus? privacyStatus) => emit(PrivacyPolicyState(
      privacyStatus: privacyStatus ?? PrivacyStatus.requested));
}
