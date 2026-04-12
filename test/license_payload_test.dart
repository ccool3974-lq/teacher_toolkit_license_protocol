import 'package:test/test.dart';
import 'package:teacher_toolkit_license_protocol/teacher_toolkit_license_protocol.dart';

void main() {
  test('codec round-trips payload', () {
    final LicensePayload payload = LicensePayload(
      product: licenseProductName,
      licenseId: 'LIC-0001',
      tier: LicenseTier.basic,
      bindName: '张老师',
      durationDays: 180,
      permanent: false,
      issuedAt: DateTime.utc(2026, 4, 1),
      activationDeadline: DateTime.utc(2026, 5, 1, 23, 59, 59),
      features: const <String>['schoolBaseImportExcel'],
      nonce: 'nonce-1',
    );

    final String segment = LicenseCodec.encodePayloadSegment(payload);
    final LicensePayload decoded = LicenseCodec.decodePayloadSegment(segment);

    expect(decoded.product, payload.product);
    expect(decoded.licenseId, payload.licenseId);
    expect(decoded.tier, payload.tier);
    expect(decoded.bindName, payload.bindName);
    expect(decoded.durationDays, payload.durationDays);
    expect(decoded.permanent, payload.permanent);
    expect(decoded.activationDeadline, payload.activationDeadline);
    expect(decoded.features, payload.features);
    expect(decoded.nonce, payload.nonce);
  });
}
