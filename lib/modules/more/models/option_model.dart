import 'package:flutter/material.dart';

class Option {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  Option({required this.title, required this.icon, required this.onTap});
}
