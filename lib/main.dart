/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:school_timetable/app.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'misc/firebase_options.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  HydratedBloc.storage = storage;

  //Android 11 and lower
  if (!Platform.operatingSystemVersion.contains("12")) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky).then(
      (_) => runApp(App()),
    );
  } else {
    //Setting SystemUIMode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: [SystemUiOverlay.top]).then(
      (_) => runApp(App()),
    );
    //Callback when Ui change
    SystemChrome.setSystemUIChangeCallback((systemOverlaysAreVisible) async {
      return await Future.delayed(const Duration(seconds: 2), () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.top]);
      });
    });
  }
}
