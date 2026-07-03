import 'package:test/test.dart';
import 'package:teacher_toolkit_license_protocol/teacher_toolkit_license_protocol.dart';

void main() {
  LicensePayload buildPayload({
    String product = licenseProductName,
    String appVersion = '1.2.3',
    String licenseId = 'LIC-0001',
    String bindName = '张老师',
    String? bindUserCode = 'USER-001',
    int durationDays = 180,
    bool permanent = false,
    DateTime? issuedAt,
    DateTime? activationDeadline,
    String nonce = 'nonce-1',
  }) {
    final DateTime effectiveIssuedAt = issuedAt ?? DateTime.utc(2026, 4, 1);

    return LicensePayload(
      product: product,
      appVersion: appVersion,
      licenseId: licenseId,
      bindName: bindName,
      bindUserCode: bindUserCode,
      durationDays: durationDays,
      permanent: permanent,
      issuedAt: effectiveIssuedAt,
      activationDeadline:
          activationDeadline ?? DateTime.utc(2026, 5, 1, 23, 59, 59),
      nonce: nonce,
    );
  }

  test('codec round-trips payload', () {
    final LicensePayload payload = buildPayload();

    final String segment = LicenseCodec.encodePayloadSegment(payload);
    final LicensePayload decoded = LicenseCodec.decodePayloadSegment(segment);

    expect(decoded.product, payload.product);
    expect(decoded.appVersion, payload.appVersion);
    expect(decoded.licenseId, payload.licenseId);
    expect(decoded.bindName, payload.bindName);
    expect(decoded.bindUserCode, payload.bindUserCode);
    expect(decoded.durationDays, payload.durationDays);
    expect(decoded.permanent, payload.permanent);
    expect(decoded.activationDeadline, payload.activationDeadline);
    expect(decoded.nonce, payload.nonce);
  });

  test('protocol constants use TTK3 version 2', () {
    expect(licenseStructuredPrefix, 'TTK3');
    expect(licenseProtocolVersion, 2);
  });

  test('toMap writes new payload fields without tier or features', () {
    final Map<String, Object?> map = buildPayload(bindUserCode: null).toMap();

    expect(map['product'], licenseProductName);
    expect(map['appVersion'], '1.2.3');
    expect(map['bindUserCode'], isNull);
    expect(map['activationDeadline'], isNotNull);
    expect(map.containsKey('tier'), isFalse);
    expect(map.containsKey('features'), isFalse);
  });

  test(
    'fromMap defaults missing activationDeadline to issuedAt plus 30 days',
    () {
      final LicensePayload payload = LicensePayload.fromMap(<String, Object?>{
        'product': licenseProductName,
        'appVersion': '1.2.3',
        'licenseId': 'LIC-0002',
        'bindName': '李老师',
        'durationDays': 30,
        'permanent': false,
        'issuedAt': DateTime.utc(2026, 4, 1).toIso8601String(),
        'nonce': 'nonce-2',
      });

      expect(payload.activationDeadline, DateTime.utc(2026, 5, 1));
    },
  );

  test('non-permanent license requires positive durationDays', () {
    final LicensePayloadValidationResult result =
        LicensePayloadValidator.validateForIssue(
          buildPayload(durationDays: 0),
          DateTime.utc(2026, 4, 1),
        );

    expect(result.isValid, isFalse);
    expect(
      result.errors,
      contains(
        'durationDays must be greater than 0 for non-permanent licenses',
      ),
    );
  });

  test('payload requires appVersion', () {
    final LicensePayloadValidationResult result =
        LicensePayloadValidator.validateForIssue(
          buildPayload(appVersion: ' '),
          DateTime.utc(2026, 4, 1),
        );

    expect(result.isValid, isFalse);
    expect(result.errors, contains('appVersion must not be empty'));
  });

  test('activation fails after activationDeadline', () {
    final LicensePayloadValidationResult result =
        LicensePayloadValidator.validateForActivation(
          buildPayload(activationDeadline: DateTime.utc(2026, 5, 1)),
          DateTime.utc(2026, 5, 2),
        );

    expect(result.isValid, isFalse);
    expect(result.errors, contains('activationDeadline has passed'));
  });

  test('permanent license allows zero durationDays', () {
    final LicensePayloadValidationResult result =
        LicensePayloadValidator.validateForIssue(
          buildPayload(durationDays: 0, permanent: true),
          DateTime.utc(2026, 4, 1),
        );

    expect(result.isValid, isTrue);
  });

  test('TTK3 payload allows empty bindUserCode', () {
    final LicensePayload payload = buildPayload(bindUserCode: null);
    final LicensePayload decoded = LicenseCodec.decodePayloadSegment(
      LicenseCodec.encodePayloadSegment(payload),
    );

    expect(licenseStructuredPrefix, 'TTK3');
    expect(decoded.bindUserCode, isNull);
  });

  test('decodePayloadSegment throws clear FormatException for bad format', () {
    expect(
      () => LicenseCodec.decodePayloadSegment('not a payload segment'),
      throwsA(
        isA<FormatException>().having(
          (FormatException error) => error.message,
          'message',
          startsWith('Invalid license payload segment'),
        ),
      ),
    );
  });
}
