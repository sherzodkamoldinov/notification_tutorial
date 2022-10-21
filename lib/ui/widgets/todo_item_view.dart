import 'package:flutter/material.dart';
import 'package:notification_tutorial/utils/colors.dart';
import 'package:notification_tutorial/utils/style.dart';

class TodoItemView extends StatelessWidget {
  TodoItemView(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.dateTime, required this.iconData});

  final String title;
  final String subTitle;
  final String dateTime;
  final IconData iconData;

  bool checked = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.todoItemColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: MyColors.bluePurple),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.scale(
            scale: 1.5,
            child: StatefulBuilder(
              builder: (_, setState) => Checkbox(
                value: checked,
                onChanged: (value) {
                  setState(() {
                    checked = !checked;
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  title,
                  style: CustomTextStyle(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  subTitle,
                  style: CustomTextStyle().copyWith(fontSize: 14),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  dateTime,
                  style: CustomTextStyle().copyWith(fontSize: 13),
                ),
              ],
            ),
          ),
          const SizedBox(width: 3),
          SizedBox(
            height: double.infinity,
            width: 100,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              color: MyColors.bluePurple,
              child: Center(
                  child: Icon(
                iconData,
                size: 36,
                color: MyColors.white,
              )),
            ),
          )
        ],
      ),
    );
  }
}
