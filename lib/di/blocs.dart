/*
 *  Copyright (c) 2020 - 2022
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

part of 'dependency_injector.dart';

final List<BlocProvider> _blocs = [
  BlocProvider<ThemeCubit>(
    create: (context) => ThemeCubit(),
  ),
  BlocProvider<EasterEggCubit>(
    create: (context) => EasterEggCubit(),
  ),
  BlocProvider<RegistrationBloc>(
    create: (context) =>
        RegistrationBloc(repository: context.read())..checkRegistration(),
  ),
  // TODO: add here your blocs and cubits with BlocProvider
];
