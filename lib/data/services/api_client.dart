import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:finance_control/data/exceptions/api_exceptions.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final String baseUrl;
  final http.Client _client;
  final Duration timeout;

  ApiClient({
    required this.baseUrl,
    http.Client? client,
    Duration? timeout,
  })  : _client = client ?? http.Client(),
        timeout = timeout ?? const Duration(seconds: 15);

  Future<dynamic> get(
    String endpoint, {
    Map<String, String>? headers,
    Map<String, String>? queryParameters,
  }) async {
    final uri = _buildUri(endpoint, queryParameters);
    try {
      final response = await _client
          .get(uri, headers: _mergeHeaders(headers))
          .timeout(timeout);
      return _decodeResponse(response);
    } on TimeoutException {
      throw const NetworkException('Tempo de requisicao esgotado');
    } on SocketException {
      throw const NetworkException('Sem conexao com a internet');
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    }
  }

  Future<dynamic> post(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint, null);
    try {
      final response = await _client
          .post(
            uri,
            headers: _mergeHeaders(headers),
            body: jsonEncode(body),
          )
          .timeout(timeout);
      return _decodeResponse(response);
    } on TimeoutException {
      throw const NetworkException('Tempo de requisicao esgotado');
    } on SocketException {
      throw const NetworkException('Sem conexao com a internet');
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    }
  }

  Future<dynamic> put(
    String endpoint,
    Map<String, dynamic> body, {
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint, null);
    try {
      final response = await _client
          .put(
            uri,
            headers: _mergeHeaders(headers),
            body: jsonEncode(body),
          )
          .timeout(timeout);
      return _decodeResponse(response);
    } on TimeoutException {
      throw const NetworkException('Tempo de requisicao esgotado');
    } on SocketException {
      throw const NetworkException('Sem conexao com a internet');
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    }
  }

  Future<dynamic> delete(
    String endpoint, {
    Map<String, String>? headers,
  }) async {
    final uri = _buildUri(endpoint, null);
    try {
      final response = await _client
          .delete(uri, headers: _mergeHeaders(headers))
          .timeout(timeout);
      return _decodeResponse(response);
    } on TimeoutException {
      throw const NetworkException('Tempo de requisicao esgotado');
    } on SocketException {
      throw const NetworkException('Sem conexao com a internet');
    } on http.ClientException catch (e) {
      throw NetworkException(e.message);
    }
  }

  Uri _buildUri(String endpoint, Map<String, String>? queryParameters) {
    final base = Uri.parse(baseUrl);
    final resolved = base.resolve(endpoint);
    if (queryParameters == null || queryParameters.isEmpty) {
      return resolved;
    }
    return resolved.replace(queryParameters: queryParameters);
  }

  Map<String, String> _mergeHeaders(Map<String, String>? headers) {
    return {
      'Content-Type': 'application/json',
      if (headers != null) ...headers,
    };
  }

  dynamic _decodeResponse(http.Response response) {
    final body = response.body.trim();
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (body.isEmpty) return null;
      return jsonDecode(body);
    }

    final decoded = body.isEmpty ? null : _tryDecode(body);
    final statusCode = response.statusCode;
    if (statusCode == 401 || statusCode == 403) {
      throw UnauthorizedException(statusCode: statusCode, body: decoded);
    }
    if (statusCode == 404) {
      throw NotFoundException(statusCode: statusCode, body: decoded);
    }
    throw ApiException(
      message: 'Request failed',
      statusCode: statusCode,
      body: decoded,
    );
  }

  dynamic _tryDecode(String body) {
    try {
      return jsonDecode(body);
    } catch (_) {
      return body;
    }
  }
}

