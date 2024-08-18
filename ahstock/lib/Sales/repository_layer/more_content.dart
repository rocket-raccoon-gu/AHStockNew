
import 'package:ahstock/Sales/widgets/others/restart_widget.dart';
import 'package:ahstock/user_controller/user_controller.dart';
import 'package:flutter/widgets.dart';

logout(BuildContext context) async {
  RestartWidget.restartApp(context);

  UserController().dispose();
}
