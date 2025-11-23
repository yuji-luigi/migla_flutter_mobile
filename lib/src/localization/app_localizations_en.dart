// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String helloExample(String name) {
    return 'Hello, $name!';
  }

  @override
  String nWombats(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count wombats',
      one: '1 wombat',
      zero: 'no wombats',
    );
    return '$_temp0';
  }

  @override
  String get appTitle => 'migla_flutter';

  @override
  String get welcomeToMigla => 'Welcome to Migla';

  @override
  String get welcomeBack => 'Welcome back!';

  @override
  String get welcomeDesc => 'Let\'s be together in your child\'s progress!';

  @override
  String get getStarted => 'Get Started';

  @override
  String get registerDesc => 'Register to start';

  @override
  String get labelName => 'Name';

  @override
  String get labelSurname => 'Surname';

  @override
  String get labelEmail => 'Email';

  @override
  String get labelPassword => 'Password';

  @override
  String get labelConfirmPassword => 'Confirm Password';

  @override
  String get register => 'Register';

  @override
  String get login => 'Login';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get forgotPassword => 'Forgot password?';

  @override
  String get dashboardHomeScreenHeader =>
      'Let\'s be together in your child\'s progress!';

  @override
  String get teacherReport => 'Teacher report';

  @override
  String get photoAndVideo => 'Photo and Video';

  @override
  String get notificationTextButton => 'Notification';

  @override
  String get photoAndVideoTextButton => 'Photo and Video';

  @override
  String get settings => 'Settings';

  @override
  String get logout => 'Logout';

  @override
  String get weekButtonText => 'Week';

  @override
  String get categoryButtonText => 'Category';

  @override
  String get otherButtonText => 'Other';

  @override
  String get notificationTitle => 'Notification';

  @override
  String get markAsRead => 'Mark as read';

  @override
  String get navGallery => 'Gallery';

  @override
  String get navSettings => 'Settings';

  @override
  String get settingScreenLanguage => 'Language';

  @override
  String get pushNotificationSetting => 'Push Notification';

  @override
  String get selectStudent => 'Which child\'s information do you want to see?';

  @override
  String get switchStudent => 'Switch Student';

  @override
  String get home_title_noStudent =>
      'You don\'t have any children yet. Please contact your school.';

  @override
  String get home_pleaseSelectStudent =>
      'Which child\'s information do you want to see?\n (not selected yet)';

  @override
  String get downloadModal_title => 'Download';

  @override
  String get downloadModal_description =>
      'Are you sure you want to download this file?';

  @override
  String get download => 'Download';

  @override
  String get cancel => 'Cancel';

  @override
  String get attachments => 'Attachments';

  @override
  String get error_somethingWentWrong => 'Something went wrong';

  @override
  String get refreshPage => 'Refresh page';

  @override
  String get noReportsFound => 'There is no report for this student';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get noNotificationsFound => 'There are no notifications';

  @override
  String get noGalleriesFound => 'There are no galleries';

  @override
  String get rememberMe => 'Remember me';

  @override
  String get navPayment => 'Payment';

  @override
  String get paidCondition => 'Paid';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get completed => 'Completed';

  @override
  String get notCompleted => 'Not completed';

  @override
  String get paymentDueDate => 'Payment due date';

  @override
  String get dueDate => 'Due date';

  @override
  String get noPaymentRecordFound => 'No payment record found';

  @override
  String get paymentCompleted => 'Payment Completed';

  @override
  String get paymentPending => 'Payment Pending';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get paymentSchedule => 'Payment Schedule';

  @override
  String get title => 'Title';

  @override
  String get alertMessage => 'Alert Message';

  @override
  String get body => 'Body';

  @override
  String get createdAt => 'Created At';

  @override
  String get paymentDetails => 'Payment Details';

  @override
  String get tuitionFee => 'Tuition Fee';

  @override
  String get studentCount => 'Student Count';

  @override
  String get materialFee => 'Material Fee';

  @override
  String get materialFeeDescription => 'Material Fee Description';

  @override
  String get purchases => 'Purchases';

  @override
  String get quantity => 'Quantity';

  @override
  String get noDataFound => 'No data found';

  @override
  String get forgotPasswordScreenHeader => 'Forgot password?';

  @override
  String get forgotPasswordEmailInputLabel =>
      'Please enter your email address to reset your password';

  @override
  String get back => 'Back';

  @override
  String get labelEmailRequired => 'Please enter your email address';

  @override
  String get labelPasswordRequired => 'Please enter your password';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get pageIsUnderDevelopment =>
      'This page is under development. Please wait until it is completed.';
}
