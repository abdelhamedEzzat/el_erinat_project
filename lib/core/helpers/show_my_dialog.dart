import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:flutter/material.dart';

Future<void> showMyDialog(
  BuildContext context,
) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          MStrings.aleartTitleInSuggestionScreen,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: ColorManger.logoColor),
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                MStrings.aleartlistBodyInSuggetions,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.end,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              MStrings.ok,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: ColorManger.logoColor),
              textAlign: TextAlign.left,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
