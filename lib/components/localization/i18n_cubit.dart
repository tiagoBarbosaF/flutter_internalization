import 'package:mybank/components/localization/i18n_messages.dart';
import 'package:mybank/components/localization/i18n_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:localstorage/localstorage.dart';
import 'package:mybank/http/webclients/i18n_webclient.dart';

class I18NMessagesCubit extends Cubit<I18NMessagesState> {
  final LocalStorage storage = LocalStorage('local_unsecure_v1.json');

  final String _viewKey;

  I18NMessagesCubit(this._viewKey) : super(const InitI18NMessagesState());

  reload(I18NWebClient client) async {
    emit(const LoadingI18NMessagesState());
    await storage.ready;
    final items = storage.getItem(_viewKey);
    print('Loaded $_viewKey $items');
    if (items != null) {
      emit(LoadedI18NMessagesState(I18NMessages(items)));
      return;
    }
    client.findAll().then(saveAndRefresh);
  }

  saveAndRefresh(Map<String, dynamic> messages) {
    storage.setItem(_viewKey, messages);
    print('saving $_viewKey $messages');
    final state = LoadedI18NMessagesState(I18NMessages(messages));
    emit(state);
  }
}