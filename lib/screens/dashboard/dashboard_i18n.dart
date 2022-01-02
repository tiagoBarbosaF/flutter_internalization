import 'package:flutter/widgets.dart';
import 'package:mybank/components/localization/eager_localization.dart';
import 'package:mybank/components/localization/i18n_messages.dart';

class DashboardViewLazyI18N {
  final I18NMessages _messages;

  DashboardViewLazyI18N(this._messages);

  String? get transfer => _messages.get('transfer');

  String? get transactionFeed => _messages.get('transactionFeed');

  String? get profile => _messages.get('profile');

// String get welcome => _messages.get('Welcome');
}

class DashboardViewI18N extends ViewI18N {
  DashboardViewI18N(BuildContext context) : super(context);

  String transfer() {
    return localize(
      {
        'pt-br': 'Transferir',
        'en': 'Transfer',
        'spa': 'Transferir',
        'de': "Transfer",
        'jp': 'Tensō'
      },
    );
  }

  String transactionFeed() {
    return localize(
      {'pt-br': 'Transações', 'en': 'Transactions'},
    );
  }

  String profile() {
    return localize(
      {'pt-br': 'Perfil', 'en': 'Profile'},
    );
  }

  String? welcome() {
    return localize(
      {'pt-br': 'Bem vindo ', 'en': 'Welcome '},
    );
  }
}