import 'package:flutter/material.dart';
import 'package:notification_tutorial/ui/widgets/custom_alert_dialog.dart';
import 'package:notification_tutorial/ui/widgets/custom_app_bar.dart';
import 'package:notification_tutorial/ui/widgets/todo_item_view.dart';
import 'package:notification_tutorial/utils/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'TODOS',
      ),
      backgroundColor: MyColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: TodoItemView(
          dateTime: '24 may',
          subTitle: 'something something something something something',
          title: 'Something',
          iconData: Icons.sports_football,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(context: context, builder: (_) => showCustomAlerDialog(descCon: TextEditingController(), titleCon: TextEditingController()));
        },
        backgroundColor: MyColors.todoItemColor,
        child:const Icon(
          Icons.add,
          color: MyColors.textColor,
        ),
      ),
    );
  }
}
