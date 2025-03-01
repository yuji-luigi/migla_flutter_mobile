import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:nb_utils/nb_utils.dart';

class DashboardLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? appBarActions;
  final Color? backgroundColor;
  const DashboardLayout({
    super.key,
    required this.body,
    this.title,
    this.appBarActions,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor: Colors.transparent,
      title: title != null ? Text(title!) : null,
      actions: appBarActions,
    );
    double appBarHeight = appBar.preferredSize.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor ?? colorPrimary,
      appBar: appBar,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              bgCircleTopLeftSecondary,
              colorFilter: ColorFilter.mode(
                colorWhite,
                BlendMode.srcIn,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).padding.top + appBarHeight),
              SingleChildScrollView(
                child: Container(
                    constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            appBarHeight),
                    child: body),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
