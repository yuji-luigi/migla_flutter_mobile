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
  String get labelName => 'Nome (alfabeto)';

  @override
  String get labelNameJapanese => 'Nome (giapponese)';

  @override
  String get labelSurname => 'Cognome (alfabeto)';

  @override
  String get labelSurnameJapanese => 'Cognome (giapponese)';

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
  String get goToHome => 'Torna alla home';

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
  String get fieldIsRequired => 'Questo campo è obbligatorio';

  @override
  String get japaneseOrAlphabetIsRequired =>
      'Inserisci caratteri giapponesi o alfabetici';

  @override
  String get invalidEmail => 'Inserisci un indirizzo email valido';

  @override
  String get pageIsUnderDevelopment =>
      'Questa pagina è in fase di sviluppo. Attendi fino a quando non sarà completata.';

  @override
  String get get_me_failed_after_login =>
      'Login è riuscito ma non è stato possibile ottenere l\'utente. contattare l\'amministratore';

  @override
  String get loading => 'Caricando...';

  @override
  String get not_found => 'Non trovato';

  @override
  String get submit => 'Invia';

  @override
  String get has_been_sent => 'Inviato';

  @override
  String get retry => 'Riprova';

  @override
  String get publicNoContent => 'Nessun contenuto disponibile al momento.';

  @override
  String get publicContentUpdateAvailable =>
      'Sono disponibili nuovi contenuti, attendi mentre aggiorniamo.';

  @override
  String get publicOpenFormOnWebsite =>
      'Apri questo modulo sul nostro sito web';

  @override
  String get schoolInfo => 'Informazioni scuola';

  @override
  String get passwordsDoNotMatch => 'Le password non corrispondono';

  @override
  String get commonOk => 'OK';

  @override
  String get commonSave => 'Salva';

  @override
  String get commonEdit => 'Modifica';

  @override
  String get commonDelete => 'Elimina';

  @override
  String get copy => 'Copia';

  @override
  String get copied => 'Copiato';

  @override
  String get optional => 'facoltativo';

  @override
  String get tooManyAttempts => 'Troppi tentativi. Riprova tra qualche minuto.';

  @override
  String get privacyPolicy => 'informativa sulla privacy';

  @override
  String get billingInfo => 'Dati per la ricevuta';

  @override
  String get billingInfoAdd => 'Aggiungi intestatario';

  @override
  String get billingInfoEdit => 'Modifica intestatario';

  @override
  String get billingInfoEmptyTitle => 'Nessun intestatario registrato';

  @override
  String get billingInfoEmptyDesc =>
      'Questi dati vengono usati come intestatario della ricevuta e per abbinare i bonifici. Se paghi da un conto intestato a un altro familiare (ad es. il coniuge), indicarne l\'intestatario aiuta la scuola a riconoscere il pagamento. Puoi registrarne più di uno e sceglierlo al momento della richiesta.';

  @override
  String get billingDefault => 'Predefinito';

  @override
  String get billingSetAsDefault => 'Imposta come predefinito';

  @override
  String get billingDeleteConfirmTitle => 'Eliminare questo intestatario?';

  @override
  String billingDeleteConfirmBody(String label) {
    return '“$label” verrà eliminato. L\'operazione non può essere annullata.';
  }

  @override
  String get billingDeleted => 'Eliminato';

  @override
  String get billingSaved => 'Salvato';

  @override
  String get billingLabel => 'Etichetta';

  @override
  String get billingLabelHint => 'Es. papà, mamma';

  @override
  String get billingHolderName => 'Intestatario della ricevuta';

  @override
  String get billingBankAccountHolder => 'Intestatario del conto bancario';

  @override
  String get billingBankAccountHolderHelper =>
      'Il titolare del conto da cui fai il bonifico. Serve ad abbinare il pagamento quando è diverso da chi è registrato nell\'app (es. conto del coniuge).';

  @override
  String get billingNotes => 'Note';

  @override
  String get billingNotesHint =>
      'Eventuali indicazioni per la scuola per l\'emissione della ricevuta';

  @override
  String get billingIsDefault => 'Usa come intestatario predefinito';

  @override
  String get receiptTitle => 'Ricevuta';

  @override
  String get receiptBadge => 'ricevuta';

  @override
  String get receiptExplanation =>
      'Se ti serve la ricevuta, richiedila qui. In tal caso aggiungi 2 € di marca da bollo all\'importo del bonifico. La scuola emetterà la ricevuta dopo aver verificato il pagamento.';

  @override
  String get receiptStatusNotRequested => 'Non richiesta';

  @override
  String get receiptStatusRequested => 'Richiesta';

  @override
  String get receiptStatusVerified => 'Bollo verificato';

  @override
  String get receiptRequestButton => 'Richiedi la ricevuta';

  @override
  String get receiptRequestDialogTitle => 'Richiesta ricevuta';

  @override
  String get receiptRequestDialogBody =>
      'Aggiungi 2 € di marca da bollo all\'importo del bonifico.';

  @override
  String get receiptChooseBillingProfile => 'Scegli l\'intestatario';

  @override
  String get receiptNoBillingProfileHint =>
      'Non hai ancora registrato un intestatario. Registrarlo permette di emettere la ricevuta con il nome corretto. Puoi comunque procedere con la richiesta.';

  @override
  String get receiptRequestWithoutProfile => 'Richiedi senza dati';

  @override
  String get receiptAddressee => 'Intestatario';

  @override
  String get receiptAddresseeRegistered => 'Intestatario registrato';

  @override
  String get receiptNoBillingProfile =>
      'Non indicato (verranno usati i dati in possesso della scuola)';

  @override
  String get receiptRequestedAt => 'Richiesta il';

  @override
  String get receiptConfirmationCode => 'Codice di conferma';

  @override
  String get receiptConfirmationCodeHint =>
      'Indica questo codice nella causale del bonifico.';

  @override
  String get receiptCancelRequest => 'Annulla la richiesta';

  @override
  String get receiptCancelConfirmTitle => 'Annullare la richiesta?';

  @override
  String get receiptCancelConfirmBody =>
      'La richiesta di ricevuta verrà annullata e non sarà necessario aggiungere i 2 € di marca da bollo.';

  @override
  String get receiptRequestedSnackbar => 'Ricevuta richiesta';

  @override
  String get receiptCancelledSnackbar => 'Richiesta annullata';

  @override
  String get receiptCannotCancelVerified =>
      'Non è possibile annullare: la scuola ha già verificato il pagamento della marca da bollo.';

  @override
  String get deleteAccount => 'Elimina account';

  @override
  String get deleteAccountConfirmTitle => 'Eliminare l\'account?';

  @override
  String get deleteAccountConfirmBody =>
      'Gli account senza dati scolastici vengono eliminati subito.\n\nPer le famiglie iscritte (o iscritte in passato) i dati degli studenti e dei pagamenti devono essere conservati: la richiesta verrà inviata alla segreteria della scuola, che ti contatterà.';

  @override
  String get deleteAccountReason => 'Motivo (facoltativo)';

  @override
  String get deleteAccountUnderstand => 'Ho capito';

  @override
  String get deleteAccountConfirmButton => 'Elimina';

  @override
  String get deleteAccountDone =>
      'Il tuo account è stato eliminato. Grazie per aver usato MIGLA.';

  @override
  String get deleteAccountRequestedTitle => 'Richiesta inviata';

  @override
  String get deleteAccountRequestedBody =>
      'La richiesta di eliminazione è stata inviata alla segreteria della scuola. Poiché i dati degli studenti e dei pagamenti devono essere conservati, la segreteria la gestirà e ti contatterà.';

  @override
  String get newsletterReceive => 'Ricevi la newsletter';

  @override
  String get newsletterPending =>
      'In attesa di conferma: clicca il link nell\'email per completare l\'iscrizione';

  @override
  String get newsletterSubscribed => 'Iscritto';

  @override
  String get newsletterConfirmSentTitle => 'Email di conferma inviata';

  @override
  String get newsletterConfirmSent =>
      'Ti abbiamo inviato un\'email di conferma. Clicca il link contenuto per completare l\'iscrizione.';

  @override
  String get newsletterUnsubscribed => 'Iscrizione alla newsletter annullata';

  @override
  String get registerNewsletterOptIn => 'Ricevi la newsletter di MIGLA';

  @override
  String get registerNewsletterOptInHint => 'Riceverai un\'email di conferma';

  @override
  String get registerFailed => 'Registrazione non riuscita';

  @override
  String get passwordMinLength =>
      'La password deve contenere almeno 8 caratteri';

  @override
  String get inquiries => 'Contatti';

  @override
  String get inquiryNew => 'Nuovo messaggio';

  @override
  String get inquiryEmptyTitle => 'Nessun messaggio';

  @override
  String get inquiryEmptyDesc =>
      'Scrivi qui domande o richieste alla scuola. Le risposte arriveranno nell\'app e riceverai una notifica.';

  @override
  String get inquiryCategory => 'Categoria';

  @override
  String get inquiryCategoryGeneral => 'Generale';

  @override
  String get inquiryCategoryAdmission => 'Iscrizione e lezione di prova';

  @override
  String get inquiryCategoryPayment => 'Pagamenti';

  @override
  String get inquiryCategoryApp => 'App';

  @override
  String get inquiryCategoryOther => 'Altro';

  @override
  String get inquiryStatusNew => 'Nuova';

  @override
  String get inquiryStatusOpen => 'In corso';

  @override
  String get inquiryStatusAnswered => 'Risposta ricevuta';

  @override
  String get inquiryStatusClosed => 'Chiusa';

  @override
  String get inquirySubject => 'Oggetto';

  @override
  String get inquiryMessage => 'Messaggio';

  @override
  String get inquiryMessageHint => 'Scrivi un messaggio';

  @override
  String get inquiryName => 'Nome e cognome';

  @override
  String get inquirySenderSchool => 'Scuola';

  @override
  String get inquiryClosedNote =>
      'Questa conversazione è chiusa. Per nuove domande invia un nuovo messaggio.';

  @override
  String get inquirySent => 'Messaggio inviato';

  @override
  String get inquirySentTitle => 'Messaggio inviato';

  @override
  String get inquirySentGuest =>
      'Grazie per averci scritto. La scuola ti risponderà all\'indirizzo email indicato.';

  @override
  String get inquiryGuestHint =>
      'Se accedi prima di scrivere, potrai leggere le risposte della scuola nell\'app. Senza accesso, la risposta arriverà via email.';

  @override
  String get inquiryPrivacyConsentPrefix => 'Ho letto e accetto l\'';

  @override
  String get inquiryPrivacyConsentSuffix => '';

  @override
  String get inquiryPrivacyConsentRequired =>
      'È necessario accettare l\'informativa sulla privacy';
}
