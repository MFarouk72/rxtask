import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rxtask/ViewAllFriends/View/ViewAllFriendsView.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rxtask/utilites/Constants/AppColors.dart';
import 'localization/LocaleHelper.dart';
import 'localization/localizations.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late SpecificLocalizationDelegate _specificLocalizationDelegate;
  @override
  void initState() {
    super.initState();
    helper.onLocaleChanged = onLocaleChange;
    _specificLocalizationDelegate =
        SpecificLocalizationDelegate(new Locale('en'));
  }
  onLocaleChange(Locale locale) {
    if (this.mounted) {
      setState(() {
        _specificLocalizationDelegate =
        new SpecificLocalizationDelegate(locale);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RxDart Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
        _specificLocalizationDelegate
      ],
      supportedLocales: [
        Locale('en'),
        Locale('ar'),
      ],
      locale: _specificLocalizationDelegate.overriddenLocale,
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.WHITE_COLOR,
        appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
              color: AppColors.BLACK_COLOR,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor:AppColors.WHITE_COLOR,
              statusBarIconBrightness: Brightness.dark,
            ),
            backgroundColor: AppColors.WHITE_COLOR,
            elevation: 0,
            iconTheme: IconThemeData(
              color: Colors.black,
            )
        ),
      ),
      home: ViewAllFriendsView(),
    );
  }
}
