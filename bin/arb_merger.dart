import 'dart:io';

import 'package:arb_merger/arb_merger.dart';

import 'utils/yaml_parser.dart';

void main() {
  final packageSettings = YamlParser.packageSettingsFromPubspec();
  if (packageSettings == null) {
    print('Error! Settings for arb_generator not found in pubspec.');
    exit(0);
  }

  ARBMerger.convert(packageSettings);
  ARBMerger.merge(packageSettings);
}