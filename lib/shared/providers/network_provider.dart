import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_client.dart';
import 'storage_provider.dart';

final dioProvider = Provider<Dio>(
  (ref) => DioClient(secureStorage: ref.watch(secureStorageProvider)).dio,
);
