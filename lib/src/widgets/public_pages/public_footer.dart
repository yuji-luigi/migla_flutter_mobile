import 'package:flutter/material.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/public_content_view_model.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_link_opener.dart';

/// Footer aligned with the website: footer nav links + organization name.
class PublicFooter extends StatelessWidget {
  const PublicFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = $publicContentViewModel(context);
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 32),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      color: bgColorSecondary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...vm.footerNav.map(
            (link) => InkWell(
              onTap: () => openPublicLink(context, link),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text(
                  link.label,
                  style: textStyleBodyMedium.copyWith(color: textColorWhite),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'ASSOCIAZIONE CULTURALE MILANO LEARNING ACADEMY',
            style: textStyleCaptionMd.copyWith(color: textColorWhite),
          ),
        ],
      ),
    );
  }
}
