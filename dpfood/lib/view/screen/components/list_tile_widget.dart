import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  // final Widget? leading;
  // final Widget? title;
  // final Widget? subtitle;
  // final Widget? trailing;
  final ListTile? listTile;

  const ListTileWidget(
      {Key? key, this.listTile})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return listTile!;
  }
}
