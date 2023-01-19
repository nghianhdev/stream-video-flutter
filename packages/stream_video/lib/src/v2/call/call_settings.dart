class CallSettings {
  const CallSettings({
    this.cameraEnabled = false,
    this.microphoneEnabled = false,
    this.screenShareEnabled = false,
    this.dropTimeout = const Duration(seconds: 30),
  });

  final bool cameraEnabled;
  final bool microphoneEnabled;
  final bool screenShareEnabled;
  final Duration dropTimeout;

  @override
  String toString() {
    return 'CallOptions{cameraEnabled: $cameraEnabled, microphoneEnabled: '
        '$microphoneEnabled, screenShareEnabled: $screenShareEnabled, '
        'dropTimeout: $dropTimeout}';
  }
}
