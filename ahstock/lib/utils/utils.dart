import 'dart:io';

import 'package:ahstock/theme/styles.dart';
import 'package:flutter/material.dart';



showSnackBar({required BuildContext context, required SnackBar snackBar}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

SnackBar showErrorDialogue1(
    {required String errorMessage,
    Duration duration = const Duration(milliseconds: 2000)}) {
  if (errorMessage.isNotEmpty) {
    return SnackBar(
      backgroundColor: customColors().danger,
      duration: duration,
      content: Text(
        errorMessage,
        style: customTextStyle(
            fontStyle: FontStyle.BodyM_SemiBold, color: FontColor.White),
      ),
    );
  } else {
    return SnackBar(
        backgroundColor: customColors().backgroundPrimary,
        content: const LinearProgressIndicator(
          minHeight: 6.0,
          color: Color.fromRGBO(183, 214, 53, 1),
          backgroundColor: Color.fromRGBO(183, 214, 53, 0.5),
        ));
  }
}

SnackBar showSuccessDialogue(
    {required String message,
    Duration duration = const Duration(milliseconds: 2000)}) {
  return SnackBar(
    backgroundColor: customColors().success,
    duration: duration,
    content: Text(
      message,
      style: customTextStyle(
          fontStyle: FontStyle.BodyM_SemiBold, color: FontColor.White),
    ),
  );
}



bool get applyTheme {
  if (Platform.isAndroid) {
    try {
      String versionString = Platform.operatingSystemVersion.split(" ")[1];
      int version = int.parse(versionString);
      if (version < 10) {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
  return true;
}
