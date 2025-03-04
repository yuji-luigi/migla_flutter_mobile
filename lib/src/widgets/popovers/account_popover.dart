import 'package:flutter/widgets.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';

class AccountPopover extends StatelessWidget {
  const AccountPopover({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: colorBlack.withAlpha(850),
            ),
            image: DecorationImage(
              image: NetworkImage(
                  'https://images.unsplash.com/photo-1633332755192-727a05c4013d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=250&q=80'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Demo Username',
                  style: textStyleCaptionMd.copyWith(
                      overflow: TextOverflow.ellipsis)),
              Text('demo_email@demo.com',
                  style: textStyleCaptionMd.copyWith(
                    overflow: TextOverflow.ellipsis,
                    color: colorTextDisabled,
                  )),
            ],
          ),
        )
      ],
    );
  }
}
