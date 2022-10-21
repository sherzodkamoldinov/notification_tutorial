import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:notification_tutorial/utils/colors.dart';
import 'package:notification_tutorial/utils/style.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  const CustomAppBar(
      {super.key,
      this.title,
      this.backgroundColor});

  final String? title;

  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title ?? "",
        style: CustomTextStyle()
            .copyWith(color: MyColors.bluePurple, fontSize: 24),
      ),
      centerTitle: true,
      backgroundColor: backgroundColor ?? MyColors.backgroundColor,
      elevation: 0.0,
      systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: backgroundColor ?? MyColors.backgroundColor,
          statusBarIconBrightness: Brightness.dark),
      
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size(double.infinity, 56);
}
