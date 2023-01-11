import 'dart:developer';

import 'package:flutter/foundation.dart';

kEcho(String text) {
  if (kDebugMode) log('✅ $text');
}

kEcho100(String text) {
  if (kDebugMode) log('💯 $text');
}

kEchoError(dynamic text) {
  if (kDebugMode) log('❌ $text');
}

kEchoSearch(String text) {
  if (kDebugMode) log('🔎 $text');
}
