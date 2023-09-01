import 'package:flutter/cupertino.dart';
import 'package:search_app/common/theme/app_icons.dart';
import 'package:search_app/common/widgets/app_input_field.dart';

class SearchField extends AppInputField {
  const SearchField({
    super.key,
    TextEditingController? controller,
    bool enabled = true,
    String text = '',
    String hint = '',
    Function(String)? onSubmitted,
    Function(String)? onPrefixPressed,
    Function(String)? onSuffixPressed,
  }) : super(
          controller: controller,
          enabled: enabled,
          onSubmitted: onSubmitted,
          maxLength: 256,
          prefixIcon: AppIcons.search,
          onPrefixPressed: onPrefixPressed,
          suffixIcon: AppIcons.close,
          onSuffixPressed: onSuffixPressed,
          textInputAction: TextInputAction.search,
          counterText: '',
          hint: hint,
          text: text,
        );
}
