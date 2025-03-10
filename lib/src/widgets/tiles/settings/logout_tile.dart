import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/svg_icon_constants.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/screens/auth/login_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class LogoutTile extends StatelessWidget {
  const LogoutTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 0),
      title: Row(
        children: [
          InkWell(
            onTap: () {
              print('Call api...');
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
