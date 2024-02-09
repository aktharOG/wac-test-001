
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  final String name;
  final double fontsize;
  final FontWeight fontweight;
  final Color? color;
  final bool align;
  final int? maxlines;
  final TextDirection? textDirection;
  final TextDecorationStyle? decorationStyle;
  final TextDecoration? decoration;
  final TextAlign? textAlign;
 final List<Shadow>? shadows;
 final Color? decorationColor;
  const CustomText(
      {super.key,
      required this.name,
      this.fontsize = 15,
      this.fontweight = FontWeight.normal,
      this.color,
      this.align = false,
      this.maxlines,
      this.textDirection,
      this.decorationStyle,
      this.decoration,
      this.textAlign,
      this.shadows,
      this.decorationColor
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: TextStyle(
        shadows: shadows,
          fontSize: fontsize.sp,
          fontWeight: fontweight,
          color: color ?? Colors.black,
          decorationStyle: decorationStyle,
          decoration: decoration,
          
          decorationColor: decorationColor?? Colors.black),
      textAlign:textAlign ?? (align ? TextAlign.center : TextAlign.start),
      maxLines: maxlines,
      overflow: TextOverflow.ellipsis,
      textDirection: textDirection,
     
    );
  }
}
