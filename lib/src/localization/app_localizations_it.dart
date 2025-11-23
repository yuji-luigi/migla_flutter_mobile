// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String helloExample(String name) {
    return 'Ciao, $name!';
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
  String get welcomeToMigla => 'Benvenuti in Migla';

  @override
  String get welcomeBack => 'Ben tornato!';

  @override
  String get welcomeDesc => 'Stai al passo con i progressi di tuo figlio!';

  @override
  String get getStarted => 'Inizia';

  @override
  String get registerDesc => 'Stai al passo con i progressi di tuo figlio!';

  @override
  String get labelName => 'Nome';

  @override
  String get labelSurname => 'Cognome';

  @override
  String get labelEmail => 'Email';

  @override
  String get labelPassword => 'Password';

  @override
  String get labelConfirmPassword => 'Conferma Password';

  @override
  String get register => 'Registrati';

  @override
  String get login => 'Accedi';

  @override
  String get alreadyHaveAccount => 'Hai già un account?';

  @override
  String get noAccount => 'Non hai un account?';

  @override
  String get forgotPassword => 'Hai dimenticato la password?';

  @override
  String get dashboardHomeScreenHeader =>
      'Stai al passo con i progressi di tuo figlio!';

  @override
  String get teacherReport => 'Report maestra';

  @override
  String get photoAndVideo => 'Foto e Video';

  @override
  String get notificationTextButton => 'Notifiche';

  @override
  String get photoAndVideoTextButton => 'Foto e Video';

  @override
  String get settings => 'Impostazioni';

  @override
  String get logout => 'Esci';

  @override
  String get weekButtonText => 'Settimana';

  @override
  String get categoryButtonText => 'Categoria';

  @override
  String get otherButtonText => 'Altro';

  @override
  String get notificationTitle => 'Notifiche';

  @override
  String get markAsRead => 'Segna come letto';

  @override
  String get navGallery => 'Galleria';

  @override
  String get navSettings => 'Impostazioni';

  @override
  String get settingScreenLanguage => 'Lingua';

  @override
  String get pushNotificationSetting => 'Notifiche Push';

  @override
  String get selectStudent => 'Quale bambino vuoi vedere?';

  @override
  String get switchStudent => 'Cambia bambino';

  @override
  String get home_title_noStudent =>
      'Figli non trovati. Contatta la tua scuola.';

  @override
  String get home_pleaseSelectStudent =>
      'Quale bambino vuoi vedere?\n(ancora non selezionato)';

  @override
  String get downloadModal_title => 'Scarica';

  @override
  String get downloadModal_description =>
      'Sei sicuro di voler scaricare questo file?';

  @override
  String get download => 'Scarica';

  @override
  String get cancel => 'Annulla';

  @override
  String get attachments => 'Allegati';

  @override
  String get error_somethingWentWrong => 'Qualcosa è andato storto';

  @override
  String get refreshPage => 'Ricarica la pagina';

  @override
  String get noReportsFound => 'Non ci sono report per questo bambino';

  @override
  String get somethingWentWrong => 'Qualcosa è andato storto';

  @override
  String get noNotificationsFound => 'Non ci sono notifiche';

  @override
  String get noGalleriesFound => 'Non ci sono gallerie';

  @override
  String get rememberMe => 'Ricordami';

  @override
  String get navPayment => 'Pagamenti';

  @override
  String get paidCondition => 'Pagato';

  @override
  String get yes => 'Si';

  @override
  String get no => 'No';

  @override
  String get completed => 'Completato';

  @override
  String get notCompleted => 'Non completato';

  @override
  String get paymentDueDate => 'Data di scadenza';

  @override
  String get dueDate => 'Scadenza';

  @override
  String get noPaymentRecordFound => 'Nessun record di pagamento trovato';

  @override
  String get paymentCompleted => 'Pagamento Completato';

  @override
  String get paymentPending => 'Pagamento in Attesa';

  @override
  String get totalAmount => 'Importo Totale';

  @override
  String get paymentSchedule => 'Programma di Pagamento';

  @override
  String get title => 'Titolo';

  @override
  String get alertMessage => 'Messaggio di Avviso';

  @override
  String get body => 'Corpo';

  @override
  String get createdAt => 'Creato il';

  @override
  String get paymentDetails => 'Dettagli Pagamento';

  @override
  String get tuitionFee => 'Tassa di Iscrizione';

  @override
  String get studentCount => 'Numero di Studenti';

  @override
  String get materialFee => 'Tassa Materiali';

  @override
  String get materialFeeDescription => 'Descrizione Tassa Materiali';

  @override
  String get purchases => 'Acquisti';

  @override
  String get quantity => 'Quantità';

  @override
  String get noDataFound => 'Nessun dato trovato';

  @override
  String get forgotPasswordScreenHeader => 'Hai dimenticato la password?';

  @override
  String get forgotPasswordEmailInputLabel =>
      'Inserisci il tuo indirizzo email per reimpostare la password';

  @override
  String get back => 'Indietro';

  @override
  String get labelEmailRequired => 'Inserisci il tuo indirizzo email';

  @override
  String get labelPasswordRequired => 'Inserisci la tua password';

  @override
  String get invalidEmail => 'Inserisci un indirizzo email valido';

  @override
  String get pageIsUnderDevelopment =>
      'Questa pagina è in fase di sviluppo. Attendi fino a quando non sarà completata.';
}
