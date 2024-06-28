import 'package:el_erinat/core/route/route_strings.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_home_screen.dart';
import 'package:el_erinat/features/admin/persentation/screens/admin_sub_screen/admin_donations_and_charity_screen.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/admin_upload_book_widget.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/book_details_screen.dart';
import 'package:el_erinat/features/admin/persentation/widget/admin_book_screen/upload_book_screen.dart';
import 'package:el_erinat/features/admin/persentation/widget/news_screen_widget/admin_upload_news_widget.dart';
import 'package:el_erinat/features/admin/persentation/widget/suggetion_admin_widget/admin_add_suggtion_screen.dart';
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/details_of_auditor_family.dart';
import 'package:el_erinat/features/admin/persentation/widget/tree_elerinat_widget/upload_tree_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen_branch/analitics_of_elerinat_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen_branch/auditor_team_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen_branch/book_of_elerinat_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen_branch/news_of_elerinat_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen_branch/suggestions_and_vote_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/home/home_screen_branch/tree_of_elerinat_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/intro_screens/first_intro_screens.dart';
import 'package:el_erinat/features/users/persentation/screens/intro_screens/secound_intro_screens.dart';
import 'package:el_erinat/features/users/persentation/screens/intro_screens/third_intro_screens.dart';
import 'package:el_erinat/features/users/persentation/screens/otp_screen/otp_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/register_screen/register_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/splash_screen/splach_screen.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/work_user_detatils.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/user_details_identaty.dart';
import 'package:el_erinat/features/users/persentation/screens/user_details_screen/user_details_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/news_elerinat/news_details/news_details.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/suggetions_screen/suggetion_screen.dart';
import 'package:el_erinat/features/users/persentation/widgets/home_widget/suggestions_and_vote/vote_screen/vote_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Map<String, WidgetBuilder> buildRoutes() {
    return {
      ConstantsRouteString.splashScreen: (context) => const SplachScreen(),
      ConstantsRouteString.firstintroScreens: (context) =>
          const FirstintroScreens(),
      ConstantsRouteString.secoundIntroScreens: (context) =>
          const SecoundIntroScreens(),
      ConstantsRouteString.thirdIntroScreens: (context) =>
          const ThirdIntroScreens(),
      ConstantsRouteString.registerScreen: (context) => const RegisterScreen(),
      ConstantsRouteString.otpScreen: (context) => const OtpScreen(),
      ConstantsRouteString.userDetailsIdentaty: (context) =>
          const UserDetailsIdentaty(),
      ConstantsRouteString.homeScreen: (context) => const HomeScreen(),
      //
      //!
      ConstantsRouteString.bookOfElerinatScreen: (context) =>
          const BookOfElerinatScreen(),
      ConstantsRouteString.treeOfElerinatScreen: (context) =>
          const TreeOfElerinatScreen(),
      ConstantsRouteString.analiticsOfElerinatScreen: (context) =>
          const AnaliticsOfElerinatScreen(),
      ConstantsRouteString.newsOfElerinatScreen: (context) =>
          const NewsOfElerinatScreen(),
      ConstantsRouteString.auditorTeamScreen: (context) =>
          const AuditorTeamScreen(),
      ConstantsRouteString.suggestionsandVoteScreen: (context) =>
          const SuggestionsandVoteScreen(),
      ConstantsRouteString.newsDetails: (context) => const NewsDetails(),
      ConstantsRouteString.voteScreen: (context) => const VoteScreen(),
      ConstantsRouteString.suggetionScreen: (context) =>
          const SuggetionScreen(),

      ConstantsRouteString.workUserDetails: (context) =>
          const WorkUserDetails(),
      ConstantsRouteString.adminHomeScreen: (context) =>
          const AdminHomeScreen(),

      ConstantsRouteString.adminUploadNews: (context) =>
          const AdminUploadNews(),

      ConstantsRouteString.adminUploadAndBookLibrary: (context) =>
          const AdminUploadAndBookLibrary(),

      ConstantsRouteString.adminAddSuggetions: (context) =>
          const AdminAddSuggetionsScreen(),

      ConstantsRouteString.adminDonationsAndCharityScreen: (context) =>
          const AdminDonationsAndCharityScreen(),

      ConstantsRouteString.userDitailsScreen: (context) =>
          const UserDitailsScreen(),

      ConstantsRouteString.uploadBookScreen: (context) =>
          const UploadBookScreen(),

      ConstantsRouteString.bookDetailsScreen: (context) =>
          const BookDetailsScreen(),

      ConstantsRouteString.uploadTreeScreen: (context) =>
          const UploadTreeScreen(),
      ConstantsRouteString.detailsOfFamilyAuditor: (context) =>
          const DetailsOfFamilyAuditor(),
    };
  }
}
