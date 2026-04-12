import 'dart:convert';

import 'license_payload.dart';

class LicenseCodec {
  const LicenseCodec._();

  static String encodePayloadSegment(LicensePayload payload) {
    return base64Url.encode(utf8.encode(jsonEncode(payload.toMap()))).replaceAll('=', '');
  }

  static LicensePayload decodePayloadSegment(String payloadSegment) {
    final Map<String, Object?> payloadMap = jsonDecode(
      utf8.decode(base64Url.decode(base64Url.normalize(payloadSegment))),
    ) as Map<String, Object?>;
    return LicensePayload.fromMap(payloadMap);
  }
}
