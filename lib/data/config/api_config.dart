class ApiConfig {
  static const String baseUrl = String.fromEnvironment(
    'FINANCE_API_BASE_URL',
    defaultValue: 'https://jsonplaceholder.typicode.com',
  );
}