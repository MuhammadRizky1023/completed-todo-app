import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todolist/utils/utils.dart';

class CommenTextField extends StatelessWidget {
  const CommenTextField(
      {super.key,
      required this.title,
      required this.hintText,
      this.controller,
      this.maxLine,
      this.suffixIcon,
      this.readOnly = false});

  final String title;
  final String hintText;
  final TextEditingController? controller;
  final int? maxLine;
  final Widget? suffixIcon;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          title,
          style: context.textTheme.titleLarge,
        ),
        const Gap(12),
        TextField(
          readOnly: readOnly,
          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          maxLines: maxLine,
          decoration:
              InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
          onChanged: (value) {},
        ),
      ],
    );
  }
}
