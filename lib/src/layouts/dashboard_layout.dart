import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class DashboardLayout extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? appBarActions;
  final Color? backgroundColor;
  final Color? bodyColor;
  final EdgeInsets? padding;
  final Gradient? bodyGradient;
  const DashboardLayout({
    super.key,
    required this.body,
    this.title,
    this.appBarActions,
    this.backgroundColor,
    this.bodyColor,
    this.padding,
    this.bodyGradient,
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
      backgroundColor: backgroundColor ?? colorPrimary,
      extendBodyBehindAppBar: true,
      appBar: appBar,
      // body: body,
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
          Positioned.fill(
            child: Column(
              children: [
                SizedBox(
                    height: MediaQuery.of(context).padding.top + appBarHeight),
                Expanded(
                  child: Container(
                      width: double.infinity,
                      padding: padding ??
                          EdgeInsets.only(
                            left: 16,
                            right: 16,
                          ),
                      constraints: BoxConstraints(
                        minHeight: MediaQuery.of(context).size.height -
                            MediaQuery.of(context).padding.top -
                            appBarHeight,
                      ),
                      decoration: BoxDecoration(
                        color: bodyColor ?? bgPrimaryColor,
                        gradient: bodyGradient,
                      ),
                      child: body),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
