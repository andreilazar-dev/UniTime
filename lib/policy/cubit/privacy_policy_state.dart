/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'privacy_policy_cubit.dart';

@freezed
class PrivacyPolicyState with _$PrivacyPolicyState {
  const PrivacyPolicyState._();

  const factory PrivacyPolicyState({
    @Default(PrivacyStatus.requested) PrivacyStatus privacyStatus,
  }) = _PrivacyPolicyState;

  bool get isAuthorized => privacyStatus == PrivacyStatus.authorized;

  bool get isRequested => privacyStatus == PrivacyStatus.requested;
}
