import 'package:flutter/material.dart';
import 'package:mybank/components/container.dart';
import 'package:mybank/components/progress/progress.dart';
import 'package:mybank/database/dao/contact_dao.dart';
import 'package:mybank/models/contact.dart';
import 'package:mybank/screens/contact_form.dart';
import 'package:mybank/screens/transaction_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ContactsListState {
  const ContactsListState();
}

class LoadingContactsListState extends ContactsListState {
  const LoadingContactsListState();
}

class LoadedContactsListState extends ContactsListState {
  final List<Contact> _contacts;

  const LoadedContactsListState(this._contacts);
}

class InitContactsListState extends ContactsListState {
  const InitContactsListState();
}

class FatalErrorContactsListState extends ContactsListState {
  const FatalErrorContactsListState();
}

class ContactsListCubit extends Cubit<ContactsListState> {
  ContactsListCubit() : super(const InitContactsListState());

  void reload(ContactDao contactDao) async {
    emit(const LoadingContactsListState());
    contactDao
        .findAll()
        .then((contacts) => emit(LoadedContactsListState(contacts)));
  }
}

class ContactListContainer extends BlocContainer {
  const ContactListContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ContactDao contactDao = ContactDao();

    return BlocProvider<ContactsListCubit>(
      create: (BuildContext context) {
        final cubit = ContactsListCubit();
        cubit.reload(contactDao);
        return cubit;
      },
      child: ContactList(contactDao),
    );
  }
}

class ContactList extends StatelessWidget {
  final ContactDao _contactDao;

  const ContactList(this._contactDao, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(
          'Transfer',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () async {
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ContactForm(),
                ),
              );
              update(context);
            },
            iconSize: 32,
          ),
        ],
      ),
      // backgroundColor: Colors.white,
      body: BlocBuilder<ContactsListCubit, ContactsListState>(
        builder: (context, state) {
          if (state is InitContactsListState ||
              state is LoadingContactsListState) {
            return const Progress(message: 'Loading...',);
          }

          if (state is LoadedContactsListState) {
            final contacts = state._contacts;
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return _ContactItem(
                  contact,
                  onClick: () {
                    push(context, TransactionFormContainer(contact));
                  },
                );
              },
              itemCount: contacts.length,
            );
          }
          return const Text('Unknown error');
        },
      ),
      bottomNavigationBar: IconButton(
        icon: Icon(
          Icons.home,
          color: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
        iconSize: 60,
      ),
    );
  }

  void update(BuildContext context) {
    context.read<ContactsListCubit>().reload(_contactDao);
  }
}

class _ContactItem extends StatelessWidget {
  final Contact contact;
  final Function onClick;

  const _ContactItem(
    this.contact, {
    required this.onClick,
  });

  // const _ContactItem({Key? key, required this.contact, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Theme.of(context).colorScheme.primary,
        child: ListTile(
          onTap: () => onClick(),
          title: Text(
            contact.fullName,
            style: const TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: Text(
            'Account Number: ${contact.accountNumber.toString()}',
            style: const TextStyle(fontSize: 16.0),
          ),
        ),
      ),
    );
  }
}
