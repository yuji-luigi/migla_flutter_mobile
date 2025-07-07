import 'package:flutter/widgets.dart';
import 'package:migla_flutter/src/extensions/localization/localization_context_extension.dart';
import 'package:migla_flutter/src/models/user_model.dart';
import 'package:migla_flutter/src/theme/theme_constants.dart';
import 'package:migla_flutter/src/view_models/me_view_model.dart';

class AccountPopover extends StatelessWidget {
  const AccountPopover({super.key});

  @override
  Widget build(BuildContext context) {
    final MeViewModel meViewModel = $meViewModel(context);
    if (meViewModel.me == null && !meViewModel.isLoading) {
      return Text(context.t.somethingWentWrong);
    }
    UserModel me = meViewModel.me!;
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
              Text(me.fullname,
                  style: textStyleBodyMedium.copyWith(
                      overflow: TextOverflow.ellipsis)),
              Text(me.email,
                  style: textStyleBodyMedium.copyWith(
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
