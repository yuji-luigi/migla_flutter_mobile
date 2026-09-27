import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/api_endpoints.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

/// Newsletter subscription (double opt-in: the backend sends a confirmation
/// email, status stays `pending` until the link is clicked).
class NewsletterSwitchTile extends StatefulWidget {
  const NewsletterSwitchTile({super.key});

  @override
  State<NewsletterSwitchTile> createState() => _NewsletterSwitchTileState();
}

class _NewsletterSwitchTileState extends State<NewsletterSwitchTile> {
  final ApiClient _apiClient = ApiClientImpl();

  /// none | pending | subscribed | unsubscribed; null while loading.
  String? _status;
  bool _isBusy = false;
  bool _loadFailed = false;

  bool get _isOn => _status == 'pending' || _status == 'subscribed';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _isBusy = true;
      _loadFailed = false;
    });
    try {
      final res = await _apiClient.get(apiUrlNewsletterMe);
      final data = jsonDecode(res.body);
      if (!mounted) return;
      setState(() => _status = data['status']?.toString() ?? 'none');
    } catch (error) {
      Logger.error('Newsletter status: $error');
      if (!mounted) return;
      setState(() => _loadFailed = true);
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  Future<void> _toggle(bool value) async {
    final String locale =
        $settingsController(context, listen: false).locale.languageCode;
    setState(() => _isBusy = true);
    try {
      if (value) {
        final res = await _apiClient.post(apiUrlNewsletterSubscribe,
            body: {'locale': locale, 'source': 'app'});
        String status = 'pending';
        try {
          status = jsonDecode(res.body)['status']?.toString() ?? 'pending';
        } catch (_) {}
        if (!mounted) return;
        setState(() => _status = status);
        if (status == 'pending') {
          await showDialog<void>(
            context: context,
            builder: (dialogContext) => AlertDialog(
              title: Text(context.t.newsletterConfirmSentTitle),
              content: Text(context.t.newsletterConfirmSent),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(context.t.commonOk),
                ),
              ],
            ),
          );
        }
      } else {
        await _apiClient.delete(apiUrlNewsletterMe);
        if (!mounted) return;
        setState(() => _status = 'unsubscribed');
        context.showSnackbar(context.t.newsletterUnsubscribed);
      }
    } catch (error) {
      if (!mounted) return;
      String message = apiErrorMessage(error,
          fallback: context.t.error_somethingWentWrong);
      if (error is ApiException && error.statusCode == 429) {
        message = context.t.tooManyAttempts;
      }
      context.showErrorSnackbar(message);
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    String? subtitle;
    if (_loadFailed) {
      subtitle = context.t.error_somethingWentWrong;
    } else if (_status == 'pending') {
      subtitle = context.t.newsletterPending;
    } else if (_status == 'subscribed') {
      subtitle = context.t.newsletterSubscribed;
    }
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
      title: Text(context.t.newsletterReceive,
          style: textStyleBodyLarge.copyWith(
            fontWeight: FontWeight.bold,
          )),
      subtitle: subtitle != null
          ? Text(subtitle, style: textStyleBodySmall)
          : null,
      onTap: _loadFailed && !_isBusy ? _load : null,
      trailing: _isBusy
          ? const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2))
          : Switch(
              value: _isOn,
              activeThumbColor: colorSecondary,
              trackColor: WidgetStateProperty.fromMap({
                WidgetState.selected: colorSecondary,
                WidgetState.any: colorTextDisabled,
              }),
              thumbColor: WidgetStateProperty.all(colorWhite),
              onChanged: _status == null ? null : _toggle,
            ),
    );
  }
}
