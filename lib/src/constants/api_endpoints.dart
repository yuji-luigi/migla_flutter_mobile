const String apiUrlForgotPassword = '/users/auth/forgot-password';
const String apiUrlMe = '/users/me';
const String apiUrlChangePassword = '/users/me/change-password';
const String apiUrlLogout = '/users/logout';
const String apiUrlFcmToken = '/fcmTokens';
const String apiUrlNotifications = '/notifications';
const String apiUrlNotificationByCollectionAndRecordId =
    '/notifications/by-collection-and-record-id';
const String apiUrlRegister = '/users/auth/mobile/register?role-name=parent';
const String apiUrlBillingProfiles = '/billing-profiles';
String apiUrlPaymentRecordReceipt(int paymentRecordId) =>
    '/payment-records/$paymentRecordId/receipt';
const String apiUrlDeleteAccount = '/users/me/delete-account';
const String apiUrlNewsletterMe = '/newsletter-subscribers/me';
const String apiUrlNewsletterSubscribe = '/newsletter-subscribers/subscribe';
const String apiUrlInquiries = '/inquiries';
const String apiUrlInquirySubmit = '/inquiries/submit';
const String apiUrlInquiryMessages = '/inquiry-messages';
String apiUrlInquiryPostMessage(String inquiryId) =>
    '/inquiries/$inquiryId/messages';
String apiUrlInquiryRead(String inquiryId) => '/inquiries/$inquiryId/read';
const String privacyPolicyUrl = 'https://migla.school/privacy-policy';
