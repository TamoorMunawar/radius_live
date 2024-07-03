import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:radar/constants/colors.dart';
import 'package:radar/constants/size_config.dart';

class RadiusTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final VoidCallback? onTap;

  // final void? Function(void?)? onTab;
  final TextCapitalization? textCapitalization;
  final TextInputType? textInputType;
  final Widget? suffixIcon;
  final bool? readOnly;
  bool isPassword;
  double? leftPadding;
  double? rightPadding;
  int? maxLength;
  List<TextInputFormatter>? inputFormatters;

  RadiusTextField({
    super.key,
    required this.controller,
    this.isPassword = false,
    required this.hintText,
    required this.validator,
    this.onTap,
    // this.onTab,
    this.inputFormatters,
    this.suffixIcon,
    this.rightPadding,
    this.leftPadding,
    this.textCapitalization,
    this.maxLength,
    this.textInputType,
    this.readOnly,
  });

  @override
  State<RadiusTextField> createState() => _RadiusTextFieldState();
}

class _RadiusTextFieldState extends State<RadiusTextField> {
  bool? secureText;

  void initState() {
    secureText = (widget.isPassword) ? true : false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        //  top: SizeConfig.height(context, 0.05),
        //bottom: SizeConfig.height(context, 0.05),
        left: SizeConfig.width(context, widget.leftPadding ?? 0.07),
        right: SizeConfig.width(context, widget.rightPadding ?? 0.07),
      ),
      child: Material(
        color: Colors.transparent,
        shadowColor: const Color(0xff006DFC).withOpacity(0.16),
        child: TextFormField(
          inputFormatters: widget.inputFormatters,
          onTap: widget.onTap,
          enabled: widget.readOnly,
          maxLines: widget.maxLength ?? 1,
          //maxLength:25,
          validator: widget.validator,
          controller: widget.controller,
          obscureText: secureText ?? false,
          keyboardType: (widget.textInputType) ?? TextInputType.emailAddress,
          decoration: InputDecoration(
              filled: false,
              //    enabled: widget.readOnly??true,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.hintTextColor,
                ),
                borderRadius: BorderRadius.circular(
                  SizeConfig.width(context, 0.02),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.hintTextColor,
                ),
                borderRadius: BorderRadius.circular(
                  SizeConfig.width(context, 0.02),
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.hintTextColor,
                  // width: SizeConfig.width(context, 0.005),
                ),
                borderRadius: BorderRadius.circular(
                  SizeConfig.width(context, 0.02),
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.hintTextColor,
                ),
                borderRadius: BorderRadius.circular(
                  SizeConfig.width(context, 0.02),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: GlobalColors.hintTextColor,
                ),
                borderRadius: BorderRadius.circular(
                  SizeConfig.width(context, 0.02),
                ),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontWeight: FontWeight.w400,
                color: GlobalColors.textFieldHintColor,
              ),
                    suffixIcon: (widget.isPassword)
              ? IconButton(
            onPressed: () {
              setState(() {
                secureText = !secureText! ?? false;
              });
            },
            icon: Icon(!secureText! ?? false
                ? Icons.visibility_off
                : Icons.visibility),color: Colors.white,
          )
              : IconButton(
            onPressed: () {},
            icon: const Icon(Icons.visibility, color: Colors.transparent),
          ),),
          style: TextStyle(
            color: GlobalColors.textFieldHintColor,
            fontSize: SizeConfig.width(context, 0.04),
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w400,

          ),
          autovalidateMode: AutovalidateMode.onUserInteraction,

          onChanged: (text) {},
        ),
      ),
    );
  }
}
