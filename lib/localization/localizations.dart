import 'dart:async';
import 'dart:ui';

import 'l10n/messages_all.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static Future<AppLocalizations> load(Locale locale) {
    final String name =
        locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  String get locale => Intl.message('en', name: 'locale');

  String get yourFriends => Intl.message('Your Friends', name: 'yourFriends');

  String get addNewFriends =>
      Intl.message('Add New Friend', name: 'addNewFriends');

  String get firstName => Intl.message('First Name', name: 'firstName');

  String get lastName => Intl.message('Last Name', name: 'lastName');

  String get email => Intl.message('Email', name: 'email');

  String get phone => Intl.message('Phone', name: 'phone');

  String get address => Intl.message('Address', name: 'address');

  String get save => Intl.message('Save', name: 'save');

  String get editFriendInformation =>
      Intl.message('Edit Friend Information', name: 'editFriendInformation');

  String get edit => Intl.message('Edit', name: 'edit');

  String get friendInformation =>
      Intl.message('friend Information', name: 'friendInformation');

  String get name => Intl.message('Name', name: 'name');

  String get male => Intl.message('Male', name: 'male');

  String get female => Intl.message('Female', name: 'female');

  String get selectGender =>
      Intl.message('Select Gender', name: 'selectGender');

  String get passwordValidation =>
      Intl.message('Please enter your password correctly EX: 12345Aa@',
          name: 'passwordValidation');

  String get emailValidation =>
      Intl.message('Please enter your email correctly',
          name: 'emailValidation');

  String get userNameValidation =>
      Intl.message('Please enter your username correctly minimum 8 character',
          name: 'userNameValidation');

  String get nameValidation =>
      Intl.message('Please enter your name correctly minimum 3 character',
          name: 'nameValidation');

  String get userNameValidationArabic =>
      Intl.message('User name not accept arabic character',
          name: 'userNameValidationArabic');

  String get phoneValidation =>
      Intl.message('Please enter your phone correctly',
          name: 'phoneValidation');

  String get emailOrUserNameValidation =>
      Intl.message('Please enter a valid email Or username',
          name: 'emailOrUserNameValidation');
  String get pleaseEnter=>Intl.message('Please enter ', name: 'pleaseEnter');
  String get photoValidation =>
      Intl.message('Please choose photo',
          name: 'photoValidation');
  String get profileScreen=>Intl.message('Profile Screen ', name: 'profileScreen');

  String get aboutApp => Intl.message('About App', name: 'aboutApp');

  String get addYourProfileInfo =>
      Intl.message('Add Your Profile Info', name: 'addYourProfileInfo');
  String get getYourAddressFromTheMap =>
      Intl.message('Get your address from the map', name: 'getYourAddressFromTheMap');
  String get viewAllInfo =>
      Intl.message('View All Info', name: 'viewAllInfo');
  String get mapScreen =>
      Intl.message('Map Screen', name: 'mapScreen');
  String get kmFromYou =>
      Intl.message('Km From You', name: 'kmFromYou');
  String get selectedLocation =>
      Intl.message('Selected Location :', name: 'selectedLocation');

}

class SpecificLocalizationDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  final Locale overriddenLocale;

  SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<AppLocalizations> load(Locale locale) =>
      AppLocalizations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) => true;
}
