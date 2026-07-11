import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/internal/suppported_language.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/settings/settings_controller.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/public_content_view_model.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_content_update_banner.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_footer.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_link_opener.dart';
import 'package:migla_flutter/src/widgets/public_pages/public_page_hero.dart';
import 'package:migla_flutter/src/widgets/public_pages/render_blocks.dart';
import 'package:nb_utils/nb_utils.dart';

/// Public landing screen shown before login: renders the website's home
/// page content, header navigation (drawer), footer, a language selector
/// and the entry point to the members' login.
class PublicHomeScreen extends StatefulWidget {
  const PublicHomeScreen({super.key});

  @override
  State<PublicHomeScreen> createState() => _PublicHomeScreenState();
}

class _PublicHomeScreenState extends State<PublicHomeScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      $publicContentViewModel(context, listen: false).init();
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // The version check otherwise runs only at launch; users keep the app
    // in memory for days, so re-check whenever it returns to foreground.
    if (state == AppLifecycleState.resumed) {
      $publicContentViewModel(context, listen: false).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = $publicContentViewModel(context);
    return Scaffold(
      backgroundColor: bgPrimaryColor,
      appBar: AppBar(
        backgroundColor: bgPrimaryColor,
        title: Text('MIGLA', style: textStyleHeadingMedium),
        actions: [
          _languageMenu(context),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton(
              style: TextButton.styleFrom(
                backgroundColor: actionPrimaryColor,
                foregroundColor: textColorWhite,
                padding: const EdgeInsets.symmetric(horizontal: 16),
              ),
              onPressed: () => LoginScreen().launch(context),
              child: Text(context.t.login),
            ),
          ),
        ],
      ),
      drawer: _drawer(context, vm),
      body: Column(
        children: [
          const PublicContentUpdateBanner(),
          Expanded(child: _body(context, vm)),
        ],
      ),
    );
  }

  Widget _body(BuildContext context, PublicContentViewModel vm) {
    if (vm.isLoading && !vm.hasContent) {
      return const Center(child: CircularProgressIndicator());
    }
    if (!vm.hasContent) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                vm.errorMessage != null
                    ? context.t.error_somethingWentWrong
                    : context.t.publicNoContent,
                textAlign: TextAlign.center,
                style: textStyleBodyMedium,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: actionPrimaryColor,
                  foregroundColor: textColorWhite,
                ),
                onPressed: vm.refresh,
                child: Text(context.t.retry),
              ),
            ],
          ),
        ),
      );
    }
    final page = vm.homePage!;
    return RefreshIndicator(
      onRefresh: vm.refresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (page.hero != null) PublicPageHero(hero: page.hero!),
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
    );
  }

  Widget _drawer(BuildContext context, PublicContentViewModel vm) {
    return Drawer(
      backgroundColor: bgPrimaryColor,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text('MIGLA', style: textStyleTitleLg),
            ),
            ...vm.headerNav.map(
              (link) => ListTile(
                title: Text(link.label, style: textStyleBodyLarge),
                onTap: () {
                  // Navigator.of(context).pop();
                  openPublicLink(context, link);
                },
              ),
            ),
            const Divider(),
            ListTile(
              leading: Icon(Icons.login, color: colorPrimaryDark),
              title: Text(context.t.login, style: textStyleBodyLarge),
              onTap: () {
                Navigator.of(context).pop();
                LoginScreen().launch(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageMenu(BuildContext context) {
    final settingsController = $settingsController(context);
    final currentCode = settingsController.locale.languageCode;
    return PopupMenuButton<String>(
      icon: const Icon(Icons.language),
      initialValue: currentCode,
      onSelected: (code) async {
        if (code == currentCode) return;
        await settingsController.updateLocale(code);
        if (!context.mounted) return;
        await $publicContentViewModel(context, listen: false).onLocaleChanged();
      },
      itemBuilder: (context) => supportedLanguages
          .map(
            (language) => PopupMenuItem(
              value: language.code,
              child: Row(
                children: [
                  SvgPicture.asset(language.iconPath, width: 24, height: 24),
                  const SizedBox(width: 12),
                  Text(language.name),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
