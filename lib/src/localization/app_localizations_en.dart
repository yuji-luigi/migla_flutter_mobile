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
  String get dashboard => 'Dashboard';

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
  String get labelName => 'Name (alphabet)';

  @override
  String get labelNameJapanese => 'Name (Japanese)';

  @override
  String get labelSurname => 'Surname (alphabet)';

  @override
  String get labelSurnameJapanese => 'Surname (Japanese)';

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
  String get goToHome => 'Back to home';

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
  String get fieldIsRequired => 'This field is required';

  @override
  String get japaneseOrAlphabetIsRequired =>
      'Please enter Japanese or alphabet characters';

  @override
  String get invalidEmail => 'Please enter a valid email address';

  @override
  String get pageIsUnderDevelopment =>
      'This page is under development. Please wait until it is completed.';

  @override
  String get get_me_failed_after_login =>
      'Login is succeeded but could not get user. please contact administrator';

  @override
  String get loading => 'Loading...';

  @override
  String get not_found => 'Not found';

  @override
  String get submit => 'Submit';

  @override
  String get has_been_sent => 'Sent';

  @override
  String get retry => 'Retry';

  @override
  String get publicNoContent => 'No content available yet.';

  @override
  String get publicContentUpdateAvailable =>
      'New contents are available, please wait while we update.';

  @override
  String get publicOpenFormOnWebsite => 'Open this form on our website';

  @override
  String get schoolInfo => 'School Info';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get commonOk => 'OK';

  @override
  String get commonSave => 'Save';

  @override
  String get commonEdit => 'Edit';

  @override
  String get commonDelete => 'Delete';

  @override
  String get copy => 'Copy';

  @override
  String get copied => 'Copied';

  @override
  String get optional => 'optional';

  @override
  String get tooManyAttempts =>
      'Too many attempts. Please wait a while and try again.';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get billingInfo => 'Receipt details';

  @override
  String get billingInfoAdd => 'Add receipt details';

  @override
  String get billingInfoEdit => 'Edit receipt details';

  @override
  String get billingInfoEmptyTitle => 'No receipt details yet';

  @override
  String get billingInfoEmptyDesc =>
      'This information is used as the name on your receipt and to match your bank transfers. If you pay from an account in another family member\'s name (e.g. your spouse), adding that account holder helps the school recognise the payment. You can register several and choose one when you request a receipt.';

  @override
  String get billingDefault => 'Default';

  @override
  String get billingSetAsDefault => 'Set as default';

  @override
  String get billingDeleteConfirmTitle => 'Delete these receipt details?';

  @override
  String billingDeleteConfirmBody(String label) {
    return '“$label” will be deleted. This cannot be undone.';
  }

  @override
  String get billingDeleted => 'Deleted';

  @override
  String get billingSaved => 'Saved';

  @override
  String get billingLabel => 'Label';

  @override
  String get billingLabelHint => 'e.g. Father, Mother';

  @override
  String get billingHolderName => 'Name on the receipt';

  @override
  String get billingBankAccountHolder => 'Bank account holder';

  @override
  String get billingBankAccountHolderHelper =>
      'The name on the account you pay from. Used to match your transfer when it differs from the app\'s registered user (e.g. a spouse\'s account).';

  @override
  String get billingNotes => 'Notes';

  @override
  String get billingNotesHint =>
      'Anything the school should know when issuing the receipt';

  @override
  String get billingIsDefault => 'Use as default receipt details';

  @override
  String get receiptTitle => 'Receipt';

  @override
  String get receiptBadge => 'receipt';

  @override
  String get receiptExplanation =>
      'If you need a receipt, request it here. When you do, add €2 for the revenue stamp (marca da bollo) to your bank transfer. The school issues the receipt after checking the payment.';

  @override
  String get receiptStatusNotRequested => 'Not requested';

  @override
  String get receiptStatusRequested => 'Requested';

  @override
  String get receiptStatusVerified => 'Stamp duty verified';

  @override
  String get receiptRequestButton => 'Request a receipt';

  @override
  String get receiptRequestDialogTitle => 'Request a receipt';

  @override
  String get receiptRequestDialogBody =>
      'Please add €2 for the revenue stamp to your bank transfer.';

  @override
  String get receiptChooseBillingProfile => 'Choose the addressee';

  @override
  String get receiptNoBillingProfileHint =>
      'You have not registered any receipt details yet. Adding them lets the school issue the receipt to the right name. You can still request it without.';

  @override
  String get receiptRequestWithoutProfile => 'Request without it';

  @override
  String get receiptAddressee => 'Addressee';

  @override
  String get receiptAddresseeRegistered => 'Registered receipt details';

  @override
  String get receiptNoBillingProfile =>
      'Not specified (the school will use the details on file)';

  @override
  String get receiptRequestedAt => 'Requested on';

  @override
  String get receiptConfirmationCode => 'Confirmation code';

  @override
  String get receiptConfirmationCodeHint =>
      'Please include this code in the bank transfer description (causale).';

  @override
  String get receiptCancelRequest => 'Cancel request';

  @override
  String get receiptCancelConfirmTitle => 'Cancel the request?';

  @override
  String get receiptCancelConfirmBody =>
      'Your receipt request will be cancelled and you will no longer need to add the €2 stamp duty.';

  @override
  String get receiptRequestedSnackbar => 'Receipt requested';

  @override
  String get receiptCancelledSnackbar => 'Request cancelled';

  @override
  String get receiptCannotCancelVerified =>
      'This can no longer be cancelled: the school has already verified the stamp duty payment.';

  @override
  String get deleteAccount => 'Delete account';

  @override
  String get deleteAccountConfirmTitle => 'Delete your account?';

  @override
  String get deleteAccountConfirmBody =>
      'Accounts without school records are deleted immediately.\n\nFor enrolled (or previously enrolled) families, student and payment records must be kept, so your request will be sent to the school office, who will get back to you.';

  @override
  String get deleteAccountReason => 'Reason (optional)';

  @override
  String get deleteAccountUnderstand => 'I understand';

  @override
  String get deleteAccountConfirmButton => 'Delete';

  @override
  String get deleteAccountDone =>
      'Your account has been deleted. Thank you for using MIGLA.';

  @override
  String get deleteAccountRequestedTitle => 'Request sent';

  @override
  String get deleteAccountRequestedBody =>
      'Your deletion request has been sent to the school office. Because student and payment records must be kept, the office will handle it and get back to you.';

  @override
  String get newsletterReceive => 'Receive the newsletter';

  @override
  String get newsletterPending =>
      'Waiting for confirmation: tap the link in the email to complete';

  @override
  String get newsletterSubscribed => 'Subscribed';

  @override
  String get newsletterConfirmSentTitle => 'Confirmation email sent';

  @override
  String get newsletterConfirmSent =>
      'We sent you a confirmation email. Tap the link in it to complete your subscription.';

  @override
  String get newsletterUnsubscribed =>
      'You have unsubscribed from the newsletter';

  @override
  String get registerNewsletterOptIn => 'Receive the MIGLA newsletter';

  @override
  String get registerNewsletterOptInHint =>
      'You will receive a confirmation email';

  @override
  String get registerFailed => 'Registration failed';

  @override
  String get passwordMinLength => 'Password must be at least 8 characters';

  @override
  String get inquiries => 'Contact us';

  @override
  String get inquiryNew => 'New inquiry';

  @override
  String get inquiryEmptyTitle => 'No inquiries yet';

  @override
  String get inquiryEmptyDesc =>
      'Send your questions to the school here. Replies arrive in the app and you will get a notification.';

  @override
  String get inquiryCategory => 'Category';

  @override
  String get inquiryCategoryGeneral => 'General';

  @override
  String get inquiryCategoryAdmission => 'Admission & trial';

  @override
  String get inquiryCategoryPayment => 'Payments';

  @override
  String get inquiryCategoryApp => 'App';

  @override
  String get inquiryCategoryOther => 'Other';

  @override
  String get inquiryStatusNew => 'New';

  @override
  String get inquiryStatusOpen => 'Open';

  @override
  String get inquiryStatusAnswered => 'Answered';

  @override
  String get inquiryStatusClosed => 'Closed';

  @override
  String get inquirySubject => 'Subject';

  @override
  String get inquiryMessage => 'Message';

  @override
  String get inquiryMessageHint => 'Write a message';

  @override
  String get inquiryName => 'Name';

  @override
  String get inquirySenderSchool => 'School';

  @override
  String get inquiryClosedNote =>
      'This inquiry has been closed. Please send a new inquiry for further questions.';

  @override
  String get inquirySent => 'Sent';

  @override
  String get inquirySentTitle => 'Inquiry sent';

  @override
  String get inquirySentGuest =>
      'Thank you for contacting us. The school will reply to the email address you entered.';

  @override
  String get inquiryGuestHint =>
      'If you log in first, you can read the school\'s replies in the app. Without logging in, replies are sent by email.';

  @override
  String get inquiryPrivacyConsentPrefix => 'I agree to the ';

  @override
  String get inquiryPrivacyConsentSuffix => '';

  @override
  String get inquiryPrivacyConsentRequired =>
      'You must accept the Privacy Policy';
}
