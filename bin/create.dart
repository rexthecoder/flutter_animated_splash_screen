import 'package:args/args.dart';
import 'package:animated_native_splash/animated_native_splash.dart'
    as animated_native_splash;
import 'package:animated_native_splash/supported_platform.dart'
    as animated_native_splash_supported_platform;

void main(List<String> arguments) {
  final parser = ArgParser();

  parser.addOption('path');
  final parsedArgs = parser.parse(arguments);

  print(animated_native_splash_supported_platform.introMessage('1.3.0'));
  animated_native_splash.createSplash(
    path: parsedArgs['path']?.toString(),
  );
}
