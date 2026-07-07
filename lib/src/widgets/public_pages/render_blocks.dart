import 'package:flutter/material.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/api/page/page_block_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_link_buttons.dart';
import 'package:migla_flutter/src/widgets/rich_text/lexical_rich_text.dart';
import 'package:url_launcher/url_launcher.dart';

/// Renders a page's layout blocks (already filtered by `showInMobileApp`).
class RenderBlocks extends StatelessWidget {
  final List<PageBlockModel> blocks;

  /// Slug of the page these blocks belong to — used to open the website
  /// for blocks the app cannot render natively (e.g. forms).
  final String pageSlug;

  const RenderBlocks({super.key, required this.blocks, required this.pageSlug});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: blocks
          .map((block) => Padding(
                padding: const EdgeInsets.only(top: 24),
                child: _blockWidget(context, block),
              ))
          .toList(),
    );
  }

  Widget _blockWidget(BuildContext context, PageBlockModel block) {
    switch (block) {
      case CtaBlockModel cta:
        return _cta(cta);
      case ContentBlockModel content:
        return _content(content);
      case MediaBlockModel media:
        return _media(media);
      case ArchiveBlockModel archive:
        return LexicalRichText(richText: archive.introContent);
      case FormBlockModel form:
        return _form(context, form);
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _cta(CtaBlockModel block) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colorTertiary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LexicalRichText(richText: block.richText),
          if (block.links.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: PublicLinkButtons(links: block.links),
            ),
        ],
      ),
    );
  }

  Widget _content(ContentBlockModel block) {
    // The website lays columns out side by side; on a phone they stack.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: block.columns
          .map((column) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LexicalRichText(richText: column.richText),
                    if (column.enableLink && column.link != null)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: PublicLinkButtons(links: [column.link!]),
                      ),
                  ],
                ),
              ))
          .toList(),
    );
  }

  Widget _media(MediaBlockModel block) {
    final media = block.media;
    if (media == null) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Image.network(
        media.url,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, __, ___) => const SizedBox.shrink(),
      ),
    );
  }

  Widget _form(BuildContext context, FormBlockModel block) {
    // Native form rendering is not supported yet: show the intro content and
    // hand off to the same page on the website.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (block.enableIntro && block.introContent != null)
          LexicalRichText(richText: block.introContent),
        Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: colorPrimaryDark,
                side: BorderSide(color: colorPrimary),
              ),
              icon: const Icon(Icons.open_in_new, size: 18),
              label: Text(context.t.publicOpenFormOnWebsite),
              onPressed: () {
                final uri = Uri.tryParse('$host/$pageSlug');
                if (uri != null) {
                  launchUrl(uri, mode: LaunchMode.externalApplication);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
