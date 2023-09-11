import '../../configs/package_default_settings.dart';

class PackageSettings {
  final String inputFilepath;
  final String outputFilepath;

  final List<String> supportedLocales;

  /// Constructs a new instance of [PackageSettings]
  PackageSettings({
    required this.inputFilepath,
    required String? outputFilepath,
    required this.supportedLocales
  })  : outputFilepath =
      outputFilepath ?? PackageDefaultSettings.outputFilepath;

  /// Returns a String representation of the model.
  @override
  String toString() =>
      '{inputFilepath: $inputFilepath, outputFilepath: $outputFilepath, supportedLocales: $supportedLocales';
}