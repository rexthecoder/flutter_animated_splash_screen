part of animated_native_splash_supported_platform;

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

class _InvalidConfigException implements Exception {
  const _InvalidConfigException(this.message);
  final String message;

  @override
  String toString() {
    return '*** ERROR [animated_native_splash] ***\n'
        'InvalidConfigException\n'
        '$message';
  }
}

class _NoImageFileFoundException implements Exception {
  const _NoImageFileFoundException(this.message);
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

