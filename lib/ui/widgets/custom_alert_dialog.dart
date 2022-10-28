import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_tutorial/cubit/cubit/notification_cubit.dart';
import 'package:notification_tutorial/data/models/notification_model.dart';
import 'package:notification_tutorial/ui/widgets/custom_text_field.dart';
import 'package:notification_tutorial/utils/colors.dart';
import 'package:notification_tutorial/utils/style.dart';

Widget showCustomAlerDialog({
  required BuildContext context,
  required TextEditingController titleCon,
  required TextEditingController descCon,
  required List<String> todoTypes,
  required String currentType,
}) {
  return AlertDialog(
    title: Text(
      'Add Todo',
      style: CustomTextStyle().copyWith(
        color: MyColors.bluePurple,
      ),
    ),
    content: SizedBox(
      height: 250,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTextField(
              controller: titleCon,
            ),
            const SizedBox(height: 10),
            CustomTextField(
              controller: descCon,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField(
              focusColor: MyColors.bluePurple,
              iconEnabledColor: MyColors.bluePurple,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: MyColors.bluePurple,
                  ),
                ),
              ),
              value: currentType,
              borderRadius: BorderRadius.circular(12),
              dropdownColor: MyColors.bluePurple,
              icon: const Icon(Icons.arrow_drop_down),
              iconSize: 25,
              elevation: 0,
              style: const TextStyle(color: Colors.black),
              alignment: Alignment.centerRight,
              onChanged: (newValue) {
                if (newValue != null) {
                  currentType = newValue;
                }
              },
              items: List.generate(
                todoTypes.length,
                (index) => DropdownMenuItem<String>(
                  value: todoTypes[index],
                  child: Text(
                    todoTypes[index],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
    actions: [
      TextButton(
        onPressed: () async {
          for (int i = 0; i < todoTypes.length; i++) {
            if (currentType == todoTypes[i]) {
              debugPrint(currentType);
              debugPrint("CURRENT TYPE $i");
              await context.read<NotificationCubit>().postNotification(
                    NotificationModel(
                      title: titleCon.text,
                      desc: descCon.text,
                      todoType: i.toString(),
                      createdAt: DateTime.now().toString(),
                    ),
                  );
              Navigator.pop(context);
              break;
            }
          }
        },
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
