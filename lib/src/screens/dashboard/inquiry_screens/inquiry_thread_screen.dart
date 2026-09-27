import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/context_snackbar_extension.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/layouts/regular_layout_scaffold.dart';
import 'package:migla_flutter/src/models/api/inquiry/inquiry_message_model.dart';
import 'package:migla_flutter/src/models/api/inquiry/inquiry_model.dart';
import 'package:migla_flutter/src/models/internal/api_client.dart';
import 'package:migla_flutter/src/models/internal/logger.dart';
import 'package:migla_flutter/src/services/push_navigation_service.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/inquiries_view_model.dart';
import 'package:migla_flutter/src/views/inquiry/inquiry_labels.dart';

/// Chat-like thread of one inquiry: user messages on the right, school on the
/// left. Refreshes on open, on app resume and when a push for it arrives.
class InquiryThreadScreen extends StatefulWidget {
  final String inquiryId;
  final InquiryModel? inquiry;

  const InquiryThreadScreen({super.key, required this.inquiryId, this.inquiry});

  @override
  State<InquiryThreadScreen> createState() => _InquiryThreadScreenState();
}

class _InquiryThreadScreenState extends State<InquiryThreadScreen>
    with WidgetsBindingObserver {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  StreamSubscription<RemoteMessage>? _pushSub;

  InquiryModel? _inquiry;
  List<InquiryMessageModel> _messages = [];
  bool _isLoading = true;
  bool _loadFailed = false;
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    _inquiry = widget.inquiry;
    WidgetsBinding.instance.addObserver(this);
    _pushSub = PushNavigationService.foregroundMessages.listen((message) {
      if (PushNavigationService.inquiryIdFrom(message.data) ==
          widget.inquiryId) {
        _load(silent: true);
      }
    });
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _pushSub?.cancel();
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _load(silent: true);
  }

  Future<void> _load({bool silent = false}) async {
    if (!mounted) return;
    final vm = $inquiriesViewModel(context, listen: false);
    if (!silent) {
      setState(() {
        _isLoading = true;
        _loadFailed = false;
      });
    }
    try {
      // Status may have changed (answered / closed): refresh the header too.
      final futures = await Future.wait([
        vm.fetchMessages(widget.inquiryId),
        vm.fetchInquiry(widget.inquiryId),
      ]);
      if (!mounted) return;
      setState(() {
        _messages = futures[0] as List<InquiryMessageModel>;
        _inquiry = (futures[1] as InquiryModel?) ??
            _inquiry ??
            vm.findById(widget.inquiryId);
        _loadFailed = false;
      });
      _scrollToBottom();
      await vm.markRead(widget.inquiryId);
    } catch (error) {
      Logger.error('Inquiry thread load failed: $error');
      if (!mounted) return;
      if (!silent) setState(() => _loadFailed = true);
    } finally {
      if (mounted && !silent) setState(() => _isLoading = false);
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _send() async {
    final text = _inputController.text.trim();
    if (text.isEmpty || _isSending) return;
    setState(() => _isSending = true);
    try {
      final sent = await $inquiriesViewModel(context, listen: false)
          .sendMessage(widget.inquiryId, text);
      if (!mounted) return;
      _inputController.clear();
      setState(() {
        _messages = [
          ..._messages,
          sent ??
              InquiryMessageModel(
                id: 'local-${DateTime.now().millisecondsSinceEpoch}',
                body: text,
                sender: 'user',
                createdAt: DateTime.now(),
              ),
        ];
      });
      _scrollToBottom();
    } catch (error) {
      if (!mounted) return;
      String message = apiErrorMessage(error,
          fallback: context.t.error_somethingWentWrong);
      if (error is ApiException && error.statusCode == 429) {
        message = context.t.tooManyAttempts;
      }
      context.showErrorSnackbar(message);
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String localeCode = $settingsController(context).locale.languageCode;
    final bool closed = _inquiry?.isClosed == true;
    return RegularLayoutScaffold(
      padding: EdgeInsets.zero,
      bodyColor: colorTertiary,
      title: context.t.inquiries,
      showStudentName: false,
      appBarActions: [
        IconButton(
          tooltip: context.t.retry,
          icon: const Icon(Icons.refresh),
          onPressed: _isLoading ? null : () => _load(),
        ),
      ],
      body: Column(
        children: [
          if (_inquiry != null) _header(context),
          Expanded(child: _messagesView(context, localeCode)),
          if (closed)
            _closedNote(context)
          else
            _inputBar(context),
        ],
      ),
    );
  }

  Widget _header(BuildContext context) {
    final inquiry = _inquiry!;
    return Container(
      width: double.infinity,
      color: colorWhite.withAlpha(180),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(inquiry.subject,
              style: textStyleHeadingSmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 4),
          Row(
            children: [
              InquiryStatusChip(status: inquiry.status),
              const SizedBox(width: 8),
              Text(inquiryCategoryLabel(context, inquiry.category),
                  style: textStyleBodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _messagesView(BuildContext context, String localeCode) {
    if (_isLoading && _messages.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_loadFailed && _messages.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(context.t.error_somethingWentWrong,
                style: textStyleBodyMedium),
            TextButton(onPressed: _load, child: Text(context.t.retry)),
          ],
        ),
      );
    }
    return RefreshIndicator(
      onRefresh: () => _load(silent: true),
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        itemCount: _messages.length,
        itemBuilder: (context, index) =>
            _MessageBubble(message: _messages[index], localeCode: localeCode),
      ),
    );
  }

  Widget _closedNote(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        color: colorWhite,
        child: Text(
          context.t.inquiryClosedNote,
          textAlign: TextAlign.center,
          style: textStyleBodySmall.copyWith(color: colorPrimaryDark),
        ),
      ),
    );
  }

  Widget _inputBar(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        color: colorWhite,
        padding: const EdgeInsets.fromLTRB(12, 8, 4, 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: _inputController,
                minLines: 1,
                maxLines: 5,
                textInputAction: TextInputAction.newline,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  hintText: context.t.inquiryMessageHint,
                  isDense: true,
                  filled: true,
                  fillColor: colorTertiary.withAlpha(90),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            IconButton(
              tooltip: context.t.submit,
              onPressed: _isSending ? null : _send,
              icon: _isSending
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2))
                  : Icon(Icons.send, color: colorPrimaryDark),
            ),
          ],
        ),
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  final InquiryMessageModel message;
  final String localeCode;
  const _MessageBubble({required this.message, required this.localeCode});

  @override
  Widget build(BuildContext context) {
    final bool mine = message.isMine;
    return Align(
      alignment: mine ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.78,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Column(
            crossAxisAlignment:
                mine ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              if (!mine)
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 2),
                  child: Text(context.t.inquirySenderSchool,
                      style: textStyleBodySmall.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorPrimaryDark)),
                ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: mine ? colorPrimary : colorWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(14),
                    topRight: const Radius.circular(14),
                    bottomLeft: Radius.circular(mine ? 14 : 2),
                    bottomRight: Radius.circular(mine ? 2 : 14),
                  ),
                ),
                child: SelectableText(
                  message.body,
                  style: textStyleBodyMedium.copyWith(
                    color: mine ? textColorWhite : colorBlack,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 2, left: 4, right: 4),
                child: Text(
                  formatInquiryTime(message.createdAt, localeCode),
                  style: textStyleCaptionSmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
