import 'package:flutter/material.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'package:rxtask/utilites/SizeConfig.dart';
import 'package:rxtask/localization/localizations.dart';

class AboutAppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.aboutApp),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          child: Text(
              AppLocalizations.of(context)!.aboutApp,
            style: TextStyle(
              color: AppColors.BLACK_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: SizeConfig.textFontSize,
            ),
          ),
        ),
      ),
    );
  }
}
