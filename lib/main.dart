import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:reading_flutter/src/app.dart';

import 'src/net/http_client_factory.dart'
    if (dart.library.js_interop) 'src/net/http_client_factory_web.dart'
    as http_factory;

main() {
  runApp(Provider<Client>(
    create: (context) {
      return http_factory.httpClient();
    },
    child: const Reading(),
    dispose: (context, client) {
      client.close();
    },
  ));
}
