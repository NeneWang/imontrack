import 'dart:io';
import 'package:flutter/foundation.dart';

class Objective {
  final String id;
  final String title;
  final String description;

  Objective({
    @required this.id,
    this.title,
    this.description,
  });
}
