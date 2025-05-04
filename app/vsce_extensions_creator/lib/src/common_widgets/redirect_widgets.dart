import 'package:flutter/material.dart';

Future<void> redirectToStateless(BuildContext context, String routeName,
    {Object? arguments}) {
  return Navigator.popAndPushNamed(context, routeName, arguments: arguments);
}
