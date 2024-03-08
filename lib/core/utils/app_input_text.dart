import 'package:flutter/material.dart';

import '../app theme/app_text_styles.dart';
import 'pallet.dart';
import 'style_manager.dart';

class CustomInputText extends StatelessWidget {
  const CustomInputText({
    Key? key,
    required this.inputType,
    this.textColor,
    this.prefix,
    this.label,
    this.onChangeVal,
    this.suffix,
    this.obscure,
    this.onChange,
    this.maxLine,
    required this.hintText,
    this.controller,
    this.validator,
    this.style,
    this.autovalidateMode,
    this.onChanged,
    this.onTap,
    this.readOnly,
    this.bgcolor,
    this.borderColor,
    this.borderRadius,
    this.floatingLabelBehavior,
    this.focusnode,
  }) : super(key: key);
  final Widget? prefix;
  final AutovalidateMode? autovalidateMode;
  final Widget? suffix;
  final Color? bgcolor;
  final Color? borderColor;
  final Color? textColor;
  final String? label;
  final String hintText;
  final bool? obscure;
  final Function(String)? onChanged;
  final String? onChangeVal;
  final TextInputType inputType;
  final TextEditingController? controller;
  final Function? onChange;
  final int? maxLine;
  final TextStyle? style;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  final bool? readOnly;
  final double? borderRadius;
  final FloatingLabelBehavior? floatingLabelBehavior;
  final FocusNode? focusnode;

  @override
  Widget build(BuildContext context) {
    final fontSize = style?.fontSize == null
        ? 16 / MediaQuery.textScaleFactorOf(context)
        : style!.fontSize! / MediaQuery.textScaleFactorOf(context);
    return TextFormField(
      textAlignVertical: TextAlignVertical.center,
      onTap: onTap,
      readOnly: readOnly ?? false,
      focusNode: focusnode,
      style: bodyTextStyle
          .copyWith(color: AppColor.textColor)
          .copyWith(fontSize: fontSize),
      keyboardType: inputType,
      obscureText: obscure ?? false,
      validator: validator,
      autovalidateMode: autovalidateMode,
      textInputAction: TextInputAction.next,
      controller: controller,
      onChanged: onChanged,
      cursorColor: AppColor.textColor,

      // maxLines: 1 ?? 1 ,

      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(bottom: 30, left: 10, right: 10, top: 10),
        prefixIcon: prefix,
        suffixIcon: suffix,
        // suffix: suffix,

        fillColor: bgcolor,
        filled: bgcolor != null,
        // focusColor: bgcolor,
        label: Text(
          label ?? '',
          style: getLightStyle(color: AppColor.grey, fontSize: 16).copyWith(),
        ),
        hintStyle: TextStyle(color: AppColor.primaryColor.withOpacity(.4))
            .copyWith(fontSize: fontSize),
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.primaryColor.withOpacity(.4),
            width: 1.5,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.primaryColor.withOpacity(.4),
            width: 1.5,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.primaryColor,
            width: 1.5,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 10)),
          borderSide: BorderSide(
            color: borderColor ?? AppColor.errorColor,
            width: 1.5,
          ),
        ),
        floatingLabelBehavior:
            floatingLabelBehavior ?? FloatingLabelBehavior.auto,
      ),
    );
  }
}

class CustomInputText2 extends StatelessWidget {
  final String hintText;
  final Function? onChange;
  final TextInputType inputType;

  const CustomInputText2(
      {super.key,
      required this.hintText,
      this.onChange,
      required this.inputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColor.textColor,
      textInputAction: TextInputAction.next,
      keyboardType: inputType,
      onChanged: (value) {
        onChange!(value);
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(
          bottom: 5,
          left: 10,
          right: 10,
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColor.greyColor),
        enabledBorder: const UnderlineInputBorder(
            //<-- SEE HERE
            borderSide: BorderSide(
          width: 1.5,
          color: AppColor.greyColor,
        )),
        focusedBorder: const UnderlineInputBorder(
            //<-- SEE HERE
            borderSide: BorderSide(width: 1.5, color: AppColor.greyColor)),
      ),
    );
  }
}
