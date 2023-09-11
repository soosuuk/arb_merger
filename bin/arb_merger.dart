import 'dart:io';

import 'package:arb_merger/arb_merger.dart';

import 'utils/yaml_parser.dart';

void main() {
  final packageSettings = YamlParser.packageSettingsFromPubspec();
  if (packageSettings == null) {
    exit(0);
  }

  ARBMerger.convert(packageSettings);
  ARBMerger.merge(packageSettings);
}