import 'package:el_erinat/core/route/route_strings.dart';
import 'package:flutter/material.dart';

void navigateToScreen(BuildContext context, int index) {
  String routeName;
  switch (index) {
    case 0:
      routeName = ConstantsRouteString.bookOfElerinatScreen;
      break;
    case 1:
      routeName = ConstantsRouteString.treeOfElerinatScreen;
      break;
    case 2:
      routeName = ConstantsRouteString.analiticsOfElerinatScreen;
      break;
    case 3:
      routeName = ConstantsRouteString.newsOfElerinatScreen;
      break;
    case 4:
      routeName = ConstantsRouteString.auditorTeamScreen;
      break;
    case 5:
      routeName = ConstantsRouteString.suggestionsandVoteScreen;
      break;
    default:
      return; // Return if index is out of bounds
  }
  Navigator.of(context).pushNamed(routeName);
}
