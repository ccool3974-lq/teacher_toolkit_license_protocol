import 'license_tier.dart';

class LicensePayload {
  const LicensePayload({
    required this.product,
    required this.licenseId,
    required this.tier,
    required this.bindName,
    required this.durationDays,
    required this.permanent,
    required this.issuedAt,
    this.activationDeadline,
    required this.features,
    required this.nonce,
  });

  final String product;
  final String licenseId;
  final LicenseTier tier;
  final String bindName;
  final int durationDays;
  final bool permanent;
  final DateTime issuedAt;
  final DateTime? activationDeadline;
  final List<String> features;
  final String nonce;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'product': product,
      'licenseId': licenseId,
      'tier': tier.storageValue,
      'bindName': bindName,
      'durationDays': durationDays,
      'permanent': permanent,
      'issuedAt': issuedAt.toIso8601String(),
      'activationDeadline': activationDeadline?.toIso8601String(),
      'features': features,
      'nonce': nonce,
    };
  }

  factory LicensePayload.fromMap(Map<String, Object?> map) {
    return LicensePayload(
      product: (map['product'] as String? ?? '').trim(),
      licenseId: (map['licenseId'] as String? ?? '').trim(),
      tier: LicenseTier.fromStorageValue(map['tier'] as String?),
      bindName: (map['bindName'] as String? ?? '').trim(),
      durationDays: map['durationDays'] is int
          ? map['durationDays'] as int
          : int.tryParse('${map['durationDays']}') ?? 0,
      permanent: map['permanent'] == true,
      issuedAt: DateTime.tryParse(map['issuedAt'] as String? ?? '') ??
          DateTime.fromMillisecondsSinceEpoch(0, isUtc: true),
      activationDeadline:
          map['activationDeadline'] == null
              ? null
              : DateTime.tryParse(map['activationDeadline'] as String),
      features: ((map['features'] as List<dynamic>?) ?? const <dynamic>[])
          .map((dynamic item) => item.toString())
          .toList(),
      nonce: (map['nonce'] as String? ?? '').trim(),
    );
  }
}
