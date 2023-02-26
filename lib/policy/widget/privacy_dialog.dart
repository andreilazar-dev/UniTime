/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:school_timetable/policy/cubit/privacy_policy_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_timetable/policy/model/privacy_status.dart';
import 'package:school_timetable/widgets/loading_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

typedef PrivacyStatusOnTap = void Function(PrivacyStatus status);

class PrivacyDialog extends StatelessWidget {
  Widget child;
  PrivacyStatusOnTap? onButtonTap;

  PrivacyDialog({required this.child, this.onButtonTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<PrivacyPolicyCubit, PrivacyPolicyState>(
          builder: (ctx, state) {
        if (state.isRequested) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            showDialog(
                barrierDismissible: false,
                context: ctx,
                builder: (context) {
                  return dialog(context);
                });
          });
        }
        return child;
      });

  Widget dialog(BuildContext context) {
    return Dialog(
      //shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: const Color.fromRGBO(97, 97, 168, 1),
      child: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: Future.delayed(const Duration(milliseconds: 150))
                  .then((value) {
                return rootBundle.loadString(findPolicyFile(context));
              }),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(
                    data: snapshot.data ?? '',
                    onTapLink: (text, url, title) {
                      launchUrl(Uri.parse(url ?? ""),
                          mode: LaunchMode.externalApplication);
                    },
                  );
                }
                return const LoadingWidget();
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (onButtonTap != null) {
                onButtonTap!(PrivacyStatus.authorized);
              }
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              backgroundColor: const Color(0xFF3E3E70),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
            ),
            child: Text(
              AppLocalizations.of(context)?.policy_label_button ?? '',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
        ],
      ),
    );
  }

  static String findPolicyFile(BuildContext context) {
    String basePath = 'assets/policy/privacy_policy_';
    String languageCode = findLanguageCode(context: context);

    switch (languageCode) {
      case 'it':
        basePath = '${basePath}it';
        break;
      case 'en':
      default:
        basePath = '${basePath}en';
        break;
    }

    return '$basePath.md';
  }

  /// Determine the current language code
  static String findLanguageCode({BuildContext? context}) {
    Locale? locale;
    if (context != null) {
      locale = Localizations.maybeLocaleOf(context);
    }
    final code = locale == null || locale.languageCode.isEmpty
        ? 'en'
        : locale.languageCode;
    return code;
  }
}
