import 'dart:async';

import 'package:ahstock/Sales/presentation_layer/bloc_navigation/navigation_cubit.dart';
import 'package:ahstock/app_routes_factory.dart';
import 'package:ahstock/app_theme.dart';
import 'package:ahstock/constants/prefefence_utils.dart';
import 'package:ahstock/global_methods/global_colors.dart';
import 'package:ahstock/main.dart';
import 'package:ahstock/navigation/navigation.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:ahstock/theme/custom_theme.dart';
import 'package:ahstock/user_controller/user_controller.dart';
import 'package:ahstock/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class AHSales extends StatefulWidget {
  final String initialRoute;
  ServiceLocator serviceLocator;
  AHSales(
      {super.key, required this.initialRoute, required this.serviceLocator});

  @override
  State<AHSales> createState() => _AHSalesState();
}

class _AHSalesState extends State<AHSales> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  late StreamSubscription<void> heartbeatSubscription;
  late StreamSubscription<void> logoutSubscription;
  late StreamSubscription<dynamic> streamingSubscription;
  CustomMode themeMode = CustomMode.Light;

  StreamSubscription? networkSubscription;

  @override
  void initState() {
    if (applyTheme) SystemChrome.setSystemUIOverlayStyle(lightTheme);

    // getUserCredentials();
    // TODO: implement initState
    super.initState();
    // NetworkStatusService();

    // requestpermission();
    // initializeFirebasenotification();

    // initfirebasenavigation(context);
  }

  getTheme() async {
    bool? storedThemeStatus = await PreferenceUtils.preferenceHasKey("theme");

    if (storedThemeStatus == false) {
      await PreferenceUtils.storeDataToShared(
          "theme", getThemeModeString(CustomMode.Light).toString());
    } else {
      String? storedTheme = await PreferenceUtils.getDataFromShared("theme");
      if (storedTheme == "") {
        await PreferenceUtils.storeDataToShared(
            "theme", getThemeModeString(CustomMode.Light).toString());
      }
    }
    String? storedTheme = await PreferenceUtils.getDataFromShared("theme");
    UserController().currentTheme = storedTheme ?? "";

    themeMode = getThemeMode(storedTheme!);
    if (applyTheme) {
      switch (themeMode) {
        case CustomMode.Light:
          {
            SystemChrome.setSystemUIOverlayStyle(lightTheme);
            break;
          }
        case CustomMode.Mid:
          {
            SystemChrome.setSystemUIOverlayStyle(midTheme);
            break;
          }
        case CustomMode.Dark:
          {
            SystemChrome.setSystemUIOverlayStyle(darkTheme);
            break;
          }
      }
    }
    await Provider.of<CustomTheme>(context, listen: false)
        .toggleTheme(themeMode);
  }

  @override
  Widget build(BuildContext context) {
    widget.serviceLocator = ServiceLocator(
        UserController.userController.mainbaseUrl,
        UserController.userController.mainapplicationPath,
        debuggable: loggable)
      ..config();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: HexColor('#F9FBFF'), // Change this to the desired color
    ));

    return MultiRepositoryProvider(
        providers: [RepositoryProvider.value(value: widget.serviceLocator)],
        child: AppTheme(
            child: BlocProvider(
          create: (context) => NavigationCubit(),
          child: MaterialApp(
            navigatorKey: _navigatorKey,
            initialRoute: widget.initialRoute,
            onGenerateRoute: onGenerateAppRoute(
              AppRoutesFactory(widget.serviceLocator),
            ),
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            debugShowCheckedModeBanner: false,
            // supportedLocales: AppLocalizations.supportedLocales,
            //locale: const Locale('ar', 'AE'),
            // themeMode: CustomTheme.modelTheme == CustomMode.Light
            //     ? ThemeMode.light
            //     : ThemeMode.dark,
            // themeMode: ThemeMode.light,
            theme: Provider.of<CustomTheme>(context).currentTheme,
          ),
        )));
  }
}
