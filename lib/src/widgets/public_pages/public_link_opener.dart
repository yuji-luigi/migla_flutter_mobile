import 'package:flutter/material.dart';
import 'package:migla_flutter/env_vars.dart';
import 'package:migla_flutter/src/models/api/page/public_link_model.dart';
import 'package:migla_flutter/src/screens/public/public_page_screen.dart';
import 'package:migla_flutter/src/view_models/public_content_view_model.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';

/// Opens a CMS nav/CTA link (a [PublicLinkModel] with an explicit reference):
/// page references that exist in the app's public content open natively,
/// everything else falls back to the website in the browser.
void openPublicLink(BuildContext context, PublicLinkModel link) {
  if (link.isPageReference && link.referenceSlug != null) {
    if (_pushIfInApp(context, link.referenceSlug!)) return;
  }
  openPublicUrl(context, link.webUrl);
}

/// Opens a raw CMS URL as it appears inside rich text — a relative path
/// ("/admission-guide"), a full site URL, or an external URL.
///
/// Uses the SAME resolution as [openPublicLink]: if the URL targets a page
/// that the app has in its public content, push it natively; otherwise open
/// it in the browser (relative paths are made absolute against [host] first).
void openPublicUrl(BuildContext context, String url) {
  final slug = _slugFromInternalUrl(url);
  if (slug != null && _pushIfInApp(context, slug)) return;

  final absolute = url.startsWith('/') ? '$host$url' : url;
  final uri = Uri.tryParse(absolute);
  if (uri != null && uri.hasScheme) {
    launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

/// Pushes the app-native page for [slug] if it exists in the fetched public
/// content. Returns true when it navigated, false when the page isn't in the
/// app (caller should fall back to the browser).
bool _pushIfInApp(BuildContext context, String slug) {
  final page = $publicContentViewModel(context, listen: false).pageBySlug(slug);
  if (page != null) {
    PublicPageScreen(page: page).launch(context);
    return true;
  }
  return false;
}

/// Returns the page slug when [url] points at our own site (a relative path
/// or an absolute URL on [host]); null for external links.
String? _slugFromInternalUrl(String url) {
  final trimmed = url.trim();
  if (trimmed.isEmpty) return null;

  String path;
  if (trimmed.startsWith('/')) {
    path = trimmed;
  } else {
    final uri = Uri.tryParse(trimmed);
    final hostUri = Uri.tryParse(host);
    if (uri == null || !uri.hasScheme || hostUri == null) return null;
    if (uri.host != hostUri.host) return null; // external site
    path = uri.path;
  }

  // strip leading slashes and any query/fragment, keep the slug
  final slug = path.replaceFirst(RegExp(r'^/+'), '').split(RegExp('[?#]')).first;
  return slug.isEmpty ? null : slug;
}
