import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:learn_gql/config.dart';
import 'package:learn_gql/constant.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GraphQLProvider(
      client: Config.initailizeClient(null),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _submitNewData() {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Subscription(
              options: SubscriptionOptions(
                document: gql(
                  Constant.fetchOtp,
                ),
              ),
              builder: (result) {
                if (result.hasException) {
                  print(result.exception?.linkException);
                  return Text(result.exception.toString());
                }
                if (result.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                print(result.data);
                final data = result.data?["todos"];
                // String test = 'test';
                return Expanded(
                  child: ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(data[index]["title"].toString()),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
            // Expanded(
            //   child: Query(
            //     options: QueryOptions(
            //       document: gql(Constant.simpleQuery),
            //     ),
            //     builder: (QueryResult<dynamic> result,
            //         {Future<QueryResult<dynamic>> Function(FetchMoreOptions)?
            //             fetchMore,
            //         Future<QueryResult<dynamic>?> Function()? refetch}) {
            //       final List? otp = result.data?['px_platform_otp'];
            //       if (result.hasException) {
            //         return Text(result.exception.toString());
            //       }
            //       if (result.isLoading) {
            //         return Text('Loading');
            //       }
            //       return Text(otp.toString());
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _submitNewData,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
