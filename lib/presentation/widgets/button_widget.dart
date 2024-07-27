import 'package:flutter/material.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/extensions.dart';
import 'package:radar/constants/size_config.dart';

class SubmitButton extends StatelessWidget {
  SubmitButton(
      {super.key,
      this.width,
      this.height,
      this.gradientFirstColor,
      this.gradientSecondColor,
      this.borderWidth,
      required this.onPressed,
      required this.child});

  final double? width;
  final double? height;
  final Color? gradientFirstColor;
  final Color? gradientSecondColor;
  final double? borderWidth;
  final VoidCallback? onPressed;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width ?? SizeConfig.width(context, 0.85),
        height: height ?? SizeConfig.height(context, 0.07),
        decoration: ShapeDecoration(
          color: gradientFirstColor ?? GlobalColors.submitButtonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderWidth ?? SizeConfig.width(context, 0.025)),
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  const ProfileButton(
      {super.key,
      this.width,
      this.height,
      this.gradientFirstColor,
      this.gradientSecondColor,
      this.borderWidth,
      required this.onPressed,
      required this.title,
      required this.icon});

  final double? width;
  final double? height;
  final Color? gradientFirstColor;
  final Color? gradientSecondColor;
  final double? borderWidth;
  final VoidCallback? onPressed;
  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Center(
        child: Container(
          padding: EdgeInsets.only(
            top: SizeConfig.height(context, 0.01),
            bottom: SizeConfig.height(context, 0.01),
            left: SizeConfig.width(context, 0.02),
            right: SizeConfig.width(context, 0.04),
          ),
          margin: EdgeInsets.only(left: SizeConfig.width(context, 0.03), right: SizeConfig.width(context, 0.05)),
          width: width ?? SizeConfig.width(context, 0.9),
          //      height: height ?? SizeConfig.height(context, 0.08),
          decoration: ShapeDecoration(
            color: gradientFirstColor ?? GlobalColors.primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderWidth ?? SizeConfig.width(context, 0.025)),
            ),
          ),
          //    alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(icon, color: GlobalColors.whiteColor),
              SizedBox(width: 0.03.sw),
              Text(
                title,
                // textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 0.035.sw,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
