import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notification_tutorial/cubit/cubit/notification_cubit.dart';
import 'package:notification_tutorial/ui/widgets/custom_alert_dialog.dart';
import 'package:notification_tutorial/ui/widgets/custom_app_bar.dart';
import 'package:notification_tutorial/ui/widgets/todo_item_view.dart';
import 'package:notification_tutorial/utils/colors.dart';
import 'package:formz/formz.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async {
    await BlocProvider.of<NotificationCubit>(context).getAllTodos();
  }

  @override
  Widget build(BuildContext context) {
    List<String> todoTypesList = ['Sport', 'HomeWork', 'Hobbie', 'La La La'];
    String currentType = todoTypesList[0];
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'TODOS',
      ),
      backgroundColor: MyColors.backgroundColor,
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state.status.isSubmissionInProgress) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ListView.builder(
                  itemCount: state.todos.length,
                  itemBuilder: (context, index) {
                    var todo = state.todos[index];
                    return TodoItemView(
                      dateTime: todo.createdAt,
                      subTitle: todo.desc,
                      title: todo.title,
                      iconData: todo.todoType,
                    );
                  }),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => showCustomAlerDialog(
              context: context,
              descCon: TextEditingController(),
              titleCon: TextEditingController(),
              currentType: currentType,
              // onChanged: (newTypeValue) {
              //   currentType = newTypeValue;
              //   print(currentType);
              //   setState(() {});
              // },
              todoTypes: todoTypesList,
            ),
          );
        },
        backgroundColor: MyColors.todoItemColor,
        child: const Icon(
          Icons.add,
          color: MyColors.textColor,
        ),
      ),
    );
  }
}
