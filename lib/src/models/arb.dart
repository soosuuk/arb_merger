import 'dart:collection';
import 'dart:convert';
import 'dart:io';

/// Model class for ARB file.
class Arb {
  final DateTime lastModified;
  final String? locale;
  final String? context;
  final String? author;
  final Set<ArbItem> items;

  Arb({
    DateTime? lastModified,
    this.locale,
    this.context,
    this.author,
    this.items = const {},
  }) : lastModified = lastModified ?? DateTime.now();

  factory Arb.fromArb(Map<String, dynamic> arb) {
    final bundleItems = Map.fromEntries(
      arb.entries.where(
            (entry) => !entry.key.startsWith('@@'),
      ),
    );

    final _arb = Arb(
      author: arb['@@author'],
      context: arb['@@context'],
      lastModified: arb['@@last_modified'] == null
          ? DateTime.now()
          : DateTime.parse(arb['@@last_modified']),
      locale: arb['@@locale'],
      items: {},
    );

    for (final item in bundleItems.entries) {
      if (item.key.startsWith('@')) continue;

      final name = item.key;
      final value = item.value;
      final options = bundleItems['@$name'] ?? <String, dynamic>{};

      _arb.items.add(ArbItem(
        name: name,
        value: value,
        description: options['description'],
        placeholders: options['placeholders'],
        type: options['type'],
      ));
    }

    return _arb;
  }

  factory Arb.fromFile(File file) =>
      Arb.fromArb(json.decode(file.readAsStringSync()));

  /// Get ARB format Object.
  SplayTreeMap<String, dynamic> get arb {
    final SplayTreeMap<String, dynamic> _arb =
    SplayTreeMap<String, dynamic>();
    // _arb['@@last_modified'] = lastModified.toString();

    if (locale != null) {
      _arb['@@locale'] = locale;
    }
    if (context != null) {
      _arb['@@context'] = context;
    }
    if (author != null) {
      _arb['@@author'] = author;
    }

    for (final item in items) {
      _arb.addAll(item.arb);
    }

    return _arb;
  }

  /// Makes new [Bundle] which merged this with [other].
  /// Last modified time will update as now.
  /// Items that not in this but other are append.
  /// Rest of all are same as this.
  Arb merge(Arb other) {
    final keys = items.map((item) => item.name).toSet();
    final otherKeys = other.items.map((item) => item.name).toSet();
    final newKeys = otherKeys.difference(keys);
    final newItems =
    other.items.where((item) => newKeys.contains(item.name)).toSet();

    return Arb(
      lastModified: DateTime.now(),
      author: author,
      context: context,
      locale: locale,
      items: items.union(newItems),
    );
  }
}

/// Model class for item in ARB file.
class ArbItem {
  final String name;
  final String value;
  final ArbItemOptions options;

  ArbItem({
    required this.name,
    required this.value,
    String? type,
    String? description,
    Map<String, dynamic>? placeholders,
  }) : options = ArbItemOptions(
    type: type,
    description: description,
    placeholders: placeholders,
  );

  /// Get ARB format Object.
  SplayTreeMap<String, dynamic> get arb {
    final SplayTreeMap<String, dynamic> _options =
    SplayTreeMap<String, dynamic>();
    _options[name] = value;

    if (options.arb != null) {
      _options['@$name'] = options.arb;
    }

    return _options;
  }
}

/// Model class for options in ARB item.
class ArbItemOptions {
  final String? type;
  final String? description;
  final Map<String, dynamic>? placeholders;

  ArbItemOptions({
    this.type,
    this.description,
    this.placeholders,
  });

  /// Get ARB format Object.
  SplayTreeMap<String, dynamic>? get arb {
    final SplayTreeMap<String, dynamic> _options =
    SplayTreeMap<String, dynamic>();
    if (type != null) {
      _options['type'] = type;
    }

    if (description != null) {
      _options['desc'] = description;
    }

    if (placeholders != null) {
      _options['placeholders'] = placeholders;
    }

    return _options.length > 0 ? _options : null;
  }
}