import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders Payload CMS Lexical rich-text JSON as Flutter widgets.
///
/// Supports the node types produced by the site's editors: paragraph,
/// heading (h1-h4), list (bullet/number/check), listitem, quote, link,
/// autolink, linebreak, horizontalrule, upload (images) and text with the
/// Lexical format bitmask (bold/italic/strikethrough/underline/code).
class LexicalRichText extends StatefulWidget {
  final Map<String, dynamic>? richText;
  final TextStyle? baseStyle;

  const LexicalRichText({super.key, required this.richText, this.baseStyle});

  @override
  State<LexicalRichText> createState() => _LexicalRichTextState();
}

class _LexicalRichTextState extends State<LexicalRichText> {
  static const int _formatBold = 1;
  static const int _formatItalic = 2;
  static const int _formatStrikethrough = 4;
  static const int _formatUnderline = 8;
  static const int _formatCode = 16;

  final List<TapGestureRecognizer> _recognizers = [];

  @override
  void dispose() {
    for (final recognizer in _recognizers) {
      recognizer.dispose();
    }
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant LexicalRichText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.richText != widget.richText) {
      for (final recognizer in _recognizers) {
        recognizer.dispose();
      }
      _recognizers.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final root = widget.richText?['root'];
    final children = root is Map<String, dynamic> ? root['children'] : null;
    if (children is! List || children.isEmpty) {
      return const SizedBox.shrink();
    }
    final blocks = _renderBlockNodes(children);
    if (blocks.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: blocks,
    );
  }

  TextStyle get _base => widget.baseStyle ?? textStyleBodyMedium;

