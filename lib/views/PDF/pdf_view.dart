import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pdfx/pdfx.dart';
import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/constant/width_box.dart';
import 'package:hrm_manager/extensions/size_extension.dart';

import '../../constant/back.dart';
import '../../utils/app_color.dart';

class PDFView extends StatefulWidget {
  final String title;
  final String pdfPath;
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
    _pdfControllerPinch =
        PdfControllerPinch(document: PdfDocument.openAsset(widget.pdfPath));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Expanded(child: PdfViewPinch(controller: _pdfControllerPinch))
        ],
      )),
    );
  }
}
