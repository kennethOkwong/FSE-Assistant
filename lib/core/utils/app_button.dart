// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

import 'pallet.dart';
import 'ui_helper1.dart';

class PrimaryBtn extends StatelessWidget {
  PrimaryBtn({
    Key? key,
    this.color,
    this.textColor,
    this.isImage,
    this.width,
    this.height,
    this.iconColor,
    this.bordercolor,
    this.image,
    required this.title,
    required this.onPress,
    this.titleStyle,
    this.borderRadius,
    this.prefix,
    this.suffix,
  }) : super(key: key);

  Color? color;
  Color? bordercolor;
  Color? iconColor;
  bool? isImage;
  double? height;
  double? width;
  String? image;
  Color? textColor;
  double? borderRadius;
  final String title;
  final Function onPress;
  final TextStyle? titleStyle;
  final Widget? prefix;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPress();
      },
      child: SizedBox(
        child: Container(
          height: height ?? 60,
          width: width ?? screenWidth(context, 1.1),
          decoration: BoxDecoration(
            color: color ?? AppColor.primaryColor,
            borderRadius: borderRadius != null
                ? BorderRadius.circular(borderRadius!)
                : null,
            border: Border.all(
                width: 2, color: bordercolor ?? AppColor.primaryColor),
          ),
          child: isImage == true
              ? Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image.asset(
                          image ?? '',
                          height: 30,
                          width: 50,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Center(
                        child: Text(
                          title,
                          style: titleStyle ??
                              TextStyle(
                                fontSize: 15,
                                fontFamily: 'Outfit',
                                color: textColor ?? AppColor.lightColor,
                                decoration: TextDecoration.none,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 5,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      prefix ?? const Text(''),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        title,
                        style: titleStyle ??
                            TextStyle(
                              fontSize: 15,
                              fontFamily: 'Outfit',
                              color: textColor ?? AppColor.lightColor,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      suffix ?? const Text(''),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
