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

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

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
  /// **'Name (alphabet)'**
  String get labelName;

  /// No description provided for @labelNameJapanese.
  ///
  /// In en, this message translates to:
  /// **'Name (Japanese)'**
  String get labelNameJapanese;

  /// No description provided for @labelSurname.
  ///
  /// In en, this message translates to:
  /// **'Surname (alphabet)'**
  String get labelSurname;

  /// No description provided for @labelSurnameJapanese.
  ///
  /// In en, this message translates to:
  /// **'Surname (Japanese)'**
  String get labelSurnameJapanese;

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

  /// No description provided for @goToHome.
  ///
  /// In en, this message translates to:
  /// **'Back to home'**
  String get goToHome;

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

  /// No description provided for @fieldIsRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldIsRequired;

  /// No description provided for @japaneseOrAlphabetIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter Japanese or alphabet characters'**
  String get japaneseOrAlphabetIsRequired;

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

  /// No description provided for @get_me_failed_after_login.
  ///
  /// In en, this message translates to:
  /// **'Login is succeeded but could not get user. please contact administrator'**
  String get get_me_failed_after_login;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @not_found.
  ///
  /// In en, this message translates to:
  /// **'Not found'**
  String get not_found;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @has_been_sent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get has_been_sent;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @publicNoContent.
  ///
  /// In en, this message translates to:
  /// **'No content available yet.'**
  String get publicNoContent;

  /// No description provided for @publicContentUpdateAvailable.
  ///
  /// In en, this message translates to:
  /// **'New contents are available, please wait while we update.'**
  String get publicContentUpdateAvailable;

  /// No description provided for @publicOpenFormOnWebsite.
  ///
  /// In en, this message translates to:
  /// **'Open this form on our website'**
  String get publicOpenFormOnWebsite;

  /// No description provided for @schoolInfo.
  ///
  /// In en, this message translates to:
  /// **'School Info'**
  String get schoolInfo;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @commonOk.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get commonOk;

  /// No description provided for @commonSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @copied.
  ///
  /// In en, this message translates to:
  /// **'Copied'**
  String get copied;

  /// No description provided for @optional.
  ///
  /// In en, this message translates to:
  /// **'optional'**
  String get optional;

  /// No description provided for @tooManyAttempts.
  ///
  /// In en, this message translates to:
  /// **'Too many attempts. Please wait a while and try again.'**
  String get tooManyAttempts;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @billingInfo.
  ///
  /// In en, this message translates to:
  /// **'Receipt details'**
  String get billingInfo;

  /// No description provided for @billingInfoAdd.
  ///
  /// In en, this message translates to:
  /// **'Add receipt details'**
  String get billingInfoAdd;

  /// No description provided for @billingInfoEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit receipt details'**
  String get billingInfoEdit;

  /// No description provided for @billingInfoEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No receipt details yet'**
  String get billingInfoEmptyTitle;

  /// No description provided for @billingInfoEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'This information is used as the name on your receipt and to match your bank transfers. If you pay from an account in another family member\'s name (e.g. your spouse), adding that account holder helps the school recognise the payment. You can register several and choose one when you request a receipt.'**
  String get billingInfoEmptyDesc;

  /// No description provided for @billingDefault.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get billingDefault;

  /// No description provided for @billingSetAsDefault.
  ///
  /// In en, this message translates to:
  /// **'Set as default'**
  String get billingSetAsDefault;

  /// No description provided for @billingDeleteConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete these receipt details?'**
  String get billingDeleteConfirmTitle;

  /// No description provided for @billingDeleteConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'“{label}” will be deleted. This cannot be undone.'**
  String billingDeleteConfirmBody(String label);

  /// No description provided for @billingDeleted.
  ///
  /// In en, this message translates to:
  /// **'Deleted'**
  String get billingDeleted;

  /// No description provided for @billingSaved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get billingSaved;

  /// No description provided for @billingLabel.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get billingLabel;

  /// No description provided for @billingLabelHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Father, Mother'**
  String get billingLabelHint;

  /// No description provided for @billingHolderName.
  ///
  /// In en, this message translates to:
  /// **'Name on the receipt'**
  String get billingHolderName;

  /// No description provided for @billingBankAccountHolder.
  ///
  /// In en, this message translates to:
  /// **'Bank account holder'**
  String get billingBankAccountHolder;

  /// No description provided for @billingBankAccountHolderHelper.
  ///
  /// In en, this message translates to:
  /// **'The name on the account you pay from. Used to match your transfer when it differs from the app\'s registered user (e.g. a spouse\'s account).'**
  String get billingBankAccountHolderHelper;

  /// No description provided for @billingNotes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get billingNotes;

  /// No description provided for @billingNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Anything the school should know when issuing the receipt'**
  String get billingNotesHint;

  /// No description provided for @billingIsDefault.
  ///
  /// In en, this message translates to:
  /// **'Use as default receipt details'**
  String get billingIsDefault;

  /// No description provided for @receiptTitle.
  ///
  /// In en, this message translates to:
  /// **'Receipt'**
  String get receiptTitle;

  /// No description provided for @receiptBadge.
  ///
  /// In en, this message translates to:
  /// **'receipt'**
  String get receiptBadge;

  /// No description provided for @receiptExplanation.
  ///
  /// In en, this message translates to:
  /// **'If you need a receipt, request it here. When you do, add €2 for the revenue stamp (marca da bollo) to your bank transfer. The school issues the receipt after checking the payment.'**
  String get receiptExplanation;

  /// No description provided for @receiptStatusNotRequested.
  ///
  /// In en, this message translates to:
  /// **'Not requested'**
  String get receiptStatusNotRequested;

  /// No description provided for @receiptStatusRequested.
  ///
  /// In en, this message translates to:
  /// **'Requested'**
  String get receiptStatusRequested;

  /// No description provided for @receiptStatusVerified.
  ///
  /// In en, this message translates to:
  /// **'Stamp duty verified'**
  String get receiptStatusVerified;

  /// No description provided for @receiptRequestButton.
  ///
  /// In en, this message translates to:
  /// **'Request a receipt'**
  String get receiptRequestButton;

  /// No description provided for @receiptRequestDialogTitle.
  ///
  /// In en, this message translates to:
  /// **'Request a receipt'**
  String get receiptRequestDialogTitle;

  /// No description provided for @receiptRequestDialogBody.
  ///
  /// In en, this message translates to:
  /// **'Please add €2 for the revenue stamp to your bank transfer.'**
  String get receiptRequestDialogBody;

  /// No description provided for @receiptChooseBillingProfile.
  ///
  /// In en, this message translates to:
  /// **'Choose the addressee'**
  String get receiptChooseBillingProfile;

  /// No description provided for @receiptNoBillingProfileHint.
  ///
  /// In en, this message translates to:
  /// **'You have not registered any receipt details yet. Adding them lets the school issue the receipt to the right name. You can still request it without.'**
  String get receiptNoBillingProfileHint;

  /// No description provided for @receiptRequestWithoutProfile.
  ///
  /// In en, this message translates to:
  /// **'Request without it'**
  String get receiptRequestWithoutProfile;

  /// No description provided for @receiptAddressee.
  ///
  /// In en, this message translates to:
  /// **'Addressee'**
  String get receiptAddressee;

  /// No description provided for @receiptAddresseeRegistered.
  ///
  /// In en, this message translates to:
  /// **'Registered receipt details'**
  String get receiptAddresseeRegistered;

  /// No description provided for @receiptNoBillingProfile.
  ///
  /// In en, this message translates to:
  /// **'Not specified (the school will use the details on file)'**
  String get receiptNoBillingProfile;

  /// No description provided for @receiptRequestedAt.
  ///
  /// In en, this message translates to:
  /// **'Requested on'**
  String get receiptRequestedAt;

  /// No description provided for @receiptConfirmationCode.
  ///
  /// In en, this message translates to:
  /// **'Confirmation code'**
  String get receiptConfirmationCode;

  /// No description provided for @receiptConfirmationCodeHint.
  ///
  /// In en, this message translates to:
  /// **'Please include this code in the bank transfer description (causale).'**
  String get receiptConfirmationCodeHint;

  /// No description provided for @receiptCancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel request'**
  String get receiptCancelRequest;

  /// No description provided for @receiptCancelConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Cancel the request?'**
  String get receiptCancelConfirmTitle;

  /// No description provided for @receiptCancelConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Your receipt request will be cancelled and you will no longer need to add the €2 stamp duty.'**
  String get receiptCancelConfirmBody;

  /// No description provided for @receiptRequestedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Receipt requested'**
  String get receiptRequestedSnackbar;

  /// No description provided for @receiptCancelledSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled'**
  String get receiptCancelledSnackbar;

  /// No description provided for @receiptCannotCancelVerified.
  ///
  /// In en, this message translates to:
  /// **'This can no longer be cancelled: the school has already verified the stamp duty payment.'**
  String get receiptCannotCancelVerified;

  /// No description provided for @deleteAccount.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get deleteAccount;

  /// No description provided for @deleteAccountConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete your account?'**
  String get deleteAccountConfirmTitle;

  /// No description provided for @deleteAccountConfirmBody.
  ///
  /// In en, this message translates to:
  /// **'Accounts without school records are deleted immediately.\n\nFor enrolled (or previously enrolled) families, student and payment records must be kept, so your request will be sent to the school office, who will get back to you.'**
  String get deleteAccountConfirmBody;

  /// No description provided for @deleteAccountReason.
  ///
  /// In en, this message translates to:
  /// **'Reason (optional)'**
  String get deleteAccountReason;

  /// No description provided for @deleteAccountUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get deleteAccountUnderstand;

  /// No description provided for @deleteAccountConfirmButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get deleteAccountConfirmButton;

  /// No description provided for @deleteAccountDone.
  ///
  /// In en, this message translates to:
  /// **'Your account has been deleted. Thank you for using MIGLA.'**
  String get deleteAccountDone;

  /// No description provided for @deleteAccountRequestedTitle.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get deleteAccountRequestedTitle;

  /// No description provided for @deleteAccountRequestedBody.
  ///
  /// In en, this message translates to:
  /// **'Your deletion request has been sent to the school office. Because student and payment records must be kept, the office will handle it and get back to you.'**
  String get deleteAccountRequestedBody;

  /// No description provided for @newsletterReceive.
  ///
  /// In en, this message translates to:
  /// **'Receive the newsletter'**
  String get newsletterReceive;

  /// No description provided for @newsletterPending.
  ///
  /// In en, this message translates to:
  /// **'Waiting for confirmation: tap the link in the email to complete'**
  String get newsletterPending;

  /// No description provided for @newsletterSubscribed.
  ///
  /// In en, this message translates to:
  /// **'Subscribed'**
  String get newsletterSubscribed;

  /// No description provided for @newsletterConfirmSentTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmation email sent'**
  String get newsletterConfirmSentTitle;

  /// No description provided for @newsletterConfirmSent.
  ///
  /// In en, this message translates to:
  /// **'We sent you a confirmation email. Tap the link in it to complete your subscription.'**
  String get newsletterConfirmSent;

  /// No description provided for @newsletterUnsubscribed.
  ///
  /// In en, this message translates to:
  /// **'You have unsubscribed from the newsletter'**
  String get newsletterUnsubscribed;

  /// No description provided for @registerNewsletterOptIn.
  ///
  /// In en, this message translates to:
  /// **'Receive the MIGLA newsletter'**
  String get registerNewsletterOptIn;

  /// No description provided for @registerNewsletterOptInHint.
  ///
  /// In en, this message translates to:
  /// **'You will receive a confirmation email'**
  String get registerNewsletterOptInHint;

  /// No description provided for @registerFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed'**
  String get registerFailed;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @inquiries.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get inquiries;

  /// No description provided for @inquiryNew.
  ///
  /// In en, this message translates to:
  /// **'New inquiry'**
  String get inquiryNew;

  /// No description provided for @inquiryEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No inquiries yet'**
  String get inquiryEmptyTitle;

  /// No description provided for @inquiryEmptyDesc.
  ///
  /// In en, this message translates to:
  /// **'Send your questions to the school here. Replies arrive in the app and you will get a notification.'**
  String get inquiryEmptyDesc;

  /// No description provided for @inquiryCategory.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get inquiryCategory;

  /// No description provided for @inquiryCategoryGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get inquiryCategoryGeneral;

  /// No description provided for @inquiryCategoryAdmission.
  ///
  /// In en, this message translates to:
  /// **'Admission & trial'**
  String get inquiryCategoryAdmission;

  /// No description provided for @inquiryCategoryPayment.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get inquiryCategoryPayment;

  /// No description provided for @inquiryCategoryApp.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get inquiryCategoryApp;

  /// No description provided for @inquiryCategoryOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get inquiryCategoryOther;

  /// No description provided for @inquiryStatusNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get inquiryStatusNew;

  /// No description provided for @inquiryStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get inquiryStatusOpen;

  /// No description provided for @inquiryStatusAnswered.
  ///
  /// In en, this message translates to:
  /// **'Answered'**
  String get inquiryStatusAnswered;

  /// No description provided for @inquiryStatusClosed.
  ///
  /// In en, this message translates to:
  /// **'Closed'**
  String get inquiryStatusClosed;

  /// No description provided for @inquirySubject.
  ///
  /// In en, this message translates to:
  /// **'Subject'**
  String get inquirySubject;

  /// No description provided for @inquiryMessage.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get inquiryMessage;

  /// No description provided for @inquiryMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Write a message'**
  String get inquiryMessageHint;

  /// No description provided for @inquiryName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get inquiryName;

  /// No description provided for @inquirySenderSchool.
  ///
  /// In en, this message translates to:
  /// **'School'**
  String get inquirySenderSchool;

  /// No description provided for @inquiryClosedNote.
  ///
  /// In en, this message translates to:
  /// **'This inquiry has been closed. Please send a new inquiry for further questions.'**
  String get inquiryClosedNote;

  /// No description provided for @inquirySent.
  ///
  /// In en, this message translates to:
  /// **'Sent'**
  String get inquirySent;

  /// No description provided for @inquirySentTitle.
  ///
  /// In en, this message translates to:
  /// **'Inquiry sent'**
  String get inquirySentTitle;

  /// No description provided for @inquirySentGuest.
  ///
  /// In en, this message translates to:
  /// **'Thank you for contacting us. The school will reply to the email address you entered.'**
  String get inquirySentGuest;

  /// No description provided for @inquiryGuestHint.
  ///
  /// In en, this message translates to:
  /// **'If you log in first, you can read the school\'s replies in the app. Without logging in, replies are sent by email.'**
  String get inquiryGuestHint;

  /// No description provided for @inquiryPrivacyConsentPrefix.
  ///
  /// In en, this message translates to:
  /// **'I agree to the '**
  String get inquiryPrivacyConsentPrefix;

  /// No description provided for @inquiryPrivacyConsentSuffix.
  ///
  /// In en, this message translates to:
  /// **''**
  String get inquiryPrivacyConsentSuffix;

  /// No description provided for @inquiryPrivacyConsentRequired.
  ///
  /// In en, this message translates to:
  /// **'You must accept the Privacy Policy'**
  String get inquiryPrivacyConsentRequired;

  /// No description provided for @changePasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePasswordTitle;

  /// No description provided for @changePasswordForcedMessage.
  ///
  /// In en, this message translates to:
  /// **'This is your first login. Please set your own password to continue.'**
  String get changePasswordForcedMessage;

  /// No description provided for @changePasswordCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get changePasswordCurrent;

  /// No description provided for @changePasswordNew.
  ///
  /// In en, this message translates to:
  /// **'New password (8+ characters)'**
  String get changePasswordNew;

  /// No description provided for @changePasswordConfirm.
  ///
  /// In en, this message translates to:
  /// **'New password (confirm)'**
  String get changePasswordConfirm;

  /// No description provided for @changePasswordSubmit.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get changePasswordSubmit;

  /// No description provided for @changePasswordRequired.
  ///
  /// In en, this message translates to:
  /// **'Please fill in this field'**
  String get changePasswordRequired;

  /// No description provided for @changePasswordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get changePasswordTooShort;

  /// No description provided for @changePasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'The new passwords do not match'**
  String get changePasswordMismatch;

  /// No description provided for @changePasswordSameAsCurrent.
  ///
  /// In en, this message translates to:
  /// **'Choose a password different from the current one'**
  String get changePasswordSameAsCurrent;

  /// No description provided for @changePasswordWrongCurrent.
  ///
  /// In en, this message translates to:
  /// **'The current password is incorrect'**
  String get changePasswordWrongCurrent;

  /// No description provided for @changePasswordDone.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed'**
  String get changePasswordDone;

  /// No description provided for @forgotPasswordSent.
  ///
  /// In en, this message translates to:
  /// **'If this email is registered, we have sent a link to reset your password. Please check your inbox.'**
  String get forgotPasswordSent;

  /// No description provided for @forgotPasswordFailed.
  ///
  /// In en, this message translates to:
  /// **'Could not send the email. Please try again later.'**
  String get forgotPasswordFailed;
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
