import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/api/page/public_link_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_link_opener.dart';

/// Renders CMS link groups (hero/CTA links) as buttons.
/// `appearance: outline` maps to an OutlinedButton.
class PublicLinkButtons extends StatelessWidget {
  final List<PublicLinkModel> links;

  const PublicLinkButtons({super.key, required this.links});

  @override
  Widget build(BuildContext context) {
    if (links.isEmpty) return const SizedBox.shrink();
    return Wrap(
      spacing: 12,
      runSpacing: 8,
      children: links.map((link) {
        if (link.appearance == 'outline') {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              foregroundColor: colorPrimaryDark,
              side: BorderSide(color: colorPrimary),
            ),
            onPressed: () => openPublicLink(context, link),
            child: Text(link.label),
          );
        }
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: actionPrimaryColor,
            foregroundColor: textColorWhite,
          ),
          onPressed: () => openPublicLink(context, link),
          child: Text(link.label),
        );
      }).toList(),
    );
  }
}
