import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/public_content_view_model.dart';

/// Shown while newer CMS content is being downloaded after a version
/// mismatch: "New contents are available, please wait to update." (ja/en/it)
class PublicContentUpdateBanner extends StatelessWidget {
  const PublicContentUpdateBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = $publicContentViewModel(context);
    if (!vm.isUpdating) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      color: colorSecondary,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              context.t.publicContentUpdateAvailable,
              style: textStyleBodySmall.copyWith(color: textColorWhite),
            ),
          ),
        ],
      ),
    );
  }
}
