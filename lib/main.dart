import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:flutter_multiple_global_loaders_tutorial/loader.dart';
import 'package:flutter_multiple_global_loaders_tutorial/overlayStore.dart';
import 'package:flutter_multiple_global_loaders_tutorial/widgets/loadingOverlay.dart';

void main() {
  runApp(
    MultiProvider(providers: [
      Provider<OverlayStore>(create: (_) => OverlayStore()),
    ], child: MyApp()),
  );
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  void _inseretOverlays(
      BuildContext appContext, BuildContext navigatorContext) {
    return Overlay.of(navigatorContext).insert(
      OverlayEntry(builder: (navigatorContext) {
        OverlayStore overlayStore = Provider.of<OverlayStore>(appContext);
        return Observer(builder: (_) {
          bool visable = overlayStore.displayLoading;
          if (visable) {
            List<LoaderModel> loaders = overlayStore.loaders;
            List<String> messages =
                loaders.map((LoaderModel loader) => loader.message).toList();
            return LoadingOverlayWidget(messages: messages);
          } else {
            return Container();
          }
        });
      }),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: WillPopScope(
        onWillPop: () async => !await _navigatorKey.currentState.maybePop(),
        child: LayoutBuilder(
          builder: (context, constraints) {
            WidgetsBinding.instance.addPostFrameCallback(
                (_) => _inseretOverlays(context, _navigatorKey.currentContext));
            return Material(
              key: _navigatorKey,
              child: MyHomePage(title: 'Flutter Demo Home Page'),
            );
          },
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  void _randomTask(OverlayStore overlayStore, int index) async {
    print("loading $index");
    int sleepFor = 1000 + Random().nextInt(4000);
    LoaderModel loader =
        LoaderModel(message: "loading $index for $sleepFor milliseconds");
    overlayStore.addLoader(loader);
    await Future.delayed(Duration(milliseconds: sleepFor));
    overlayStore.removeLoader(loader.id);
    print("finished loading $index");
  }

  void _multipleRandomTasks(OverlayStore overlayStore, int num) async {
    for (int i = 0; i < num; i++) {
      _randomTask(overlayStore, i);
    }
  }

  @override
  Widget build(BuildContext context) {
    final OverlayStore overlayStore =
        Provider.of<OverlayStore>(context, listen: false);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text("run 1 task"),
              onPressed: () => _multipleRandomTasks(overlayStore, 1),
            ),
            FlatButton(
              child: Text("run 5 tasks"),
              onPressed: () => _multipleRandomTasks(overlayStore, 5),
            ),
            FlatButton(
              child: Text("run 10 tasks"),
              onPressed: () => _multipleRandomTasks(overlayStore, 10),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
