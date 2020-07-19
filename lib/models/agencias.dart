import 'package:flutter/material.dart';

class Agencies {
  final String imageAsset;
  final String city;
  final List<String> services;
  final double lat;
  final double lng;

  Agencies({
    @required this.imageAsset,
    @required this.city,
    @required this.services,
    @required this.lat,
    @required this.lng,
  });
}