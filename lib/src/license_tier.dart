enum LicenseTier {
  free,
  basic,
  premium;

  String get storageValue => switch (this) {
        LicenseTier.free => 'free',
        LicenseTier.basic => 'basic',
        LicenseTier.premium => 'premium',
      };

  String get displayName => switch (this) {
        LicenseTier.free => '免费版',
        LicenseTier.basic => '基础版',
        LicenseTier.premium => '高级版',
      };

  static LicenseTier fromStorageValue(String? value) {
    return switch (value) {
      'basic' => LicenseTier.basic,
      'premium' => LicenseTier.premium,
      _ => LicenseTier.free,
    };
  }
}
