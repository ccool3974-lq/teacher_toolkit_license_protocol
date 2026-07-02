import 'license_constants.dart';
import 'license_payload.dart';

class LicensePayloadValidationResult {
  const LicensePayloadValidationResult(this.errors);

  final List<String> errors;

  bool get isValid => errors.isEmpty;
}

class LicensePayloadValidator {
  const LicensePayloadValidator._();

  static LicensePayloadValidationResult validateForIssue(
    LicensePayload payload,
    DateTime now,
  ) {
    return LicensePayloadValidationResult(_validateCommon(payload));
  }

  static LicensePayloadValidationResult validateForActivation(
    LicensePayload payload,
    DateTime now,
  ) {
    final List<String> errors = _validateCommon(payload);

    if (now.isAfter(payload.activationDeadline)) {
      errors.add('activationDeadline has passed');
    }

    return LicensePayloadValidationResult(errors);
  }

  static List<String> _validateCommon(LicensePayload payload) {
    final List<String> errors = <String>[];
    final DateTime epoch = DateTime.fromMillisecondsSinceEpoch(0, isUtc: true);

    if (payload.product != licenseProductName) {
      errors.add('product must be $licenseProductName');
    }
    if (payload.licenseId.trim().isEmpty) {
      errors.add('licenseId must not be empty');
    }
    if (payload.bindName.trim().isEmpty) {
      errors.add('bindName must not be empty');
    }
    if (!payload.permanent && payload.durationDays <= 0) {
      errors.add(
        'durationDays must be greater than 0 for non-permanent licenses',
      );
    }
    if (payload.permanent && payload.durationDays < 0) {
      errors.add('durationDays must not be negative for permanent licenses');
    }
    if (payload.issuedAt.isAtSameMomentAs(epoch)) {
      errors.add('issuedAt must not be the epoch default');
    }
    if (payload.activationDeadline.isBefore(payload.issuedAt)) {
      errors.add('activationDeadline must not be earlier than issuedAt');
    }

    return errors;
  }
}
