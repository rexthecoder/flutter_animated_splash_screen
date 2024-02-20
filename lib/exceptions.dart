part of 'supported_platform.dart';

///Expection need to through to our users, For better users experinces
class _NoConfigFoundException implements Exception {
  const _NoConfigFoundException(this.message);
  final String message;

  @override
  String toString() {
    return '*** ERROR [animated_native_splash] ***\n'
        'NoConfigFoundException\n'
        '$message';
  }
}

//TODO: Expection for our ios version:: Coming up
// class _InvalidConfigException implements Exception {
//   const _InvalidConfigException(this.message);
//   final String message;

//   @override
//   String toString() {
//     return '*** ERROR [animated_native_splash] ***\n'
//         'InvalidConfigException\n'
//         '$message';
//   }
// }

class _NoJsonFileFoundException implements Exception {
  const _NoJsonFileFoundException(this.message);
  final String message;

  @override
  String toString() {
    return '*** ERROR [animated_native_splash] ***\n'
        'NoImageFileFoundException\n'
        '$message';
  }
}

class _InvalidNativeFile implements Exception {
  const _InvalidNativeFile(this.message);
  final String message;

  @override
  String toString() {
    return '*** ERROR [animated_native_splash] ***\n'
        'InvalidNativeFile\n'
        '$message';
  }
}
