import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
        useMaterial3: true,
      ),
      home: MyHomePage(title: 'PasSword'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  get passwordArray => null;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Image appIcon = Image.asset('assets/images/img.png');

  final List<Map<String, String>> passwordArray =
  [
    {
      'title': 'email',
      'username': 'cooldad42@gmail.com',
      'password': 'password123'
    },
    {
      'title': 'computer',
      'username': 'Jason',
      'password': 'capitol11'
    },
    {
      'title': 'bank',
      'username': 'JasonBanking',
      'password': 'Arlington52!'
    },
    {
      'title': 'phone',
      'username': 'Jason',
      'password': '1823'
    },
  ];

  void _createRecord() {
    String newTitle = '';
    String newUsername = '';
    String newPassword = '';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                  onChanged: (value) {
                    newTitle = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField (
                    decoration:  const InputDecoration(
                    labelText: 'Username',
                  ),
                  onChanged: (value) {
                    newUsername = value;
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField (
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    newPassword = value;
                  },
                )
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 32.0),
                child: ElevatedButton(
                  child: const Text('Add Record'),
                  onPressed: () {
                    setState(() {
                      // Add the new record to passwordArray
                      passwordArray.add({
                        'title': newTitle,
                        'username': newUsername,
                        'password': newPassword
                      });
                    });
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: SizedBox(
          height: 50,
          child: appIcon,
        ),
      ),
      body: Align(
        alignment: Alignment.topCenter,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: DataTable(
        columns: const [
          DataColumn(label: Text('Title', style: TextStyle(fontSize: 12.0))),
          DataColumn(label: Text('Username', style: TextStyle(fontSize: 12.0))),
          DataColumn(label: Text('Copy', style: TextStyle(fontSize: 12.0))),
        ],
        rows: passwordArray.map((record) {
          return DataRow(
            cells: [
              DataCell(
                  Container(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(record['title']!, style: const TextStyle(fontSize: 10.0)))),
              DataCell(
                  Container(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(record['username']!, style: const TextStyle(fontSize: 10.0)))),
              DataCell(
                IconButton(
                  icon: const Icon(Icons.copy, size: 18.0),
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: record['password']!));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password copied to clipboard'),
                      ),
                    );
                  },
                )
              ),
            ],
          );
        }).toList(),
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _createRecord,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
