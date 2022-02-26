import 'dart:io';
import 'package:flutter/foundation.dart';

class ImageData {
  final String id;
  final String title;
  final String objectiveID;
  final String description;
  final String goal;
  List<String> tags = [];
  List<String> meta_tags = [];
  final String user_id; //owners id
  // final PlaceLocation location;
  final File image;
  final DateTime dateTime;

  ImageData({
    @required this.id,
    this.title,
    this.tags,
    this.description,
    this.goal,
    this.objectiveID,
    this.meta_tags,
    this.user_id,
    // @required this.location,
    @required this.image,
    @required this.dateTime
  });
}
