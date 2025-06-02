import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/models/internal/objects/nav_item.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class DrawerListTile extends StatelessWidget {
  final NavItem item;
  const DrawerListTile({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: paddingXDashboardMd,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(900),
        ),
        onTap: () =>
            item.onTap != null ? item.onTap!() : item.widget.launch(context),
        leading: SvgPicture.asset(
          item.icon,
          width: 42,
          height: 42,
          colorFilter: ColorFilter.mode(
            colorBlack,
            BlendMode.srcIn,
          ),
        ),
        title: Text(item.title,
            style: TextStyle(
                color: colorBlack, fontSize: 18, fontWeight: FontWeight.w500)),
      ),
    );
  }
}
