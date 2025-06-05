import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/login/login_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';
import 'package:nb_utils/nb_utils.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    final meVm = $meViewModel(context);

    final gqlClient = GraphQLProvider.of(context).value;
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Row(
        children: [
          InkWell(
            onTap: () async {
              await meVm.logout();
              gqlClient.cache.store.reset();
              // rerun the app
              SystemNavigator.pop();
              LoginScreen().launch(context, isNewTask: true);
            },
            child: Row(
              spacing: 8,
              children: [
                SvgPicture.asset(
                  svgLogout,
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    errorColor,
                    BlendMode.srcIn,
                  ),
                ),
                Text(context.t.logout,
                    style: textStyleBodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                      color: errorColor,
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
