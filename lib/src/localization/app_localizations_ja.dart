// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String helloExample(String name) {
    return 'こんにちは、$name!';
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
  String get welcomeToMigla => 'ようこそ、MIGLAへ';

  @override
  String get welcomeBack => 'ようこそ、MIGLAへ';

  @override
  String get welcomeDesc => 'あなたの子供の成長を一緒に見守りましょう！';

  @override
  String get getStarted => 'はじめる';

  @override
  String get registerDesc => '新規登録して始めましょう';

  @override
  String get labelName => '名前(アルファベット)';

  @override
  String get labelSurname => '苗字(アルファベット)';

  @override
  String get labelEmail => 'メールアドレス';

  @override
  String get labelPassword => 'パスワード';

  @override
  String get labelConfirmPassword => 'パスワードの確認';

  @override
  String get register => '登録する';

  @override
  String get login => 'ログイン';

  @override
  String get alreadyHaveAccount => 'アカウントをお持ちですか？';

  @override
  String get noAccount => 'アカウントをお持ちでない方は、こちらから';

  @override
  String get forgotPassword => 'パスワードを忘れた方は、こちらから';

  @override
  String get dashboardHomeScreenHeader => 'あなたの子供の成長を一緒に見守りましょう！';

  @override
  String get teacherReport => '先生からの通信';

  @override
  String get photoAndVideo => '写真とビデオ';

  @override
  String get notificationTextButton => '通知';

  @override
  String get photoAndVideoTextButton => '写真とビデオ';

  @override
  String get settings => '設定';

  @override
  String get logout => 'ログアウト';

  @override
  String get weekButtonText => '週間';

  @override
  String get categoryButtonText => 'カテゴリー';

  @override
  String get otherButtonText => 'その他';

  @override
  String get notificationTitle => '通知';

  @override
  String get markAsRead => '既読にする';

  @override
  String get navGallery => 'ギャラリー';

  @override
  String get navSettings => '設定';

  @override
  String get settingScreenLanguage => '言語';

  @override
  String get pushNotificationSetting => 'プッシュ通知';

  @override
  String get selectStudent => 'どの子供の情報を見ますか？';

  @override
  String get switchStudent => '交代';

  @override
  String get home_title_noStudent => 'あなたの子供がまだ登録されていません。学校にお問い合わせください。';

  @override
  String get home_pleaseSelectStudent => 'どの子供の情報を見ますか？\n(まだ選択されていません)';

  @override
  String get downloadModal_title => 'ダウンロード';

  @override
  String get downloadModal_description => 'このファイルをダウンロードしますか？';

  @override
  String get download => 'ダウンロード';

  @override
  String get cancel => 'キャンセル';

  @override
  String get attachments => '添付ファイル';

  @override
  String get error_somethingWentWrong => 'エラーが発生しました';

  @override
  String get refreshPage => 'ページを更新';

  @override
  String get noReportsFound => 'この子供には先生からの通信がありません';

  @override
  String get somethingWentWrong => 'エラーが発生しました';

  @override
  String get noNotificationsFound => '通知はありません';

  @override
  String get noGalleriesFound => 'ギャラリーはありません';

  @override
  String get rememberMe => 'ログイン情報を保存する';

  @override
  String get navPayment => '支払い';

  @override
  String get paidCondition => '支払い状況';

  @override
  String get yes => 'はい';

  @override
  String get no => 'いいえ';

  @override
  String get completed => '完了';

  @override
  String get notCompleted => '未完了';

  @override
  String get paymentDueDate => '支払い期限';

  @override
  String get dueDate => '締め切り';

  @override
  String get noPaymentRecordFound => '支払い記録が見つかりません';

  @override
  String get paymentCompleted => '支払い完了';

  @override
  String get paymentPending => '支払い待ち';

  @override
  String get totalAmount => '合計金額';

  @override
  String get paymentSchedule => '支払いスケジュール';

  @override
  String get title => 'タイトル';

  @override
  String get alertMessage => 'アラートメッセージ';

  @override
  String get body => '本文';

  @override
  String get createdAt => '作成日時';

  @override
  String get paymentDetails => '支払い詳細';

  @override
  String get tuitionFee => '授業料';

  @override
  String get studentCount => '生徒数';

  @override
  String get materialFee => '教材費';

  @override
  String get materialFeeDescription => '教材費説明';

  @override
  String get purchases => '購入品';

  @override
  String get quantity => '数量';

  @override
  String get noDataFound => 'データが見つかりません';

  @override
  String get forgotPasswordScreenHeader => 'パスワードを忘れた方は、こちらから';

  @override
  String get forgotPasswordEmailInputLabel =>
      'パスワードをリセットするために、メールアドレスを入力してください';

  @override
  String get back => '戻る';

  @override
  String get labelEmailRequired => 'メールアドレスを入力してください';

  @override
  String get labelPasswordRequired => 'パスワードを入力してください';

  @override
  String get invalidEmail => 'メールアドレスが無効です';

  @override
  String get pageIsUnderDevelopment => 'このページは開発中です。開発が完了するまでしばらくお待ちください。';

  @override
  String get get_me_failed_after_login =>
      'ログインは成功しましたが、ユーザー情報を取得できませんでした。管理者にお問い合わせください。';

  @override
  String get loading => '読み込み中...';

  @override
  String get not_found => '見つかりません';

  @override
  String get submit => '送信';

  @override
  String get has_been_sent => '送信されました。';
}
