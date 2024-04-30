
import 'package:flutter/material.dart';

extension FontSizeExtension on BuildContext {

double fontSize(double fontSize) => MediaQuery.of(this).textScaler.scale(fontSize);
}