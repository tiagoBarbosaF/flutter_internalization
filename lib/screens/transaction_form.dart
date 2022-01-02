import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mybank/components/container.dart';
import 'package:mybank/components/error_view.dart';
import 'package:mybank/components/progress/progress_view.dart';
import 'package:mybank/components/success.dart';
import 'package:mybank/components/transaction_auth_dialog.dart';
import 'package:mybank/http/webclients/transaction_webclient.dart';
import 'package:mybank/models/contact.dart';
import 'package:mybank/models/transaction.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

abstract class TransactionFormState {
  const TransactionFormState();
}

class SendingState extends TransactionFormState {
  const SendingState();
}

class SentState extends TransactionFormState {
  const SentState();
}

class ShowFormState extends TransactionFormState {
  const ShowFormState();
}

class FatalErrorFormState extends TransactionFormState {
  final String _message;

  const FatalErrorFormState(this._message);
}

class TransactionFormCubit extends Cubit<TransactionFormState> {
  TransactionFormCubit() : super(const ShowFormState());

  void save(Transaction transactionCreated, String password,
      BuildContext context) async {
    emit(const SendingState());
    await _send(
      transactionCreated,
      password,
      context,
    );
  }

  _send(Transaction transactionCreated, String password,
      BuildContext context) async {
    await TransactionWebClient()
        .save(transactionCreated, password)
        .then((transaction) => emit(const SentState()))
        .catchError((e) {
      emit(
        const FatalErrorFormState('timeout submitting the transaction'),
      );
    }, test: (e) => e is TimeoutException).catchError((e) {
      emit(
        FatalErrorFormState(e.message),
      );
    }, test: (e) => e is HttpException).catchError(
      (e) {
        emit(
          FatalErrorFormState(e.message),
        );
      },
    );
  }
}

class TransactionFormContainer extends BlocContainer {
  final Contact _contact;

  const TransactionFormContainer(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionFormCubit>(
      create: (BuildContext context) {
        return TransactionFormCubit();
      },
      child: BlocListener<TransactionFormCubit, TransactionFormState>(
        listener: (context, state) {
          Future.delayed(
            const Duration(seconds: 3),
            () {
              if (state is SentState) {
                Navigator.pop(context);
              }
            },
          );
        },
        child: TransactionForm(_contact),
      ),
    );
  }
}

class TransactionForm extends StatelessWidget {
  final Contact _contact;

  const TransactionForm(this._contact, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionFormCubit, TransactionFormState>(
      builder: (context, state) {
        if (state is ShowFormState) {
          return _BasicForm(_contact);
        }
        if (state is SendingState) {
          return const ProgressView(
            message: '😥🤞\n',
          );
        }
        if (state is SentState) {
          return const SuccessView('Success!');
        }
        if (state is FatalErrorFormState) {
          return ErrorView(state._message);
        }
        return const ErrorView('Unknown error');
      },
    );
  }
}

class _BasicForm extends StatelessWidget {
  final Contact _contact;
  final TextEditingController _valueController = TextEditingController();
  final String transactionId = const Uuid().v4();

  _BasicForm(this._contact);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Text(
                    'New transaction',
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          _contact.fullName,
                          style: const TextStyle(
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "Account: ${_contact.accountNumber.toString()}",
                          style: const TextStyle(fontSize: 16.0),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: TextField(
                            controller: _valueController,
                            autofocus: true,
                            style: const TextStyle(fontSize: 24.0),
                            decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(),
                              labelText: 'Value',
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            child: const Text("Transfer",
                                style: TextStyle(
                                    fontSize: 18.0, fontWeight: FontWeight.bold)),
                            onPressed: () {
                              final double? value =
                                  double.tryParse(_valueController.text);
                              final transactionCreated =
                                  Transaction(transactionId, value!, _contact);
                              // _webClient
                              //     .save(transactionCreated)
                              //     .then((transaction) => Navigator.pop(context));
                              showDialog(
                                context: context,
                                builder: (contextDialog) {
                                  return TransactionAuthDialog(
                                    onConfirm: (String password) {
                                      BlocProvider.of<TransactionFormCubit>(
                                              context)
                                          .save(transactionCreated, password,
                                              context);
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: IconButton(
        icon: Icon(
          Icons.keyboard_return,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        iconSize: 60,
      ),
    );
  }
}
