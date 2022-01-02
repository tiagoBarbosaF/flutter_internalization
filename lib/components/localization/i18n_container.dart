import 'package:flutter/widgets.dart';
import 'package:mybank/components/container.dart';
import 'package:mybank/components/localization/i18n_cubit.dart';
import 'package:mybank/components/localization/i18n_loadingview.dart';
import 'package:mybank/http/webclients/i18n_webclient.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class I18NLoadingContainer extends BlocContainer {
  final I18NWidgetCreator creator;
  final String viewKey;

  const I18NLoadingContainer({
    required this.creator,
    required this.viewKey,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<I18NMessagesCubit>(
      create: (BuildContext context) {
        final cubit = I18NMessagesCubit(viewKey);
        cubit.reload(I18NWebClient(viewKey));
        return cubit;
      },
      child: I18NLoadingView(creator),
    );
  }
}
