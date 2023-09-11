# arb_merger

The package that merge some ARB files every locale into single ARB file.

## Getting Started

###  Create a directories for each supported locales   
supports locales is following [Locale.languageCodes](https://api.flutter.dev/flutter/dart-ui/Locale/languageCode.html).  
For example:

```
.
├──assets
│  └── l10n
│      ├── en
│      ├── ja
```

### Create ARB files. 
You can create ARB files as you need (min:1, max:none).  
For example:

```
.
├──assets
│  └── l10n
│      ├── en
│      │   ├── noun.arb
│      │   └── verb.arb
│      ├── ja
│      │   ├── noun.arb
│      │   └── verb.arb
```

./assets/l10n/en/noun.arb:
```yaml   
{
  "@@locale": "en",
  "shop": "shop",
}
```
./assets/l10n/ja/noun.arb:
```yaml   
{
  "@@locale": "ja",
  "shop": "ショップ",
}
```
./assets/l10n/en/verb.arb:
```yaml   
{
  "@@locale": "en",
  "open": "open",
}
```
./assets/l10n/ja/verb.arb:
```yaml   
{
  "@@locale": "ja",
  "open": "開く",
}
```

### Add Package

Add the package as "dev_dependencies".

```yaml   
dev_dependencies: 
  arb_merger:
```

### Define Settings

Define "arb_merger" package settings in `pubspec.yaml`.

```yaml
flutter:
.
.
,
arb_merger:
  supported_locales: ["ja", "en"]
  input_filepath: "assets/l10n"
  output_filepath: "assets/l10n"
```
|Name|Type|Required|Description|
|-|-|-|-|
|supported_locales|List|Required|Supported locale.|
|input_filepath|String|Required|input filepath.|
|output_filepath|String| |ARB files are generated in this.|

### Run package

Ensure that your current working directory is the project root. Depending on your project, run one of the following commands:

<span style="color: yellow; ">⚠️When you run this command, all arb files will be automatically sorted in ascending order by key name.</span>

```sh
dart run arb_merger
```

or

```sh
flutter pub run arb_merger
```

ARB files are then generated in `output_filepath`.
The merged ARB file will be generated as "supported locale.arb".  
For example:
   
./assets/l10n/en.arb:
```yaml   
{
  "@@locale": "en",
  "open": "open",
  "shop": "shop",
}
```
./assets/l10n/ja.arb:
```yaml   
{
  "@@locale": "ja",
  "open": "開く",
  "shop": "ショップ",
}
```