import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/theme/spacing_constant.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class RegularLayoutScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? appBarActions;
  final Color? appBarBackgroundColor;
  final Color? backgroundColor;
  final Color? bodyColor;
  final EdgeInsets? padding;
  final Gradient? bodyGradient;
  final Color? bgCircleTopLeftColor;
  final Color? bgCircleBottomRightColor;
  const RegularLayoutScaffold({
    super.key,
    required this.body,
    this.title,
    this.appBarActions,
    this.appBarBackgroundColor,
    this.backgroundColor,
    this.bodyColor,
    this.padding,
    this.bodyGradient,
    this.bgCircleTopLeftColor,
    this.bgCircleBottomRightColor,
  });

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      backgroundColor:
          appBarBackgroundColor ?? bgColorSecondary.withOpacity(0.5),
      title: title != null
          ? Text(
              title!,
            )
          : null,
      actions: appBarActions,
    );
    double appBarHeight = appBar.preferredSize.height;
    return Scaffold(
      backgroundColor: backgroundColor ?? colorPrimary,

      extendBodyBehindAppBar: true,
      appBar: appBar,
      // body: body,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: SvgPicture.asset(
              bgCircleTopLeftSecondary,
              colorFilter: ColorFilter.mode(
                bgCircleTopLeftColor ?? colorTertiary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              svgBgCircleBottomRight,
              colorFilter: ColorFilter.mode(
                bgCircleBottomRightColor ?? bgColorSecondary,
                BlendMode.srcIn,
              ),
            ),
          ),
          Column(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).padding.top + appBarHeight),
              Flexible(
                child: Container(
                  width: double.infinity,
                  padding: padding ??
                      EdgeInsets.only(
                        left: paddingXDashboardMd,
                        right: paddingXDashboardMd,
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
                  child: body,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
