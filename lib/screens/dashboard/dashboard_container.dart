import 'package:flutter/widgets.dart';
import 'package:mybank/components/container.dart';
import 'package:mybank/components/localization/i18n_container.dart';
import 'package:mybank/models/name_change.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank/screens/dashboard/dashboard_i18n.dart';
import 'package:mybank/screens/dashboard/dashboard_view.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit(''),
      child: I18NLoadingContainer(
        viewKey: 'dashboard',
        creator: (messages) => DashboardView(DashboardViewLazyI18N(messages)),
      ),
    );
  }
}