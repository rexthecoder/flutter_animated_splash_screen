/// ## If the current platform is supported, load dart.io.
///
/// Creating images necessary for the splash screens requires the io.dart package, which
/// unfortunately does not have support for JS.  Because pub.dev docks pub points for
/// packages not being cross-platform, it is necessary to use
/// [conditional imports](https://dart.dev/guides/libraries/create-library-packages#conditionally-importing-and-exporting-library-files)
/// to avoid losing pub points.  This library is included when the package is loaded on
/// a supported platform, loads dart.io and the rest of the package.
// ignore_for_file: avoid_print

library animated_native_splash_supported_platform;

import 'dart:io';

import 'package:yaml/yaml.dart';
// Image template
import 'package:universal_io/io.dart';

part 'android.dart';
part 'constants.dart';
part 'exceptions.dart';
part 'templates.dart';
part 'web.dart';

/// Function that will be called on supported platforms to create the splash screens.
Future<void> tryCreateSplash({
  required String? path,
}) async {
  var config = _getConfig(path: path);
  await tryCreateSplashByConfig(config);
}

/// Function that will be called on supported platforms to remove the splash screens.
Future<void> tryRemoveSplash() async {
  print('Restoring animated\'s default white native splash screen...');
  await tryCreateSplashByConfig({'color': '#ffffff'});
}

/// Function that will be called on supported platforms to create the splash screen based on a config argument.
Future<void> tryCreateSplashByConfig(Map<String, dynamic> config) async {
  String jsonFile = config['jsonFile'] ?? '';

  if (config['android']?["enabled"] ?? true) {
    await _createAndroidSplash(
      jsonPath: jsonFile,
    );
  }
  if (config['web']?["enabled"] ?? true) {
    await _createWebSplash(
      config: config,
      path: jsonFile,
    );
  }
  if (!(config['android']?["enabled"] ?? true) &&
      !(config['web']?["enabled"] ?? true)) {
    stderr.writeln('You have disabled both platforms. Nothing was generated!');
  }
}

/// Get config from `pubspec.yaml` or `animated_native_splash.yaml`
Map<String, dynamic> _getConfig({
  required String? path,
}) {
  String filePath;

  // if config file was provided via --path argument, check if the file exists
  if (path != null) {
    if (File(path).existsSync()) {
      filePath = path;
    } else {
      print('The config file `$path` was not found.');
      exit(1);
    }
  } else {
    // if `animated_native_splash.yaml` exists use it as config file, otherwise use `pubspec.yaml`
    filePath = (FileSystemEntity.typeSync('animated_native_splash.yaml') !=
            FileSystemEntityType.notFound)
        ? 'animated_native_splash.yaml'
        : 'pubspec.yaml';
  }

  final file = File(filePath);
  final yamlString = file.readAsStringSync();
  final Map yamlMap = loadYaml(yamlString);

  if (yamlMap['animated_native_splash'] is! Map) {
    stderr.writeln(_NoConfigFoundException(
        'Your `$filePath` file does not contain a `animated_native_splash` section.'));
    exit(1);
  }

  // yamlMap has the type YamlMap, which has several unwanted side effects
  final config = <String, dynamic>{};
  for (MapEntry<dynamic, dynamic> entry
      in yamlMap['animated_native_splash'].entries) {
    if (entry.value is YamlList) {
      var list = <String>[];
      for (var value in (entry.value as YamlList)) {
        if (value is String) {
          list.add(value);
        }
      }
      config[entry.key] = list;
    } else {
      config[entry.key] = entry.value;
    }
  }

  return config;
}
