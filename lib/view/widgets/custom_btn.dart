import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wac_test_001/core/constants/app_colors.dart';
import 'package:wac_test_001/theme/app_theme.dart';
import 'package:wac_test_001/view/widgets/custom_svg.dart';
import 'package:wac_test_001/view/widgets/custom_text.dart';


class CustomButton extends StatelessWidget {
  final String label;
  final double height;
  final double? width;
  final Color? backgroundColor;
  final bool isGradient;
  final Function()? onPressed;
  final Widget? icon;
  final double fontSize;
  final Color? foregroundColor;
  final double spacing;
  final double elevation;
  final bool isShadow;
  final double radius;
  final String? leadingIcon;
  final bool isLoading;
  final List<Shadow>? textShadow;
  final Color? trailingBxColor;

  const CustomButton({
    super.key,
    this.onPressed,
    required this.label,
    this.height = 45,
    this.width,
    this.backgroundColor,
    this.foregroundColor,
    this.isGradient = true,
    this.icon,
    this.spacing = 0,
    this.fontSize = 18,
    this.elevation = 0,
    this.isShadow = false,
    this.radius = 10,
    this.leadingIcon,
    this.isLoading = false,
    this.textShadow,
    this.trailingBxColor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              blurRadius: 12, color: Color.fromARGB(66, 0, 0, 0),
            offset: Offset(1, 1),
           //   spreadRadius: -12.0,
            
              )
        ],
       
        
      ),
      child: ElevatedButton(
          style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              elevation: MaterialStateProperty.all(elevation),
              backgroundColor: MaterialStateProperty.all(!isGradient
                  ? Colors.transparent
                  : backgroundColor ?? primaryColor),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius)))),
          onPressed: onPressed,
          child: icon == null
              ? CustomText(
                  name: label,
                  color: foregroundColor ?? Colors.white,
                  fontweight: FontWeight.bold,
                  fontsize: fontSize,
                  shadows: textShadow,
                  
                )
              : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //  const Spacer(),

                    SizedBox(
                      width: 15.w,
                    ),
                    if (leadingIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: SvgIcon(path: leadingIcon!),
                      ),
                    if (isLoading)
                      const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    else
                      Text(
                        label,
                        style: TextStyle(
                          
                            fontSize: fontSize,
                            color: foregroundColor ?? Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                  //  const Spacer(),
                  SizedBox(width: 5.w,),
                    if (icon != null)
                     Padding(
                            padding: EdgeInsets.only(right: spacing),
                            child: icon!,
                          ),
                  ],
                )),
    );
  }
}


class RefractedInlineShadowButton extends StatelessWidget {
  const RefractedInlineShadowButton({
    super.key,
    this.width,
    this.text,
    this.widget,
    this.radius,
    this.height,
    this.onTap,
  });

  final double? width;
  final String? text;
  final Widget? widget;
  final double? radius;
  final double? height;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: AppColors.appVioetColor,
            borderRadius: BorderRadius.all(Radius.circular(radius ?? 5.r)),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(.4, 0),
                  color: Colors.black38,
                  blurRadius: 0,
                  spreadRadius: 1),
              BoxShadow(color: Colors.black, blurRadius: 10, spreadRadius: 5),
            ]),
        child: widget ??
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: CustomText(
                name: text ?? 'Verify',
              ),
            ),
      ),
    );
  }
}

