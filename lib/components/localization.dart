import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'container.dart';

class LocalizationContainer extends BlocContainer {
  final Widget child;

  const LocalizationContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CurrentLocaleCubit>(
      create: (context) => CurrentLocaleCubit(),
      child: child,
    );
  }
}

class CurrentLocaleCubit extends Cubit<String> {
  CurrentLocaleCubit() : super('pt-br');
}

class ViewI18N {
  String _language = '';

  ViewI18N(BuildContext context){
   _language = BlocProvider.of<CurrentLocaleCubit>(context).state;
  }

  String? localize(Map<String, String> values) {
    return values[_language];
  }
}