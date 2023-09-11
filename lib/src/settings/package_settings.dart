import '../configs/package_default_settings.dart';

class PackageSettings {
  final String inputFilepath;
  final String outputFilepath;

  PackageSettings({
    required this.inputFilepath,
    required String? outputFilepath,
  })  : outputFilepath =
      outputFilepath ?? PackageDefaultSettings.outputFilepath;

  @override
  String toString() =>
      '{inputFilepath: $inputFilepath, outputFilepath: $outputFilepath';
}