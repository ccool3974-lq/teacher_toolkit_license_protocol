class LicensePayload {
  const LicensePayload({
    required this.product,
    required this.appVersion,
    required this.licenseId,
    required this.bindName,
    this.bindUserCode,
    required this.durationDays,
    required this.permanent,
    required this.issuedAt,
    required this.activationDeadline,
    required this.nonce,
  });

  final String product;
  final String appVersion;
  final String licenseId;
  final String bindName;
  final String? bindUserCode;
  final int durationDays;
  final bool permanent;
  final DateTime issuedAt;
  final DateTime activationDeadline;
  final String nonce;

  Map<String, Object?> toMap() {
    return <String, Object?>{
      'product': product,
      'appVersion': appVersion,
      'licenseId': licenseId,
      'bindName': bindName,
      'bindUserCode': bindUserCode,
      'durationDays': durationDays,
      'permanent': permanent,
      'issuedAt': issuedAt.toIso8601String(),
      'activationDeadline': activationDeadline.toIso8601String(),
      'nonce': nonce,
    };
  }

  factory LicensePayload.fromMap(Map<String, Object?> map) {
    final DateTime issuedAt =
        DateTime.tryParse(map['issuedAt'] as String? ?? '') ??
        DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);
    final DateTime activationDeadline =
        DateTime.tryParse(map['activationDeadline'] as String? ?? '') ??
        issuedAt.add(const Duration(days: 30));

    return LicensePayload(
      product: (map['product'] as String? ?? '').trim(),
      appVersion: (map['appVersion'] as String? ?? '').trim(),
      licenseId: (map['licenseId'] as String? ?? '').trim(),
      bindName: (map['bindName'] as String? ?? '').trim(),
      bindUserCode: (map['bindUserCode'] as String?)?.trim(),
      durationDays: map['durationDays'] is int
          ? map['durationDays'] as int
          : int.tryParse('${map['durationDays']}') ?? 0,
      permanent: map['permanent'] == true,
      issuedAt: issuedAt,
      activationDeadline: activationDeadline,
      nonce: (map['nonce'] as String? ?? '').trim(),
    );
  }
}
