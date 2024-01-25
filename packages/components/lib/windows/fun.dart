import 'dart:io';
import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void setSize({Size? size,Size? minimumSize}) async{
  if(kIsWeb||Platform.isAndroid||Platform.isIOS) return;
  await windowManager.ensureInitialized();
  WindowOptions windowOptions =  WindowOptions(
    size: size??const Size(1024, 1024*3/4),
    minimumSize:  size??const Size(600, 400),
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}