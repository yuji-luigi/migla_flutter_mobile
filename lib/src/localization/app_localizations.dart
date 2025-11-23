import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'localization/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('it'),
    Locale('ja')
  ];

  /// A greeting message with a name
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String helloExample(String name);

  /// No description provided for @nWombats.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no wombats} =1{1 wombat} other{{count} wombats}}'**
  String nWombats(num count);

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'migla_flutter'**
  String get appTitle;

  /// No description provided for @welcomeToMigla.
  ///
  /// In en, this message translates to:
  /// **'Welcome to Migla'**
  String get welcomeToMigla;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome back!'**
  String get welcomeBack;

  /// No description provided for @welcomeDesc.
  ///
  /// In en, this message translates to:
  /// **'Let\'s be together in your child\'s progress!'**
  String get welcomeDesc;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @registerDesc.
  ///
  /// In en, this message translates to:
  /// **'Register to start'**
  String get registerDesc;

  /// No description provided for @labelName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get labelName;

  /// No description provided for @labelSurname.
  ///
  /// In en, this message translates to:
  /// **'Surname'**
  String get labelSurname;

  /// No description provided for @labelEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get labelEmail;

  /// No description provided for @labelPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get labelPassword;

  /// No description provided for @labelConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get labelConfirmPassword;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @noAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get noAccount;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @dashboardHomeScreenHeader.
  ///
  /// In en, this message translates to:
  /// **'Let\'s be together in your child\'s progress!'**
  String get dashboardHomeScreenHeader;

  /// No description provided for @teacherReport.
  ///
  /// In en, this message translates to:
  /// **'Teacher report'**
  String get teacherReport;

  /// No description provided for @photoAndVideo.
  ///
  /// In en, this message translates to:
  /// **'Photo and Video'**
  String get photoAndVideo;

  /// No description provided for @notificationTextButton.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationTextButton;

  /// No description provided for @photoAndVideoTextButton.
  ///
  /// In en, this message translates to:
  /// **'Photo and Video'**
  String get photoAndVideoTextButton;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @weekButtonText.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get weekButtonText;

  /// No description provided for @categoryButtonText.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get categoryButtonText;

  /// No description provided for @otherButtonText.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get otherButtonText;

  /// No description provided for @notificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Notification'**
  String get notificationTitle;

  /// No description provided for @markAsRead.
  ///
  /// In en, this message translates to:
  /// **'Mark as read'**
  String get markAsRead;

  /// No description provided for @navGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get navGallery;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @settingScreenLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingScreenLanguage;

  /// No description provided for @pushNotificationSetting.
  ///
  /// In en, this message translates to:
  /// **'Push Notification'**
  String get pushNotificationSetting;

  /// No description provided for @selectStudent.
  ///
  /// In en, this message translates to:
  /// **'Which child\'s information do you want to see?'**
  String get selectStudent;

  /// No description provided for @switchStudent.
  ///
  /// In en, this message translates to:
  /// **'Switch Student'**
  String get switchStudent;

  /// No description provided for @home_title_noStudent.
  ///
  /// In en, this message translates to:
  /// **'You don\'t have any children yet. Please contact your school.'**
  String get home_title_noStudent;

  /// No description provided for @home_pleaseSelectStudent.
  ///
  /// In en, this message translates to:
  /// **'Which child\'s information do you want to see?\n (not selected yet)'**
  String get home_pleaseSelectStudent;

  /// No description provided for @downloadModal_title.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get downloadModal_title;

  /// No description provided for @downloadModal_description.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to download this file?'**
  String get downloadModal_description;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @attachments.
  ///
  /// In en, this message translates to:
  /// **'Attachments'**
  String get attachments;

  /// No description provided for @error_somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get error_somethingWentWrong;

  /// No description provided for @refreshPage.
  ///
  /// In en, this message translates to:
  /// **'Refresh page'**
  String get refreshPage;

  /// No description provided for @noReportsFound.
  ///
  /// In en, this message translates to:
  /// **'There is no report for this student'**
  String get noReportsFound;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @noNotificationsFound.
  ///
  /// In en, this message translates to:
  /// **'There are no notifications'**
  String get noNotificationsFound;

  /// No description provided for @noGalleriesFound.
  ///
  /// In en, this message translates to:
  /// **'There are no galleries'**
  String get noGalleriesFound;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @navPayment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get navPayment;

  /// No description provided for @paidCondition.
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get paidCondition;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @completed.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get completed;

  /// No description provided for @notCompleted.
  ///
  /// In en, this message translates to:
  /// **'Not completed'**
  String get notCompleted;

  /// No description provided for @paymentDueDate.
  ///
  /// In en, this message translates to:
  /// **'Payment due date'**
  String get paymentDueDate;

  /// No description provided for @dueDate.
  ///
  /// In en, this message translates to:
  /// **'Due date'**
  String get dueDate;

  /// No description provided for @noPaymentRecordFound.
  ///
  /// In en, this message translates to:
  /// **'No payment record found'**
  String get noPaymentRecordFound;

  /// No description provided for @paymentCompleted.
  ///
  /// In en, this message translates to:
  /// **'Payment Completed'**
  String get paymentCompleted;

  /// No description provided for @paymentPending.
  ///
  /// In en, this message translates to:
  /// **'Payment Pending'**
  String get paymentPending;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @paymentSchedule.
  ///
  /// In en, this message translates to:
  /// **'Payment Schedule'**
  String get paymentSchedule;

  /// No description provided for @title.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get title;

  /// No description provided for @alertMessage.
  ///
  /// In en, this message translates to:
  /// **'Alert Message'**
  String get alertMessage;

  /// No description provided for @body.
  ///
  /// In en, this message translates to:
  /// **'Body'**
  String get body;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get createdAt;

  /// No description provided for @paymentDetails.
  ///
  /// In en, this message translates to:
  /// **'Payment Details'**
  String get paymentDetails;

  /// No description provided for @tuitionFee.
  ///
  /// In en, this message translates to:
  /// **'Tuition Fee'**
  String get tuitionFee;

  /// No description provided for @studentCount.
  ///
  /// In en, this message translates to:
  /// **'Student Count'**
  String get studentCount;

  /// No description provided for @materialFee.
  ///
  /// In en, this message translates to:
  /// **'Material Fee'**
  String get materialFee;

  /// No description provided for @materialFeeDescription.
  ///
  /// In en, this message translates to:
  /// **'Material Fee Description'**
  String get materialFeeDescription;

  /// No description provided for @purchases.
  ///
  /// In en, this message translates to:
  /// **'Purchases'**
  String get purchases;

  /// No description provided for @quantity.
  ///
  /// In en, this message translates to:
  /// **'Quantity'**
  String get quantity;

  /// No description provided for @noDataFound.
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get noDataFound;

  /// No description provided for @forgotPasswordScreenHeader.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPasswordScreenHeader;

  /// No description provided for @forgotPasswordEmailInputLabel.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address to reset your password'**
  String get forgotPasswordEmailInputLabel;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @labelEmailRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email address'**
  String get labelEmailRequired;

  /// No description provided for @labelPasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get labelPasswordRequired;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get invalidEmail;

  /// No description provided for @pageIsUnderDevelopment.
  ///
  /// In en, this message translates to:
  /// **'This page is under development. Please wait until it is completed.'**
  String get pageIsUnderDevelopment;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'it', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'it':
      return AppLocalizationsIt();
    case 'ja':
      return AppLocalizationsJa();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
