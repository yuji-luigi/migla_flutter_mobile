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
  String get dashboard => 'ダッシュボード';

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
  String get labelNameJapanese => '名前(日本語)';

  @override
  String get labelSurname => '苗字(アルファベット)';

  @override
  String get labelSurnameJapanese => '苗字(日本語)';

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
  String get goToHome => 'ホームに戻る';

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
  String get fieldIsRequired => 'このフィールドは必須です';

  @override
  String get japaneseOrAlphabetIsRequired => '日本語またはアルファベットのフィールドを入力してください';

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

  @override
  String get retry => '再試行';

  @override
  String get publicNoContent => '表示できるコンテンツがまだありません。';

  @override
  String get publicContentUpdateAvailable => '新しいコンテンツがあります。更新しますので少々お待ちください。';

  @override
  String get publicOpenFormOnWebsite => 'ウェブサイトでこのフォームを開く';

  @override
  String get schoolInfo => '学校案内';

  @override
  String get passwordsDoNotMatch => 'パスワードが一致しません';

  @override
  String get commonOk => 'OK';

  @override
  String get commonSave => '保存する';

  @override
  String get commonEdit => '編集';

  @override
  String get commonDelete => '削除';

  @override
  String get copy => 'コピー';

  @override
  String get copied => 'コピーしました';

  @override
  String get optional => '任意';

  @override
  String get tooManyAttempts => '試行回数が多すぎます。しばらく時間をおいてから再度お試しください。';

  @override
  String get privacyPolicy => 'プライバシーポリシー';

  @override
  String get billingInfo => '領収書の宛名';

  @override
  String get billingInfoAdd => '宛名を追加';

  @override
  String get billingInfoEdit => '宛名を編集';

  @override
  String get billingInfoEmptyTitle => '領収書の宛名はまだ登録されていません';

  @override
  String get billingInfoEmptyDesc =>
      'ここで登録した情報は、領収書の宛名と、お振込みの照合に使われます。アプリの登録者とは別のご家族（例：配偶者）名義の口座から振り込む場合は、その振込名義を登録しておくと学校で入金を確認しやすくなります。複数登録して、申請時に選ぶこともできます。';

  @override
  String get billingDefault => 'デフォルト';

  @override
  String get billingSetAsDefault => 'デフォルトに設定';

  @override
  String get billingDeleteConfirmTitle => 'この宛名を削除しますか？';

  @override
  String billingDeleteConfirmBody(String label) {
    return '「$label」を削除します。この操作は取り消せません。';
  }

  @override
  String get billingDeleted => '削除しました';

  @override
  String get billingSaved => '保存しました';

  @override
  String get billingLabel => 'ラベル';

  @override
  String get billingLabelHint => '例：父、母';

  @override
  String get billingHolderName => '領収書の宛名';

  @override
  String get billingBankAccountHolder => '振込名義（銀行口座の名義）';

  @override
  String get billingBankAccountHolderHelper =>
      'お振込みに使う口座の名義。アプリの登録者と異なる場合（例：配偶者名義）の照合に使います。';

  @override
  String get billingNotes => '備考';

  @override
  String get billingNotesHint => '領収書の発行にあたって学校へ伝えたいことがあればご記入ください';

  @override
  String get billingIsDefault => 'この宛名をデフォルトにする';

  @override
  String get receiptTitle => '領収書';

  @override
  String get receiptBadge => '領収書';

  @override
  String get receiptExplanation =>
      '領収書が必要な場合は、ここから申請してください。申請した場合は、お支払い額に印紙代（marca da bollo）2€を加えてお振込みください。学校で入金を確認後、領収書を発行します。';

  @override
  String get receiptStatusNotRequested => '未申請';

  @override
  String get receiptStatusRequested => '申請済み';

  @override
  String get receiptStatusVerified => '印紙代確認済み';

  @override
  String get receiptRequestButton => '領収書を申請する';

  @override
  String get receiptRequestDialogTitle => '領収書の申請';

  @override
  String get receiptRequestDialogBody => 'お支払い額に印紙代2€を加えてお振込みください。';

  @override
  String get receiptChooseBillingProfile => '宛名を選択してください';

  @override
  String get receiptNoBillingProfileHint =>
      '領収書の宛名がまだ登録されていません。登録しておくと、正しい宛名で領収書を発行できます。登録せずに申請することもできます。';

  @override
  String get receiptRequestWithoutProfile => '登録せずに申請';

  @override
  String get receiptAddressee => '宛名';

  @override
  String get receiptAddresseeRegistered => '登録済みの宛名';

  @override
  String get receiptNoBillingProfile => '未指定（学校に登録されている情報を使用）';

  @override
  String get receiptRequestedAt => '申請日';

  @override
  String get receiptConfirmationCode => '確認コード';

  @override
  String get receiptConfirmationCodeHint =>
      'お振込みの際は、振込の説明欄（causale）にこのコードを記入してください。';

  @override
  String get receiptCancelRequest => '申請を取り消す';

  @override
  String get receiptCancelConfirmTitle => '申請を取り消しますか？';

  @override
  String get receiptCancelConfirmBody => '領収書の申請を取り消します。印紙代2€の追加は不要になります。';

  @override
  String get receiptRequestedSnackbar => '領収書を申請しました';

  @override
  String get receiptCancelledSnackbar => '申請を取り消しました';

  @override
  String get receiptCannotCancelVerified => '学校で印紙代の入金を確認済みのため、取り消しできません。';

  @override
  String get deleteAccount => 'アカウント削除';

  @override
  String get deleteAccountConfirmTitle => 'アカウントを削除しますか？';

  @override
  String get deleteAccountConfirmBody =>
      '在籍記録のないアカウントは、すぐに削除されます。\n\n在籍中・在籍歴のあるご家庭の場合、生徒情報や支払い記録は法令等により一定期間保管する必要があるため、削除のご依頼を学校事務局へお送りします。事務局で確認のうえ、ご連絡いたします。';

  @override
  String get deleteAccountReason => '削除の理由（任意）';

  @override
  String get deleteAccountUnderstand => '上記の内容を理解しました';

  @override
  String get deleteAccountConfirmButton => '削除する';

  @override
  String get deleteAccountDone => 'アカウントを削除しました。ご利用ありがとうございました。';

  @override
  String get deleteAccountRequestedTitle => '削除依頼を送信しました';

  @override
  String get deleteAccountRequestedBody =>
      '学校事務局にアカウント削除の依頼を送信しました。生徒情報や支払い記録の保管が必要なため、事務局で確認のうえ対応いたします。完了までしばらくお待ちください。';

  @override
  String get newsletterReceive => 'ニュースレターを受け取る';

  @override
  String get newsletterPending => '確認待ち：メール内のリンクをタップすると登録が完了します';

  @override
  String get newsletterSubscribed => '登録済み';

  @override
  String get newsletterConfirmSentTitle => '確認メールを送信しました';

  @override
  String get newsletterConfirmSent => '確認メールを送信しました。メール内のリンクで登録が完了します。';

  @override
  String get newsletterUnsubscribed => 'ニュースレターの配信を停止しました';

  @override
  String get registerNewsletterOptIn => 'MIGLAのニュースレターを受け取る';

  @override
  String get registerNewsletterOptInHint => '登録後に確認メールが届きます';

  @override
  String get registerFailed => '登録できませんでした';

  @override
  String get passwordMinLength => 'パスワードは8文字以上で入力してください';

  @override
  String get inquiries => 'お問い合わせ';

  @override
  String get inquiryNew => '新しいお問い合わせ';

  @override
  String get inquiryEmptyTitle => 'お問い合わせはまだありません';

  @override
  String get inquiryEmptyDesc =>
      '学校へのご質問やご相談は、こちらからお送りください。学校からの返信はアプリに届き、通知でお知らせします。';

  @override
  String get inquiryCategory => 'カテゴリー';

  @override
  String get inquiryCategoryGeneral => '一般';

  @override
  String get inquiryCategoryAdmission => '入学・体験';

  @override
  String get inquiryCategoryPayment => '支払い';

  @override
  String get inquiryCategoryApp => 'アプリ';

  @override
  String get inquiryCategoryOther => 'その他';

  @override
  String get inquiryStatusNew => '受付';

  @override
  String get inquiryStatusOpen => '対応中';

  @override
  String get inquiryStatusAnswered => '回答あり';

  @override
  String get inquiryStatusClosed => '終了';

  @override
  String get inquirySubject => '件名';

  @override
  String get inquiryMessage => 'お問い合わせ内容';

  @override
  String get inquiryMessageHint => 'メッセージを入力';

  @override
  String get inquiryName => 'お名前';

  @override
  String get inquirySenderSchool => '学校';

  @override
  String get inquiryClosedNote =>
      'このお問い合わせは終了しました。新しいご質問は「新しいお問い合わせ」からお送りください。';

  @override
  String get inquirySent => '送信しました';

  @override
  String get inquirySentTitle => '送信しました';

  @override
  String get inquirySentGuest =>
      'お問い合わせありがとうございます。学校からの返信は、ご入力いただいたメールアドレスにお送りします。';

  @override
  String get inquiryGuestHint =>
      'ログインしてお問い合わせいただくと、学校からの返信をアプリで確認できます。ログインせずに送信した場合、返信はメールでお届けします。';

  @override
  String get inquiryPrivacyConsentPrefix => '';

  @override
  String get inquiryPrivacyConsentSuffix => 'に同意します';

  @override
  String get inquiryPrivacyConsentRequired => 'プライバシーポリシーへの同意が必要です';
}
