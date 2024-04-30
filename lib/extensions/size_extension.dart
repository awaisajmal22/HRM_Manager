
import 'package:flutter/material.dart';

extension SizeExtension on BuildContext{
  Size get getSize => MediaQuery.of(this).size;
}