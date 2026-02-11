import 'dart:convert';
import 'dart:io';

import 'package:wordpice/core/config/app_config.dart';

/// Мини-клиент для будущих HTTP-запросов.
///
/// Важно:
/// - сейчас backend отсутствует, поэтому этот файл НЕ используется
/// - мы НЕ придумываем эндпоинты и бизнес-логику
/// - заготовка нужна, чтобы позже подключить API без переписывания UI
class ApiClient {
  final HttpClient _httpClient;

  ApiClient({HttpClient? httpClient}) : _httpClient = httpClient ?? HttpClient();

  /// Заготовка GET-запроса.
  ///
  /// [path] — путь относительно baseUrl (например, "/profile").
  /// Пока метод нигде не вызывается.
  Future<Map<String, dynamic>> getJson(String path) async {
    if (AppConfig.baseUrl.isEmpty) {
      throw StateError(
        'AppConfig.baseUrl пустой. Backend ещё не подключён, вызов API невозможен.',
      );
    }

    final uri = Uri.parse('${AppConfig.baseUrl}$path');
    final request = await _httpClient.getUrl(uri);
    request.headers.contentType = ContentType.json;

    final response = await request.close();
    final body = await response.transform(utf8.decoder).join();

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw HttpException('HTTP ${response.statusCode}: $body', uri: uri);
    }

    final decoded = jsonDecode(body);
    if (decoded is Map<String, dynamic>) return decoded;

    throw FormatException('Ожидали JSON-объект (Map), но получили: ${decoded.runtimeType}');
  }
}
