import 'package:flutter/material.dart';

import 'package:hrm_manager/constant/app_text.dart';
import 'package:hrm_manager/extensions/size_extension.dart';
import 'package:hrm_manager/utils/app_color.dart';

class AppDropdownInput<T> extends StatelessWidget {
  final List<T> options;
  final T value;
  final void Function(T) onChanged;
  AppDropdownInput({
    this.options = const [],
    required this.value,
    required this.onChanged,
    required this.border,
  });

final InputBorder border;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.getSize.height * 0.048,
      child: FormField<T>(
        builder: (FormFieldState<T> state) {
          return InputDecorator(
            decoration: InputDecoration(
              hintStyle: textStyle(
                  context: context,
                  textColor: AppColor.iconColor,
                  fontSize: 14),
              fillColor: AppColor.whiteColor,
              filled: true,
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: border,
              errorBorder: border,
              enabledBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              focusedErrorBorder: border,
            ),
            isEmpty: value == null || value == '',
            child: DropdownButtonHideUnderline(
              child: DropdownButton<T>(
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColor.iconColor,
                ),
                value: value,
                isDense: true,
                onChanged: (value) {
                  onChanged(value!);
                },
                items: options.map((T value) {
                  return DropdownMenuItem<T>(
                      value: value,
                      child: value == ''
                          ? const SizedBox.shrink()
                          : Text(value.toString(),
                              style: textStyle(
                                context: context,
                                textColor: AppColor.iconColor,
                                fontSize: 14,
                              )));
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
