import 'package:flutter/material.dart';
import 'lang/en.dart';
import 'lang/es.dart';
import 'lang/fr.dart';
import 'lang/hi.dart';
import 'lang/ne.dart';

class AppLocalizations {
  final Map<String, String> strings;

  AppLocalizations(this.strings);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations) ??
        AppLocalizations({});
  }

  static Future<AppLocalizations> load(Locale locale) async {
    late Map<String, String> translations;

    switch (locale.languageCode) {
      case 'es':
        translations = spanishTranslations;
        break;
      case 'fr':
        translations = frenchTranslations;
        break;
      case 'hi':
        translations = hindiTranslations;
        break;
      case 'ne':
        translations = nepaliTranslations;
        break;
      case 'en':
      default:
        translations = englishTranslations;
        break;
    }

    return AppLocalizations(translations);
  }

  String translate(String key) => strings[key] ?? key;

  // Auth Keys
  String get appTitle => translate('app_title');
  String get loginTitle => translate('login_title');
  String get emailLabel => translate('email_label');
  String get emailHint => translate('email_hint');
  String get passwordLabel => translate('password_label');
  String get passwordHint => translate('password_hint');
  String get loginButton => translate('login_button');
  String get forgotPassword => translate('forgot_password');
  String get signUpLink => translate('sign_up_link');
  String get dontHaveAccount => translate('dont_have_account');
  String get signUp => translate('sign_up');
  String get or => translate('or');
  String get contactSupport => translate('contact_support');
  String get schoolContactMessage => translate('school_contact_message');
  String get welcomeMessage => translate('welcome_message');
  String get invalidEmail => translate('invalid_email');
  String get passwordRequired => translate('password_required');
  String get passwordMinLength => translate('password_min_length');
  String get loginError => translate('login_error');
  String get loginSuccess => translate('login_success');

  // Home Page Keys
  String get home => translate('home');
  String get goodMorning => translate('good_morning');
  String get goodAfternoon => translate('good_afternoon');
  String get goodEvening => translate('good_evening');
  String get profile => translate('profile');
  String get schedule => translate('schedule');
  String get notices => translate('notices');
  String get recentNotices => translate('recent_notices');
  String get viewMore => translate('view_more');
  String get noNotices => translate('no_notices');
  String get noNoticesAvailable => translate('no_notices_available');
  String get schoolResumes => translate('school_resumes');
  String get activeStatus => translate('active_status');
  String get menu => translate('menu');

  // Common Keys
  String get appName => translate('app_name');
  String get ok => translate('ok');
  String get cancel => translate('cancel');
  String get error => translate('error');
  String get success => translate('success');
  String get loading => translate('loading');
  String get logout => translate('logout');
  String get settings => translate('settings');
  String get language => translate('language');
  String get about => translate('about');
}
