import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hrm_manager/Model/worker_doc_model.dart';
import 'package:hrm_manager/constant/text_button.dart';
import 'package:pdfx/pdfx.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';

import '../../constant/back.dart';
import '../../constant/app_color.dart';

class PDFView extends StatefulWidget {
  final String title;
  final WorkerDocModel pdfPath;
  const PDFView({super.key, required this.title, required this.pdfPath});

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView> {
  late PdfControllerPinch _pdfControllerPinch;
  @override
  void initState() {
    print(widget.pdfPath);
    // TODO: implement initState
    super.initState();
    if (widget.pdfPath.contentType!.contains('pdf')) {
      _pdfControllerPinch = PdfControllerPinch(
          document: PdfDocument.openFile("${widget.pdfPath.wasabiBytes}"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: SizedBox(
        height: context.getSize.height * 0.08,
        width: context.getSize.width,
        child: Center(
          child: textButton(
              vPadding: 0.020,
              width: context.getSize.width * 0.3,
              radius: 50,
              fontSize: 16,
              context: context,
              onTap: () {
                back(context: context);
              },
              title: 'Close'),
        ),
      ),
      body: SafeArea(
          child: Column(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(vertical: context.getSize.height * 0.020),
            color: const Color(0xffE7E0EC),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    back(context: context);
                  },
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: AppColor.iconColor,
                    size: context.getSize.height * 0.045,
                  ),
                ),
                getWidth(context: context, width: 0.010),
                appText(
                  context: context,
                  title: widget.title,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  textColor: AppColor.iconColor,
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.pdfPath.contentType!.contains('pdf')
                ? PdfViewPinch(controller: _pdfControllerPinch)
                : Image.file(File(widget.pdfPath.wasabiBytes!),
                    fit: BoxFit.cover),
          )
        ],
      )),
    );
  }
}
