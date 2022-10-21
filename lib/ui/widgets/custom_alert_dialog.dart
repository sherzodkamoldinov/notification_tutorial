import 'package:flutter/material.dart';
import 'package:notification_tutorial/ui/widgets/custom_text_field.dart';
import 'package:notification_tutorial/utils/colors.dart';
import 'package:notification_tutorial/utils/style.dart';

Widget showCustomAlerDialog({
  required TextEditingController titleCon,
  required TextEditingController descCon,
}) {
  return AlertDialog(
    title: Text(
      'Add Todo',
      style: CustomTextStyle().copyWith(
        color: MyColors.bluePurple,
      ),
    ),
    content: SizedBox(
      height: 150,
      child: Column(children: [
        CustomTextField(
          controller: titleCon,
        ),
        const SizedBox(height: 10),
        CustomTextField(
          controller: descCon,
        ),
      ]),
    ),
    actions: [
      TextButton(
        onPressed: () {},
        child: Text(
          'SAVE',
          style: CustomTextStyle().copyWith(color: MyColors.bluePurple),
        ),
      )
    ],
    scrollable: false,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
