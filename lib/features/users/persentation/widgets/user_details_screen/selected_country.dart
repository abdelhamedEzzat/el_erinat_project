import 'package:country_picker/country_picker.dart';
import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectedCountry extends StatelessWidget {
  const SelectedCountry({
    super.key,
    required this.onSelect,
    required this.countryText,
  });
  final void Function(Country) onSelect;
  final String countryText;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCountryPicker(
            context: context,
            countryListTheme: CountryListThemeData(
              flagSize: 25,
              backgroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
              bottomSheetHeight: 500.h,

              // Optional. Country list modal height
              //Optional. Sets the border radius for the bottomsheet.

              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),

              //Optional. Styles the search field.

              inputDecoration: InputDecoration(
                labelText: 'Search',
                hintText: 'Start typing to search',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: const Color(0xFF8C98A8).withOpacity(0.2),
                  ),
                ),
              ),
            ),
            onSelect: onSelect);
      },
      child: Container(
        padding: EdgeInsets.all(10.w),
        height: 45.h,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: ColorManger.logoColor.withOpacity(0.6),
            borderRadius: BorderRadius.all(Radius.circular(7.w))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              Icons.arrow_drop_down,
              size: 25.h,
            ),
            Text(countryText),
          ],
        ),
      ),
    );
  }
}
