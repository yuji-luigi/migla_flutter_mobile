import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/api/page/public_page_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_content_update_banner.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_footer.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_page_hero.dart';
import 'package:migla_flutter/src/widgets/public_pages/render_blocks.dart';

/// Renders one public CMS page (hero + layout blocks + footer).
class PublicPageScreen extends StatelessWidget {
  final PublicPageModel page;

  const PublicPageScreen({super.key, required this.page});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgPrimaryColor,
      appBar: AppBar(
        backgroundColor: bgPrimaryColor,
        title: Text(page.title, style: textStyleHeadingMedium),
      ),
      body: Column(
        children: [
          const PublicContentUpdateBanner(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (page.hero != null)
                          PublicPageHero(hero: page.hero!),
                        RenderBlocks(
                          blocks: page.visibleBlocks,
                          pageSlug: page.slug,
                        ),
                      ],
                    ),
                  ),
                  const PublicFooter(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
