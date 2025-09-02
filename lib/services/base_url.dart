// lib/config/base_url.dart
import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// 允許用 --dart-define 覆蓋（最高優先）
const String _ENV_BASE_URL = String.fromEnvironment('API_BASE_URL', defaultValue: '');

/// 專案啟動時呼叫一次，載入 .env.client 並決定 BASE_URL
late final String BASE_URL;

Future<void> initBaseUrl() async {
  // 嘗試載入 .env.client（Web/行動端皆可；不存在也不會壞）
  try {
    await dotenv.load(fileName: ".env.client");
  } catch (_) { /* 忽略 */ }

  BASE_URL = _computeBaseUrl();
}

String _computeBaseUrl() {
  // 1) 最優先：--dart-define=API_BASE_URL=...
  if (_ENV_BASE_URL.isNotEmpty) return _ENV_BASE_URL;

  // 2) 次優先：.env.client 的 HOST/PORT/SCHEME（只要有 HOST 就組 URL）
  final host = dotenv.maybeGet('HOST');            // 例：100.64.12.34
  final port = dotenv.maybeGet('PORT') ?? '3000';  // 預設 3000
  final scheme = dotenv.maybeGet('SCHEME') ?? 'http';

  if (host != null && host.isNotEmpty) {
    return '$scheme://$host:$port';
  }

  // 3) 沒有 HOST → 預設 localhost（依平台）
  if (kIsWeb) {
    // Flutter Web 本機開發
    return 'http://localhost:3000';
  }
  switch (defaultTargetPlatform) {
    case TargetPlatform.android:
    // Android 模擬器連宿主機
      return 'http://10.0.2.2:3000';
    case TargetPlatform.iOS:
    case TargetPlatform.macOS:
    case TargetPlatform.windows:
    case TargetPlatform.linux:
    case TargetPlatform.fuchsia:
      return 'http://localhost:3000';
  }
}
