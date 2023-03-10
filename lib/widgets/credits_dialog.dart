/*
 *  Copyright (c) 2020 - 2023
 *  Author: Andrei Lazar
 *
 *  This file is part of UniTime.
 *
 *  Use of this source code is governed by a GPL-3.0 license that can be found in the LICENSE file
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class CreditsDialog extends StatelessWidget {
  const CreditsDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Text(
        AppLocalizations.of(context)?.settings_credits ?? '',
        style: Theme.of(context).textTheme.labelLarge,
        textAlign: TextAlign.center,
      ),
      content: IntrinsicHeight(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)?.settings_credits_desc ?? '',
              style: Theme.of(context).textTheme.labelMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
                AppLocalizations.of(context)?.settings_credits_social_desc ??
                    '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      child: const Icon(FontAwesomeIcons.telegram,
                          color: Colors.blue, size: 32.0),
                      onTap: () =>
                          _launchLink('https://t.me/+_tqHYC1iVh85MDU0')),
                ],
              ),
            ),
            Text(AppLocalizations.of(context)?.settings_credits_donation ?? '',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.labelSmall),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      child: const Icon(FontAwesomeIcons.paypal,
                          color: Colors.blue, size: 32.0),
                      onTap: () => _launchLink(
                          'https://www.paypal.com/donate?hosted_button_id=24J39EE56ESAQ')),
                ],
              ),
            ),

            //Copyright
            Divider(
              color: Theme.of(context).textTheme.labelLarge?.color,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(FontAwesomeIcons.copyright,
                    color: Colors.white,
                    size: Theme.of(context).textTheme.labelSmall?.fontSize),
                Text(
                  'UniTime',
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Text(
              AppLocalizations.of(context)?.settings_credits_desc_copyright ??
                  '',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).textTheme.labelSmall?.color,
                fontSize: 10,
                fontWeight: FontWeight.w200,
              ),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25))),
            backgroundColor: const Color(0xFF535389),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
          ),
          child: Text(
            'OK',
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }

  _launchLink(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}
