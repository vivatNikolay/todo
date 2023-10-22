import 'package:flutter/material.dart';

enum FilterState {
  all('All', Icon(Icons.list)),
  active('Active', Icon(Icons.check_circle_outline)),
  completed('Completed', Icon(Icons.check_circle));

  const FilterState(this.name, this.icon);
  final String name;
  final Icon icon;
}