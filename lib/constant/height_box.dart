import 'package:flutter/material.dart';
import 'package:hrm_manager/extensions/size_extension.dart';

getHeight({
  required BuildContext context,
  required double height,
}){
  return SizedBox(
    height: context.getSize.height * height,
  );
}