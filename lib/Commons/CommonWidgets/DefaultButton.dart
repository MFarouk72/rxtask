import 'package:flutter/material.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';

class DefaultButton extends StatelessWidget {
  final double? width ;
  final Color? backgroundColor;
  final bool? isUpperCase;
  final double? radius;
  final Function? function;
  final String? text;

  DefaultButton({
    required this.text,
    required this.function,
    this.width = double.infinity,
    this.backgroundColor,
    this.isUpperCase = true,
    this.radius = 7.0,
  });

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
      padding: EdgeInsets.only(left: SizeConfig.padding , right: SizeConfig.padding  , top: SizeConfig.padding /2 , bottom: SizeConfig.padding /2),
      child: Container(
        width: width,
        height: SizeConfig.safeBlockVertical * 8,
        child: MaterialButton(
          onPressed: () {
            function!();
          },
          child: Text(
            isUpperCase == true ? text!.toUpperCase() : text!,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            radius!,
          ),
          color: backgroundColor ?? AppColors.BROUWN_COLOR,
        ),
      ),
    );
  }
}
