import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank/components/container.dart';
import 'package:mybank/components/localization/eager_localization.dart';
import 'package:mybank/components/localization/i18n_container.dart';
import 'package:mybank/components/localization/i18n_loadingview.dart';
import 'package:mybank/components/localization/i18n_messages.dart';
import 'package:mybank/models/name_change.dart';
import 'package:mybank/screens/contacts_list.dart';
import 'package:mybank/screens/dashboard/dashboard_i18n.dart';
import 'package:mybank/screens/home/home_page.dart';
import 'package:mybank/screens/name_container.dart';
import 'package:mybank/screens/transactions_list.dart';

class DashboardView extends StatelessWidget {
  final DashboardViewLazyI18N _i18n;

  const DashboardView(this._i18n, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const HomePage(),
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
                  _i18n.transfer!,
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
                  _i18n.transactionFeed!,
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
                  _i18n.profile!,
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


