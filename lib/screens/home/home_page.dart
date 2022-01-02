import 'package:flutter/material.dart';
import 'package:mybank/models/name_change.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank/screens/dashboard/dashboard_i18n.dart';

import '../dashboard/dashboard_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final i18n = DashboardViewI18N(context);
    return Center(
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
                        text: i18n.welcome(),
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
    );
  }
}
