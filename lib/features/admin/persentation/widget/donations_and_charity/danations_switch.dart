import 'package:el_erinat/core/config/color_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SwitchToEnableCharitiesAndDonations extends StatefulWidget {
  const SwitchToEnableCharitiesAndDonations(
      {super.key, required this.charitiesAndDonations});
  final String charitiesAndDonations;
  @override
  State<SwitchToEnableCharitiesAndDonations> createState() =>
      _SwitchToEnableCharitiesAndDonationsState();
}

class _SwitchToEnableCharitiesAndDonationsState
    extends State<SwitchToEnableCharitiesAndDonations> {
  bool isSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 20.h,
        left: 20.h,
        right: 20.h,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 10.h),
      decoration: BoxDecoration(
          color: ColorManger.white,
          borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomSwitch(
            value: isSwitch,
            onChanged: (value) {
              setState(() {
                isSwitch = value;
              });
            },
            borderColor:
                ColorManger.logoColor, // Specify the desired border color here
          ),
          Text(
            widget.charitiesAndDonations,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 12.h,
                color: ColorManger.logoColor,
                fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final Color borderColor;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.borderColor,
  });

  @override
  // ignore: library_private_types_in_public_api
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onChanged(!widget.value);
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: widget.borderColor,
            width: 2.0, // Adjust the border width as needed
          ),
          borderRadius:
              BorderRadius.circular(20.0), // Adjust the border radius as needed
        ),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(2.0), // Adjust the padding as needed
          decoration: BoxDecoration(
            color: widget.value
                ? ColorManger.logoColor
                : Colors.black.withOpacity(
                    0.2), // Adjust the background color based on the switch state
            borderRadius: BorderRadius.circular(
                16.0), // Adjust the border radius as needed
          ),
          child: Center(
            child: widget.value
                ? const Icon(Icons.check,
                    color: Colors.white) // Adjust the icon color as needed
                : const Icon(Icons.close,
                    color: Colors.white), // Adjust the icon color as needed
          ),
        ),
      ),
    );
  }
}
