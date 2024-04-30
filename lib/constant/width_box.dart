import 'package:flutter/material.dart';
import 'package:hrm_manager/extensions/size_extension.dart';

getWidth({
  required BuildContext context,
  required double width,
}){
  return SizedBox(
    width: context.getSize.width * width,
  );
}