  List<Widget> _renderBlockNodes(List nodes) {
    final widgets = <Widget>[];
    for (final node in nodes) {
      if (node is! Map<String, dynamic>) continue;
      final widget = _renderBlockNode(node);
      if (widget != null) {
        widgets.add(Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: widget,
        ));
      }
    }
    return widgets;
  }

  Widget? _renderBlockNode(Map<String, dynamic> node) {
    switch (node['type'] as String?) {
      case 'paragraph':
        return _paragraph(node, _base);
      case 'heading':
        return _paragraph(node, _headingStyle(node['tag'] as String?));
      case 'quote':
        return Container(
          padding: const EdgeInsets.only(left: 12),
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: colorPrimary, width: 3)),
          ),
          child: _paragraph(node, _base.copyWith(fontStyle: FontStyle.italic)),
        );
      case 'list':
        return _list(node);
      case 'horizontalrule':
        return const Divider();
      case 'upload':
        return _upload(node);
      default:
        // Unknown container node: try to render its children.
        final children = node['children'];
        if (children is List && children.isNotEmpty) {
          final rendered = _renderBlockNodes(children);
          if (rendered.isNotEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: rendered,
            );
          }
        }
        return null;
    }
  }

  Widget? _paragraph(Map<String, dynamic> node, TextStyle style) {
    final spans = _inlineSpans(node['children'], style);
    if (spans.isEmpty) return null;
    return Text.rich(
      TextSpan(children: spans),
      textAlign: _textAlign(node['format']),
    );
  }

  Widget _list(Map<String, dynamic> node) {
    final items = (node['children'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .toList();
    final isNumbered = node['listType'] == 'number';
    final rows = <Widget>[];
    var index = (node['start'] as int?) ?? 1;
    for (final item in items) {
      final marker = isNumbered ? '$index.' : '•';
      index++;
      // A list item may itself contain a nested list.
      final nested = (item['children'] as List? ?? [])
          .whereType<Map<String, dynamic>>()
          .where((c) => c['type'] == 'list')
          .toList();
      final spans = _inlineSpans(
        (item['children'] as List? ?? [])
            .where((c) => c is Map<String, dynamic> && c['type'] != 'list')
            .toList(),
        _base,
      );
      rows.add(Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 24, child: Text(marker, style: _base)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (spans.isNotEmpty) Text.rich(TextSpan(children: spans)),
                  ...nested.map(_list),
                ],
              ),
            ),
          ],
        ),
      ));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }

  Widget? _upload(Map<String, dynamic> node) {
    final value = node['value'];
    final url = value is Map<String, dynamic> ? value['url'] as String? : null;
    if (url == null) return null;
    final fullUrl = url.startsWith('http') ? url : '$host$url';
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.network(fullUrl, fit: BoxFit.cover),
    );
  }

  List<InlineSpan> _inlineSpans(dynamic nodes, TextStyle style) {
    if (nodes is! List) return [];
    final spans = <InlineSpan>[];
    for (final node in nodes) {
      if (node is! Map<String, dynamic>) continue;
      switch (node['type'] as String?) {
        case 'text':
          spans.add(TextSpan(
            text: node['text'] as String? ?? '',
            style: _textStyleFor(node['format'], style),
          ));
          break;
        case 'linebreak':
          spans.add(const TextSpan(text: '\n'));
          break;
        case 'link':
        case 'autolink':
          spans.addAll(_linkSpans(node, style));
          break;
        default:
          spans.addAll(_inlineSpans(node['children'], style));
      }
    }
    return spans;
  }

  List<InlineSpan> _linkSpans(Map<String, dynamic> node, TextStyle style) {
    final fields = node['fields'];
    String? url;
    if (fields is Map<String, dynamic>) {
      url = fields['url'] as String?;
      // Internal doc links: fields.doc.value.slug
      final doc = fields['doc'];
      if (url == null && doc is Map<String, dynamic>) {
        final value = doc['value'];
        final slug = value is Map<String, dynamic> ? value['slug'] : null;
        if (slug is String) url = '$host/$slug';
      }
    }
    url ??= node['url'] as String?;

    final linkStyle = style.copyWith(
      color: colorPrimaryDark,
      decoration: TextDecoration.underline,
    );
    final recognizer = url == null ? null : _recognizerFor(url);
    return (node['children'] as List? ?? [])
        .whereType<Map<String, dynamic>>()
        .map<InlineSpan>((child) => TextSpan(
              text: child['text'] as String? ?? '',
              style: _textStyleFor(child['format'], linkStyle),
              recognizer: recognizer,
            ))
        .toList();
  }

  TapGestureRecognizer _recognizerFor(String url) {
    final recognizer = TapGestureRecognizer()
      ..onTap = () {
        final uri = Uri.tryParse(url);
        if (uri != null) {
          launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      };
    _recognizers.add(recognizer);
    return recognizer;
  }

  TextStyle _textStyleFor(dynamic format, TextStyle base) {
    if (format is! int || format == 0) return base;
    var style = base;
    if (format & _formatBold != 0) {
      style = style.copyWith(fontWeight: FontWeight.bold);
    }
    if (format & _formatItalic != 0) {
      style = style.copyWith(fontStyle: FontStyle.italic);
    }
    final decorations = <TextDecoration>[
      if (base.decoration != null) base.decoration!,
      if (format & _formatUnderline != 0) TextDecoration.underline,
      if (format & _formatStrikethrough != 0) TextDecoration.lineThrough,
    ];
    if (decorations.isNotEmpty) {
      style = style.copyWith(decoration: TextDecoration.combine(decorations));
    }
    if (format & _formatCode != 0) {
      style = style.copyWith(
        fontFamily: 'monospace',
        backgroundColor: colorTertiary,
      );
    }
    return style;
  }

  TextStyle _headingStyle(String? tag) {
    switch (tag) {
      case 'h1':
        return textStyleTitleLg;
      case 'h2':
        return TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
      case 'h3':
        return textStyleHeadingMedium;
      case 'h4':
        return textStyleHeadingSmall;
      default:
        return textStyleHeadingMedium;
    }
  }

  TextAlign? _textAlign(dynamic format) {
    if (format is! String) return null;
    switch (format) {
      case 'center':
        return TextAlign.center;
      case 'right':
      case 'end':
        return TextAlign.right;
      case 'justify':
        return TextAlign.justify;
      case 'left':
      case 'start':
        return TextAlign.left;
      default:
        return null;
    }
  }
}
