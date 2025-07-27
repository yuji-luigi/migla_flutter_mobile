import 'package:flutter/material.dart';
import 'package:migla_flutter/src/constants/image_constants/bg_image_constants.dart';
import 'package:migla_flutter/src/screens/dashboard/notification_screens/notification_list_screen.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/widgets/drawer/dashboard_left_drawer.dart';

class DashboardHomeScaffold extends StatefulWidget {
  // final List<Widget> body;
  final Widget topSection;
  final Widget bottomSection;

  const DashboardHomeScaffold({
    super.key,
    // required this.body,
    required this.topSection,
    required this.bottomSection,
  });

  @override
  State<DashboardHomeScaffold> createState() => _DashboardScaffoldState();
}

class _DashboardScaffoldState extends State<DashboardHomeScaffold> {
  final GlobalKey _topSectionKey = GlobalKey();
  double _topSectionHeight = 200; // Default height (fallback)
  void _calculateTopSectionHeight() {
    final renderBox =
        _topSectionKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      setState(() {
        _topSectionHeight = renderBox.size.height;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Wait for the next frame to calculate widget size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _calculateTopSectionHeight();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: const DashboardLeftDrawer(),

      backgroundColor: bgColorSecondary,
      // body: body
      body: CustomScrollView(
        slivers: [
          // ✅ Parallax Effect (SliverAppBar acts like topSection)
          SliverAppBar(
            leading: Builder(builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  size: 40,
                ),
              );
            }),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const NotificationListScreen()));
                  },
                  icon: const Icon(
                    Icons.notifications,
                    size: 35,
                  ))
            ],
            backgroundColor: Colors.transparent,
            expandedHeight: _topSectionHeight + 30, // Adjust height as needed
            floating: false,
            pinned: true, // Set true if you want it to stay visible
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 0,
                    child: Image.asset(bgCircleTopLeft),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 56),
                      Center(
                          child:
                              widget.topSection), // 👈 Place top section here
                    ],
                  )
                ],
              ),
            ),
          ),

          // ✅ Scrollable Bottom Section
          SliverFillRemaining(
            hasScrollBody: true,
            child: Container(
              color: bgPrimaryColor,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(bgCircleBottomRight),
                  ),
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: widget.bottomSection,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // body: Column(
      //   mainAxisSize: MainAxisSize.max,
      //   children: [
      //     Stack(
      //       // fit: StackFit.loose,
      //       children: [
      //         Positioned(
      //           top: 0,
      //           left: 0,
      //           child: Image.asset(bgCircleTopLeft),
      //         ),
      //         Column(
      //           children: [
      //             SizedBox(height: appBarHeight),
      //             topSection,
      //           ],
      //         ),
      //       ],
      //     ),
      //     Expanded(
      //         child: Container(
      //       color: bgPrimaryColor,
      //       child: Stack(
      //         children: [
      //           SingleChildScrollView(child: bottomSection),
      //           Positioned(
      //             bottom: 0,
      //             right: 0,
      //             child: Image.asset(bgCircleBottomRight),
      //           ),
      //         ],
      //       ),
      //     ))
      //   ],
      // ),
    );
  }
}
