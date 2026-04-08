import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

enum Options { Search, Upload, Copy, Exit }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var _menuIndex = 0;
  Color _changeColorIndex = Colors.cyanAccent;
  var appBarHeight = AppBar().preferredSize.height;

  _buildAppBar() {
    return AppBar(
      title: Text(
        'Pop Up Menus',
        style: TextStyle(color: Colors.white, fontSize: 20),
      ),
      actions: [
        PopupMenuButton(
            onSelected: (value) {
              _onMenuSelected(value as int);
            },
            offset: Offset(0.0, appBarHeight),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            itemBuilder: (context) => [
                  _buildPopUpMenuItem(
                      'Search', Icons.search, Options.Search.index),
                  _buildPopUpMenuItem(
                      'Upload', Icons.upload, Options.Upload.index),
                  _buildPopUpMenuItem('Copy', Icons.copy, Options.Copy.index),
                  _buildPopUpMenuItem(
                      'Exit', Icons.exit_to_app, Options.Exit.index),
                ])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: Container(
          color: _changeColorIndex,
        ));
  }

  PopupMenuItem _buildPopUpMenuItem(
      String title, IconData iconData, int index) {
    return PopupMenuItem(
        value: index,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          Icon(
            iconData,
            color: Colors.black,
          ),
          Text(title)
        ]));
  }

  void _onMenuSelected(int value) {
    setState(() {
      _menuIndex = value;
    });
    if (value == Options.Search.index) {
      _changeColorIndex = Colors.redAccent;
    } else if (value == Options.Upload.index) {
      _changeColorIndex = Colors.blueAccent;
    } else if (value == Options.Copy.index) {
      _changeColorIndex = Colors.greenAccent;
    } else {
      _changeColorIndex = Colors.deepOrangeAccent;
    }
  }
}
