import 'package:animated_native_splash/animated_native_splash.dart'
    as animated_native_splash;
import 'package:animated_native_splash/supported_platform.dart'
    as animated_native_splash_supported_platform;

void main(List<String> arguments) {
  print(animated_native_splash_supported_platform.introMessage('1.2.1'));
  animated_native_splash.createSplash();
}
