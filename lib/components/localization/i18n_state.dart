import 'package:mybank/components/localization/i18n_messages.dart';

abstract class I18NMessagesState {
  const I18NMessagesState();
}

class LoadingI18NMessagesState extends I18NMessagesState {
  const LoadingI18NMessagesState();
}

class LoadedI18NMessagesState extends I18NMessagesState {
  final I18NMessages messages;

  const LoadedI18NMessagesState(this.messages);
}



class InitI18NMessagesState extends I18NMessagesState {
  const InitI18NMessagesState();
}

class FatalErrorI18NMessagesState extends I18NMessagesState {
  const FatalErrorI18NMessagesState();
}