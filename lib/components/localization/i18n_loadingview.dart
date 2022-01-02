import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank/components/error_view.dart';
import 'package:mybank/components/localization/i18n_cubit.dart';
import 'package:mybank/components/localization/i18n_messages.dart';
import 'package:mybank/components/localization/i18n_state.dart';
import 'package:mybank/components/progress/progress_view.dart';

typedef I18NWidgetCreator = Widget Function(I18NMessages messages);

class I18NLoadingView extends StatelessWidget {
  final I18NWidgetCreator _creator;

  const I18NLoadingView(this._creator, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<I18NMessagesCubit, I18NMessagesState>(
      builder: (context, state) {
        if (state is InitI18NMessagesState ||
            state is LoadingI18NMessagesState) {
          return const ProgressView();
        }
        if (state is LoadedI18NMessagesState) {
          final messages = state.messages;
          return _creator.call(messages);
        }
        return const ErrorView('Loading messages error...');
      },
    );
  }
}
