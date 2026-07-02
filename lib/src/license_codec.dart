import 'dart:convert';

import 'license_payload.dart';

class LicenseCodec {
  const LicenseCodec._();

  static String encodePayloadSegment(LicensePayload payload) {
    return base64Url
        .encode(utf8.encode(jsonEncode(payload.toMap())))
        .replaceAll('=', '');
  }

  static LicensePayload decodePayloadSegment(String payloadSegment) {
    final Object? decoded;
    try {
      decoded = jsonDecode(
        utf8.decode(base64Url.decode(base64Url.normalize(payloadSegment))),
      );
    } on FormatException catch (error) {
      throw FormatException(
        'Invalid license payload segment: ${error.message}',
      );
    }

    if (decoded is! Map<String, Object?>) {
      throw const FormatException(
        'Invalid license payload segment: expected JSON object',
      );
    }

    final Map<String, Object?> payloadMap = decoded;
    return LicensePayload.fromMap(payloadMap);
  }
}
