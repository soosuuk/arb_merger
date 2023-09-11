import '../configs/package_default_settings.dart';

class PackageSettings {
  final String inputFilepath;
  final String outputDirectory;

  PackageSettings({
    required this.inputFilepath,
    required String? outputDirectory,
  })  : outputDirectory =
      outputDirectory ?? PackageDefaultSettings.outputDirectory;

  @override
  String toString() =>
      '{inputFilepath: $inputFilepath, outputDirectory: $outputDirectory';
}