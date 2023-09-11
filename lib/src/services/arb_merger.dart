import 'dart:convert';
import 'dart:io';
import '../models/arb.dart';
import '../models/settings/package_settings.dart';

/// A service which merge arb files
abstract class ARBMerger {

  /// Convert arb files.
  static void convert(
      PackageSettings packageSettings,
      ) {
    final _arbFiles = <File>{};

    for (String locale in packageSettings.supportedLocales) {
      final _directory = Directory(packageSettings.inputFilepath + '/' + locale);

      if (_directory.path.contains('.arb')) {
        if (!File(_directory.path).existsSync()) {
          print('Cannot find arb file specified which [${_directory.path}].');
          print(
              'Usage: merge_arbs [merged arb file path] [merge target arb file paths]');
          exit(0);
        }
      } else if (!_directory.existsSync()) {
        print('Cannot find path specified which [${_directory.path}].');
        print(
            'Usage: merge_arbs [merged arb file path] [merge target arb file paths]');
        exit(0);
      }

      if (_directory.path.contains('.arb')) {
        _arbFiles.add(File(_directory.path));
      } else {
        _arbFiles.addAll(
          _directory
              .listSync()
              .where((directory) => directory.path.contains('.arb'))
              .map((directory) => File(directory.path)),
        );
      }
    }

    for (final arbFile in _arbFiles) {
      arbFile.writeAsStringSync(JsonEncoder.withIndent("  ").convert(Arb.fromFile(arbFile).arb));
    }
  }

  /// Merge arb files.
  static void merge(
      PackageSettings packageSettings,
      ) {
    final _arbFiles = <File>{};

    for (String locale in packageSettings.supportedLocales) {
      final mergedArbFile = File(packageSettings.outputFilepath + '/' + locale + '.arb');
      final _directory = Directory(packageSettings.inputFilepath + '/' + locale);

      if (!mergedArbFile.path.contains('.arb')) {
        print(
            'Just one source arb file must specified. The [${mergedArbFile.path}] is not a arb file.');
        print(
            'Usage: merge_arbs [merged arb file path] [merge target arb file paths]');
        exit(0);
      }

      if (!mergedArbFile.existsSync()) {
        print('Cannot find path specified which [${mergedArbFile.path}].');
        print(
            'Usage: merge_arbs [merged arb file path] [merge target arb file paths]');
        exit(0);
      }

      if (_directory.path.contains('.arb')) {
        if (!File(_directory.path).existsSync()) {
          print('Cannot find arb file specified which [${_directory.path}].');
          print(
              'Usage: merge_arbs [merged arb file path] [merge target arb file paths]');
          exit(0);
        }
      } else if (!_directory.existsSync()) {
        print('Cannot find path specified which [${_directory.path}].');
        print(
            'Usage: merge_arbs [merged arb file path] [merge target arb file paths]');
        exit(0);
      }

      if (_directory.path.contains('.arb')) {
        _arbFiles.add(File(_directory.path));
      } else {
        _arbFiles.addAll(
          _directory
              .listSync()
              .where((directory) => directory.path.contains('.arb'))
              .map((directory) => File(directory.path)),
        );
      }
      _arbFiles.removeWhere((arbFile) => arbFile.uri == mergedArbFile.uri);

      Arb _mergedBundle = Arb();
      for (final arbFile in _arbFiles) {
        final bundle = Arb.fromFile(arbFile);
        _mergedBundle = bundle.merge(_mergedBundle);
      }

      var encoder = new JsonEncoder.withIndent("  ");
      String _convertedJson = encoder.convert(_mergedBundle.arb);
      mergedArbFile.writeAsStringSync(_convertedJson);
    }
    }
}