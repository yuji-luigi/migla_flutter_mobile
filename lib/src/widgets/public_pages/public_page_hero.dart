import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/api/page/public_page_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_link_buttons.dart';
import 'package:migla_flutter/src/widgets/rich_text/lexical_rich_text.dart';

class PublicPageHero extends StatelessWidget {
  final PageHeroModel hero;

  const PublicPageHero({super.key, required this.hero});

  @override
  Widget build(BuildContext context) {
    if (!hero.hasContent) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (hero.media != null)
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              hero.media!.url,
              fit: BoxFit.cover,
              width: double.infinity,
              errorBuilder: (_, __, ___) => const SizedBox.shrink(),
            ),
          ),
        if (hero.richText != null)
          Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LexicalRichText(
              richText: hero.richText,
              baseStyle: textStyleBodyLarge,
            ),
          ),
        if (hero.links.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: PublicLinkButtons(links: hero.links),
          ),
      ],
    );
  }
}
