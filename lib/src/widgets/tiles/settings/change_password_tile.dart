import 'package:flutter/material.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/change_password_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class ChangePasswordTile extends StatelessWidget {
  const ChangePasswordTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        context.t.changePasswordTitle,
        style: textStyleBodyLarge.copyWith(fontWeight: FontWeight.bold),
      ),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => const ChangePasswordScreen().launch(context),
    );
  }
}
