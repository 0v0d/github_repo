import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((Ref ref) => AppDio.getInstance(ref));

class AppDio {
  static Dio getInstance(Ref ref) => Dio(_createBaseOptions());

  static BaseOptions _createBaseOptions() {
    return BaseOptions(
      baseUrl: 'https://api.github.com/',
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      contentType: 'application/json',
    );
  }
}
