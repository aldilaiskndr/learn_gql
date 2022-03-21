import 'package:flutter/material.dart';

// import 'package:app_boilerplate/services/shared_preferences_service.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static final HttpLink httpLink = HttpLink(
      'https://hasura.io/learn/graphql'
  );
  static String? _token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuZXdiaWVAZW5pZ21hLmNvbSIsIm5hbWUiOiJuZXdiaWUiLCJpYXQiOjE2NDc1NzQ1NDIuNzg0LCJpc3MiOiJodHRwczovL2hhc3VyYS5pby9sZWFybi8iLCJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsidXNlciJdLCJ4LWhhc3VyYS11c2VyLWlkIjoibmV3YmllQGVuaWdtYS5jb20iLCJ4LWhhc3VyYS1kZWZhdWx0LXJvbGUiOiJ1c2VyIiwieC1oYXN1cmEtcm9sZSI6InVzZXIifSwiZXhwIjoxNjQ3NjYwOTQyfQ.yY4nBELMc1vrjiGkcCurxk4XBraHRVcl5XgSLs8i13E";
  static final AuthLink authLink = AuthLink(getToken: () => _token);
  static final WebSocketLink websocketLink = WebSocketLink(
    'wss://hasura.io/learn/graphql',
    config: SocketClientConfig(
      autoReconnect: true,
      inactivityTimeout: const Duration(seconds: 30),
      initialPayload: () async {
        return {
          'headers': {'Authorization': _token},
        };
      },
    ),
  );
  static final Link link = authLink.concat(websocketLink);
  static String? token;

  static ValueNotifier<GraphQLClient> initailizeClient(String? token) {
    _token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJuZXdiaWVAZW5pZ21hLmNvbSIsIm5hbWUiOiJuZXdiaWUiLCJpYXQiOjE2NDc1NzQ1NDIuNzg0LCJpc3MiOiJodHRwczovL2hhc3VyYS5pby9sZWFybi8iLCJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWFsbG93ZWQtcm9sZXMiOlsidXNlciJdLCJ4LWhhc3VyYS11c2VyLWlkIjoibmV3YmllQGVuaWdtYS5jb20iLCJ4LWhhc3VyYS1kZWZhdWx0LXJvbGUiOiJ1c2VyIiwieC1oYXN1cmEtcm9sZSI6InVzZXIifSwiZXhwIjoxNjQ3NjYwOTQyfQ.yY4nBELMc1vrjiGkcCurxk4XBraHRVcl5XgSLs8i13E";
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        cache: GraphQLCache(),
        link: link,
      ),
    );
    return client;
  }
}
