import 'package:flutter/material.dart';
import 'package:migla_flutter/src/models/api/page/public_link_model.dart';
import 'package:migla_flutter/src/screens/public/public_page_screen.dart';
import 'package:migla_flutter/src/view_models/public_content_view_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a CMS link: page references that exist in the app's public content
/// open natively; everything else falls back to the website in the browser.
void openPublicLink(BuildContext context, PublicLinkModel link) {
  if (link.isPageReference) {
    final vm = $publicContentViewModel(context, listen: false);
    final page = vm.pageBySlug(link.referenceSlug);
    if (page != null) {
      PublicPageScreen(page: page).launch(context);
      return;
    }
  }
  final uri = Uri.tryParse(link.webUrl);
  if (uri != null) {
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
