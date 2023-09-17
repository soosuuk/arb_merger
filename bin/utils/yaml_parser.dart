import 'dart:io';

import 'package:arb_merger/arb_merger.dart'
    show PackageSettings;
import 'package:yaml/yaml.dart';

/// A class of arguments which the user can specify in pubspec.yaml
class YamlArguments {
  static const inputFilepath = 'input_filepath';
  static const outputFilepath = 'input_filepath';
  static const supportedLocales = 'supported_locales';
}

/// A class which parses yaml
class YamlParser {
  /// The path to the pubspec file path
  static const pubspecFilePath = 'pubspec.yaml';

  /// The section id for package settings in the yaml file
  static const yamlPackageSectionId = 'arb_merger';

  /// Returns the package settings from pubspec
  static PackageSettings? packageSettingsFromPubspec() {
    final yamlMap = _packageSettingsAsYamlMap();
    if (yamlMap != null) {
      final inputFilepath = yamlMap[YamlArguments.inputFilepath];
      if (inputFilepath == null) {
        print('Error! Input filepath not defined!');
        exit(0);
      }

      final outputFilepath = yamlMap[YamlArguments.outputFilepath];
      if (outputFilepath == null) {
        print('Error! Output filepath not defined!');
        exit(0);
      }

      final supportedLocales = yamlMap[YamlArguments.supportedLocales];

      return PackageSettings(
        supportedLocales: supportedLocales.toList().cast<String>(),
        inputFilepath: inputFilepath,
        outputFilepath: outputFilepath,
      );
    }

    return null;
  }

  /// Returns the package settings from pubspec as a yaml map
  static Map<dynamic, dynamic>? _packageSettingsAsYamlMap() {
    final file = File(pubspecFilePath);
    final yamlString = file.readAsStringSync();
    final Map<dynamic, dynamic> yamlMap = loadYaml(yamlString);
    return yamlMap[yamlPackageSectionId];
  }
}