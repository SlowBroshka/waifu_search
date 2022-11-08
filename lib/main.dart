import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:waifu_searcher/model/neko_image_model.dart';
import 'package:waifu_searcher/screens/neko_image_screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UrlModel>(
          create: (context) => UrlModel(),
        ),
      ],
      child: MaterialApp(
        title: 'Waifu searcher',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: const MyHomePage(title: 'Waifu searcher'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
          alignment: Alignment.bottomCenter, child: const NekoImageView()),
    );
  }
}
