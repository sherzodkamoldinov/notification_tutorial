import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:notification_tutorial/cloud_notification_page.dart';
import 'package:notification_tutorial/ui/widgets/custom_app_bar.dart';
import 'package:notification_tutorial/utils/colors.dart';
import 'package:notification_tutorial/utils/consts.dart';
import 'package:notification_tutorial/utils/icons.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3))
        .then((value) => Navigator.pushReplacementNamed(context, mainPage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        backgroundColor: MyColors.bluePurple,
      ),
      backgroundColor: MyColors.bluePurple,
      body: Center(
        child: Image.asset(MyIcons.splash),
      ),
    );
  }
}
