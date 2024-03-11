List<String> soundTypeToFilename(SfxType type) {
  switch (type) {
    case SfxType.deploying:
      return const [
        'deploying.mp3',
      ];
    case SfxType.refolding:
      return const [
        'refolding.mp3',
      ];
  }
}

/// Allows control over loudness of different SFX types.
double soundTypeToVolume(SfxType type) {
  switch (type) {
    case SfxType.deploying:
      return 0.5;
    case SfxType.refolding:
      return 0.5;
  }
}

enum SfxType {
  deploying,
  refolding,
}
