import 'package:flutter/material.dart';
import 'package:migla_flutter/src/layouts/dashboard_layout.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class PhotoVideosTopScreen extends StatelessWidget {
  const PhotoVideosTopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DashboardLayout(
        title: 'Photo & Videos',
        body: Container(
          color: bgPrimaryColor,
          width: double.infinity,
          child: Column(
            children: [
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
              Text('data'),
            ],
          ),
        ));
  }
}
