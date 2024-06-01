import 'package:el_erinat/core/config/color_manger.dart';
import 'package:el_erinat/core/config/list_manger.dart';
import 'package:el_erinat/core/helpers/custom_text_form_field.dart';
import 'package:el_erinat/features/users/persentation/widgets/user_details_screen/gender_user_detatils/date_of_getting_certifcate_calender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldForUserDetatils extends StatefulWidget {
  final void Function(String)? onChangedText3;
  final void Function(String)? onChangedText1;
  final String? Function(String?)? validatorText2;
  final String? Function(String?)? validatorText1;
  final void Function(String?)? onChangedDropDownValue;
  final void Function(String, bool)? onDateSelected;
  final bool isTextField;
  final bool? isCalenderField;
  final String text1;
  final String text2;
  final String? valueDropDownValue;
  final Color? color;
  final bool isHijridate;
  final String? selectedDate;

  const TextFieldForUserDetatils({
    super.key,
    this.onChangedText3,
    this.onChangedText1,
    required this.isTextField,
    required this.text1,
    required this.text2,
    this.validatorText2,
    this.validatorText1,
    this.onChangedDropDownValue,
    this.valueDropDownValue,
    this.color,
    this.isCalenderField,
    this.isHijridate = false,
    this.selectedDate,
    this.onDateSelected,
  });

  @override
  _TextFieldForUserDetatilsState createState() =>
      _TextFieldForUserDetatilsState();
}

class _TextFieldForUserDetatilsState extends State<TextFieldForUserDetatils> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        widget.isTextField
            ? Expanded(
                child: CustomTextFormField(
                  validator: widget.validatorText2,
                  keyboardType: TextInputType.name,
                  onChanged: widget.onChangedText3,
                  labelText: Text(widget.text2),
                  width: MediaQuery.of(context).size.width / 2,
                ),
              )
            : widget.isCalenderField == true
                ? Flexible(
                    child: DateOfGettingCertificateCalender(
                      textIftrue: "${widget.selectedDate}",
                      isHijridate: widget.isHijridate,
                      onDateSelected: widget.onDateSelected!,
                    ),
                  )
                : Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7.w),
                        border: Border.all(color: ColorManger.logoColor),
                      ),
                      child: DropdownButton<String>(
                        padding: EdgeInsets.zero,
                        borderRadius: BorderRadius.circular(15),
                        isExpanded: true,
                        value: widget.valueDropDownValue,
                        icon: const Icon(Icons.arrow_drop_down),
                        elevation: 16,
                        style: TextStyle(
                          color: widget.color,
                          fontSize: 12.w,
                          fontWeight: FontWeight.bold,
                        ),
                        underline: Container(
                          height: 2,
                          color: Colors.transparent,
                        ),
                        onChanged: widget.onChangedDropDownValue,
                        items: liveOrDeadList
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
        SizedBox(width: 10.w),
        Expanded(
          child: CustomTextFormField(
            validator: widget.validatorText1,
            keyboardType: TextInputType.name,
            onChanged: widget.onChangedText1,
            labelText: Text(widget.text1),
            width: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ],
    );
  }
}
