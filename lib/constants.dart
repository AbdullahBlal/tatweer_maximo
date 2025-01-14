/// Environment variables and shared app constants.
abstract class Constants {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://192.168.0.250/maxrest/',
  );

  static const String baseImageUrl = String.fromEnvironment(
    'BASE_IMAGE_URL',
    defaultValue: 'http://192.168.0.250/maxrest/oslc/images/',
  );

  static const String baseWrongImageUrl = String.fromEnvironment(
    'BASE_WRONG_IMAGE_URL',
    defaultValue: 'https://fm.tatweermisr.com:443',
  );

  static const String baseCorrectImageUrl = String.fromEnvironment(
    'BASE_CORRECT_IMAGE_URL',
    defaultValue: 'http://192.168.0.250',
  );

}