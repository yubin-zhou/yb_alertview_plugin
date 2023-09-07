
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class YbAlertviewPlugin {
  static const MethodChannel _channel =
      const MethodChannel('yb_alertview_plugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static showNativeAlertView(String msg){
    if(msg.isNotEmpty){
      _channel.invokeMethod("show_native_alertView",msg);
    }

  }
}
