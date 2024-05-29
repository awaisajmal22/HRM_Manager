import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/height_box.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/views/AddWorker/component/add_worker_field.dart';

class CustomTwoTextFieldWidget extends StatelessWidget {
  final TextEditingController controllerLeft;
  final TextEditingController controllerRight;
  final String titleLeft;
  final String hintLeft;
  final String hintRight;
  final bool rightReadOnly;
  final TextInputType textInputTypeLeft;
  final TextInputType textInputTypeRight;

  final List<TextInputFormatter>? formatterRight;
  final List<TextInputFormatter>? formatterLeft;
  final String titleRight;

  const CustomTwoTextFieldWidget({
    super.key,
    required this.controllerLeft,
    required this.controllerRight,
    required this.titleLeft,
    required this.titleRight,
    this.formatterLeft,
    this.formatterRight,
    this.hintLeft = '',
    this.hintRight = '',
    this.rightReadOnly = false,
    this.textInputTypeLeft = TextInputType.text,
    this.textInputTypeRight = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appText(
              textAlign: TextAlign.left,
              context: context,
              title: titleLeft,
              fontWeight: FontWeight.w500,
            ),
            getHeight(context: context, height: 0.005),
            addWorkerTextField(
              formatter: formatterLeft,
              textInputType: textInputTypeLeft,
              context: context,
              hintText: hintLeft,
              controller: controllerLeft,
              height: context.getSize.height * 0.050,
            ),
          ],
        )),
        getWidth(context: context, width: 0.030),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            appText(
              textAlign: TextAlign.left,
              context: context,
              title: titleRight,
              fontWeight: FontWeight.w500,
            ),
            getHeight(context: context, height: 0.005),
            addWorkerTextField(
              formatter: formatterRight,
              textInputType: textInputTypeRight,
              readOnly: rightReadOnly,
              context: context,
              hintText: hintRight,
              controller: controllerRight,
              height: context.getSize.height * 0.050,
            ),
          ],
        )),
      ],
    );
  }
}
