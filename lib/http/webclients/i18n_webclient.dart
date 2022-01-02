import 'dart:convert';

import 'package:http/http.dart';

import '../webclient.dart';

const messagesUri =
    'https://gist.githubusercontent.com/tiagoBarbosaF/eb3e698750e18510c20eb2c6b1f8d87f/raw/cde2091148f4c25ef1c6f2913a18e01fc1272913/';

class I18NWebClient {
  final String _viewKey;

  I18NWebClient(this._viewKey);

  Future<Map<String, dynamic>> findAll() async {
    final Response response =
        await client.get(Uri.parse('$messagesUri$_viewKey.json'));
    final Map<String, dynamic> decodedJson = jsonDecode(response.body);
    return decodedJson;
  }
}
