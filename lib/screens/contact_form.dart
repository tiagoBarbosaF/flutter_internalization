import 'package:flutter/material.dart';
import 'package:mybank/database/dao/contact_dao.dart';
import 'package:mybank/models/contact.dart';

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key}) : super(key: key);

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final ContactDao _contactDao = ContactDao();

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
                    'New contact',
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
                        TextField(
                          controller: _fullNameController,
                          autofocus: true,
                          autocorrect: true,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                            labelText: 'Desired name',
                            labelStyle: TextStyle(
                                fontSize: 24,
                                // color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.black38,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: TextField(
                            controller: _accountNumber,
                            decoration: const InputDecoration(
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                              border: OutlineInputBorder(),
                              labelText: 'Account number',
                              labelStyle: TextStyle(
                                  fontSize: 24,
                                  // color: Colors.black54,
                                  fontWeight: FontWeight.bold),
                            ),
                            style: const TextStyle(
                              fontSize: 32,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.maxFinite,
                          child: ElevatedButton(
                            onPressed: () {
                              final String fullName = _fullNameController.text;
                              final int? accountNumber =
                                  int.tryParse(_accountNumber.text);
                              final Contact newContact =
                                  Contact(0, fullName, accountNumber);
                              _contactDao.save(newContact).then(
                                    (id) => Navigator.pop(context),
                                  );
                            },
                            child: const Text(
                              'Create',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
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
