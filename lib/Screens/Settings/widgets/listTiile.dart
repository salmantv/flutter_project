// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:timezone/data/latest.dart' as tz;

// ignore: must_be_immutable
class MylistTile extends StatefulWidget {
  MylistTile({Key? key, this.icon, this.name}) : super(key: key);

  IconData? icon;
  String? name;

  @override
  State<MylistTile> createState() => _MylistTileState();
}

class _MylistTileState extends State<MylistTile> {
  @override
  void initState() {
    super.initState();
    tz.initializeTimeZones();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Card(
            elevation: 4,
            child: ListTile(
              leading: Icon(
                widget.icon,
                size: 30,
              ),
              title: Text('${widget.name}'),
            ),
          ),
        ),
      ],
    );
  }
}
