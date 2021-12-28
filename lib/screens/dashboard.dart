import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank/components/container.dart';
import 'package:mybank/components/localization.dart';
import 'package:mybank/models/name_change.dart';
import 'package:mybank/screens/contacts_list.dart';
import 'package:mybank/screens/name_container.dart';
import 'package:mybank/screens/transactions_list.dart';

class DashboardContainer extends BlocContainer {
  const DashboardContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NameCubit(''),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = DashboardViewI18N(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.verified_user,
                    color: Theme.of(context).colorScheme.primary, size: 50.0),
                Text(
                  'myBank',
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            BlocBuilder<NameCubit, String>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 32),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: i18n.welcome()!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        TextSpan(
                          text: state,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: IconButton(
                    onPressed: () => _showContactList(context),
                    icon: const Icon(Icons.monetization_on),
                    iconSize: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  i18n.transfer(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: IconButton(
                    onPressed: () => _showTransactionsList(context),
                    icon: const Icon(Icons.description),
                    iconSize: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  i18n.transactionFeed(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
            VerticalDivider(
              width: 1,
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: Theme.of(context).colorScheme.primary,
            ),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: IconButton(
                    onPressed: () => _showChangeName(context),
                    icon: const Icon(Icons.person),
                    iconSize: 50,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(
                  i18n.profile(),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showContactList(BuildContext context) {
    push(context, const ContactListContainer());
  }

  _showChangeName(BuildContext blocContext) {
    Navigator.of(blocContext).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: BlocProvider.of<NameCubit>(blocContext),
          child: const NameContainer(),
        ),
      ),
    );
  }

  _showTransactionsList(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TransactionsList(),
      ),
    );
  }
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
