part of 'supported_platform.dart';

Future<void> _createWebSplash({
  required Map<String, dynamic> config,
  String? path,
}) async {
  if (path!.isNotEmpty) {
    await _deleteWebFile();
    await _createStylesheet(
      config,
    );
    await _saveWebJsonFile(path);
    await _createIndex(
      config,
      path,
    );
  }
}

/// Deleting the web file
///
/// This allow us to replace the web file with a modified version,
/// Thus, a version with lottie added or integrated
Future<void> _deleteWebFile() async {
  final webFile = File(_webIndex);
  print('[Web] Deleting the web index file');
  await webFile.writeAsString('');
}

/// Create stylesheet
///
/// This positions the element and allow us to visible hide
/// whenever necessary
Future<void> _createStylesheet(
  Map<String, dynamic> config,
) async {
  final stylesheet = File(_webRelativeStyleFile);
  stylesheet.createSync(recursive: true);
  print('[Web] Creating the style file.');
  stylesheet.writeAsStringSync(styleTemplate(
    fadeOutDuration: config["web"]?["fadeOutDuration"] ?? 3,
    backgroundColor: config["web"]?["backgroundColor"] ?? "#ffffff",
  ));
}

/// Create index file
///
/// Replace the old index with the new template
/// This contains the lottie player already set up
Future<void> _createIndex(
  Map<String, dynamic> config,
  path,
) async {
  var jsonfile = File(path).readAsBytesSync();
  if (jsonfile.isEmpty) {
    throw const _NoJsonFileFoundException('No Json file has been added');
  }
  final index = File(_webIndex);
  index.createSync(recursive: true);
  print('[Web] Creating the Index file.');
  index.writeAsStringSync(
    indexTemplate(
      projectName: _projectName,
      webLoop: config["web"]?["loop"] ?? true,
      webFadeOut: config["web"]?["fadeOut"] ?? true,
    ),
  );
}

/// Save the json file inside the raw directory
///
/// This helps us port our json file to the android folder
/// Veyr useful since we want to a way to link our json file directory to the project
Future _saveWebJsonFile(path) async {
  var jsonfile = File(path).readAsBytesSync();
  if (jsonfile.isEmpty) {
    throw const _NoJsonFileFoundException('No Json file has been added');
  } else {
    print('[Web] Saving the json file insde the splash directory');
    await File(_splashFile).create(recursive: true).then((File file) {
      file.writeAsBytesSync(jsonfile);
    });
  }
}
