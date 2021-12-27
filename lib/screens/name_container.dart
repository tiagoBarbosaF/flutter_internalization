import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mybank/components/container.dart';
import 'package:mybank/models/name_change.dart';

class NameContainer extends BlocContainer {
  const NameContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NameView();
  }
}

class NameView extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  NameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _nameController.text = context.read<NameCubit>().state;

    BlocBuilder<NameCubit, String>(
      builder: (context, state) {
        return Text(state);
      },
    );

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
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            border: OutlineInputBorder(),
                            labelText: 'Desired name',
                            labelStyle: TextStyle(
                                fontSize: 24,
                                // color: Colors.black54,
                                fontWeight: FontWeight.bold),
                          ),
                          autofocus: true,
                          autocorrect: true,
                          enableSuggestions: true,
                          enableInteractiveSelection: true,
                          style: const TextStyle(
                            fontSize: 32,
                            color: Colors.black38,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              onPressed: () {
                                final name = _nameController.text;
                                context.read<NameCubit>().changeName(name);
                                Navigator.pop(context);
                              },
                              child: const Text('Change name'),
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
}
