import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BreadCrumbProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomePage(),
        routes: {
          '/new': (context) => const NewBreadCrumWidget(),
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          Consumer<BreadCrumbProvider>(
            builder: (context, value, child) {
              // print("inside consumer--> ${value.items}");
              return BreadCrumbWidget(items: value.items);
            },
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/new');
              },
              child: const Text('Add a new bread crumb')),
          TextButton(
              onPressed: () {
                context.read<BreadCrumbProvider>().reset();
              },
              child: const Text('Reset'))
        ],
      ),
    );
  }
}

class BreadCrumb {
  final String name;
  String uuid;
  bool isActive;

  BreadCrumb({required this.isActive, required this.name})
      : uuid = const Uuid().v4();

  void activate() {
    isActive = true;
  }

  @override
  bool operator ==(covariant BreadCrumb other) => uuid == other.uuid;

  @override
  int get hashCode => uuid.hashCode;

  String get title => name + (isActive ? ' > ' : ' ');
}

class BreadCrumbProvider extends ChangeNotifier {
  final List<BreadCrumb> _items = [];
  UnmodifiableListView<BreadCrumb> get items => UnmodifiableListView(_items);
  void add(BreadCrumb breadCrumb) {
    for (final item in _items) {
      item.activate();
    }
    print(_items);
    _items.add(breadCrumb);
    print(_items);
    // print(item.name);
    //print(_items.add(breadCrumb));
  }

  void reset() {
    _items.clear();
  }
}

class BreadCrumbWidget extends StatelessWidget {
  final UnmodifiableListView<BreadCrumb> items;
  const BreadCrumbWidget({Key? key, required this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: items.map((breadCrumb) {
        return Text(
          breadCrumb.title,
          style: TextStyle(
            color: breadCrumb.isActive ? Colors.blue : Colors.black,
          ),
        );
      }).toList(),
    );
  }
}

class NewBreadCrumWidget extends StatefulWidget {
  const NewBreadCrumWidget({Key? key}) : super(key: key);

  @override
  State<NewBreadCrumWidget> createState() => _NewBreadCrumWidgetState();
}

class _NewBreadCrumWidgetState extends State<NewBreadCrumWidget> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Bread Crumb'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _controller,
            decoration:
                const InputDecoration(hintText: 'Add a new Bread Crumb'),
          ),
          TextButton(
              onPressed: () {
                final text = _controller.text;
                print(text);
                if (text.isNotEmpty) {
                  final breadCrumb = BreadCrumb(isActive: false, name: text);
                  print(breadCrumb);
                  context.read<BreadCrumbProvider>().add(breadCrumb);
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Add'))
        ],
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  @override
  Widget build(BuildContext context) {}
}

abstract class Logger {
  void log(String message);
}

abstract class FileLogger implements Logger {
  @override
  void log(String message) {
    print('FileLogger: $message');
  }

  void logToFile(String message);
}

class PdfFileLogger extends FileLogger {
  @override
  void logToFile(String message) {
    String filePath = _createFile(message);
    print(filePath);
  }

  String _createFile(String message) {
    return 'android/data/com.example flutter app/files/log.txt://tilepath';
  }
}

void main() {
  String logMessage = 'log created';
  final pdfFile = FileLogger;
}
