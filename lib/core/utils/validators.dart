import 'package:ared/core/extensions/non_null_extensions.dart';
import 'package:ared/core/resources/resources.dart';

class Validators {
  static String? notEmptyValidator(String? input) {
    return input.orEmpty.isEmpty ? AppStrings.notEmptyValidator : null;
  }
}
