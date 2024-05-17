import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/const_strings/manage_strings.dart';
import 'package:el_erinat/core/helpers/back_ground_and_app_bar_and_dynamic_body.dart';
import 'package:el_erinat/core/helpers/botton.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/features/admin/persentation/widget/news_screen_widget/choose_type_of_news.dart';
import 'package:el_erinat/features/admin/persentation/widget/news_screen_widget/upload_news_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdminUploadNews extends StatelessWidget {
  const AdminUploadNews({super.key});

  @override
  Widget build(BuildContext context) {
// <DropdownMenuItem<dynamic>>?
    List items = ['خبر', "مناسبة"];
    return BackGroundAndAppBarAndDaynamicBody(
        alignmentTitle: Alignment.center,
        titleName: MStrings.uplaodNews,
        yourBodyOfScreen: Positioned.fill(
            child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 20.w,
                right: 20.w,
              ),
              child: Column(
                children: [
                  //! Choose Type Of News
                  ChooseTypeOfNews(items: items),
                  SizedBox(
                    height: 25.h,
                  ),

                  //! Upload News Image

                  const UploadNewsImage(),
                  SizedBox(
                    height: 25.h,
                  ),

                  //! address news textField

                  CustomTextFormField(
                    hintColor: ColorManger.logoColor,
                    hintText: MStrings.newsAddress,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),

                  //! details news textField

                  CustomTextFormField(
                    hintColor: ColorManger.logoColor,
                    maxLines: 5,
                    hintText: MStrings.detailsNews,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  BottonClick(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      onTap: () {},
                      text: MStrings.submit)
                ],
              ),
            ),
          ),
        )));
  }
}
