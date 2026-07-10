import 'package:flutter/material.dart';

class GroupedModel {
  final Widget groupWidget;
  final List<Widget> itemsWidget;
  final List<Widget> itemsSeparator;

  GroupedModel({required this.groupWidget, required this.itemsWidget, this.itemsSeparator = const []});
}
